//
//  JTMediaPreviewExtension.swift
//  JTiOS
//
//  Created by JT on 2018/1/29.
//  Copyright © 2018年 JT. All rights reserved.
//
import Alamofire
import Moya
extension JTMediaPreview {
    
    private func setNoImage(index: Int) {
        if let no = Assets.shareInstance.noImage2() {
            setDataImage(at: index, image: no)
        }
    }
    private func setVideoPrevew(index: Int) {
        let image = Assets.shareInstance.play3()
        guard let img = image else {
            setNoImage(index: index)
            return
        }
        setDataImage(at: index, image: img)
    }
    private func setImagePreview(index: Int, file: Object_File, handler: ((Int, Object_File, URL) -> ())? = nil) {
        guard let typenumInt = file.typenum else { return }
        let fileTypenum = FileTypenum(rawValue: typenumInt)
        guard let fileType = fileTypenum else { return }
        let imagePrefix = ImagePrefix.Minimum
        guard let fridInt = file.frid else { return }
        guard let filename = file.path else { return }
        let url = SystemFile.shareInstance.getFileURL(typenum: fileType, frid: Int64(fridInt), filename: imagePrefix.rawValue + filename)
        if FileManage.shareInstance.fileExist(atPath: url.path), let image = UIImage(contentsOfFile: url.path) {
            setDataImage(at: index, image: image)
            guard let h = handler else { return }
            h(index, file, url)
        } else {
            let req = RequestObject_FileDownload(typenum: fileType, frid: fridInt, filename: filename, prefix: imagePrefix, destination: { temporaryUrl, response in
                return (url, DownloadRequest.DownloadOptions.removePreviousFile)
            })
            let _ = WebFile.shareInstance.saveFile(requestObject: req) {
                [weak self] success, msg in
                if success, let image = UIImage(contentsOfFile: url.path)  {
                    self?.setDataImage(at: index, image: image)
                    guard let h = handler else { return }
                    h(index, file, url)
                } else {
                    self?.setNoImage(index: index)
                }
            }
        }
    }
    
    private func getOriginFile(index: Int, file: Object_File, progress: ProgressBlock? = nil, handler: ((URL?) -> ())? = nil) -> Cancellable? {
        guard let typenumInt = file.typenum else { return nil }
        let fileTypenum = FileTypenum(rawValue: typenumInt)
        guard let fileType = fileTypenum else { return nil }
        guard let fridInt = file.frid else { return nil }
        guard let filename = file.path else { return nil }
        let url = SystemFile.shareInstance.getFileURL(typenum: fileType, frid: Int64(fridInt), filename: filename)
        if FileManage.shareInstance.fileExist(atPath: url.path) {
            guard let h = handler else { return nil }
            h(url)
        } else {
            let req = RequestObject_FileDownload(typenum: fileType, frid: fridInt, filename: filename, prefix: ImagePrefix.Origin, destination: { temporaryUrl, response in
                return (url, DownloadRequest.DownloadOptions.removePreviousFile)
            })
            return WebFile.shareInstance.saveFile(requestObject: req, progress: progress) {
                success, _ in
                if success {
                    guard let h = handler else { return }
                    h(url)
                } else {
                    guard let h = handler else { return }
                    h(nil)
                }
            }
        }
        return nil
    }
    
    func setFilesToJTMediaPreview(datas: [Object_File]?, progress: ProgressBlock? = nil, handler: (([JTMediaCollectionViewCellDatas])->())? = nil) {
        guard let files = datas else { return }
        let count = files.count
        guard count > 0 else { return }
        var ss = [JTMediaPreviewData]()
        var datas = [JTMediaCollectionViewCellDatas]()
        for _ in 0 ..< count {
            ss.append(JTMediaPreviewData())
            datas.append(JTMediaCollectionViewCellDatas(previewData: nil))
        }
        addData(dataRange: ss)
        for index in 0 ..< count {
            let file = files[index]
            guard let contentType = file.contenttype else { continue }
            if contentType.containsCaseInsensitive(other: "image") {
                setImagePreview(index: index, file: file) {
                    [weak self] index, objFile, url in
                    let p = JTMediaCollectionViewCellDatas.JTMediaCollectionViewCellData(url: url, type: .Image)
                    datas[index].previewData = p
                    datas[index].needData = {
                        progress, handler in
                        self?.getOriginFile(index: index, file: objFile, progress: progress) {
                            url in
                            if let u = url {
                                let r = JTMediaCollectionViewCellDatas.JTMediaCollectionViewCellData(url: u, type: JTMediaCollectionViewCellDatas.JTMediaCollectionViewCellDatasType.Image)
                                handler(r)
                            }
                        }
                    }
                }
            } else if contentType.containsCaseInsensitive(other: "video") {
                setVideoPrevew(index: index)
                let p = JTMediaCollectionViewCellDatas.JTMediaCollectionViewCellData(url: nil, type: .VideoCover)
                datas[index].previewData = p
                datas[index].needData = {
                    [weak self] progress, handler in
                    self?.getOriginFile(index: index, file: file, progress: progress) {
                        url in
                        if let u = url {
                            let r = JTMediaCollectionViewCellDatas.JTMediaCollectionViewCellData(url: u, type: JTMediaCollectionViewCellDatas.JTMediaCollectionViewCellDatasType.Video)
                            handler(r)
                        }
                    }
                }
            } else {
                if let unknown = Assets.shareInstance.unknownFile() {
                    setDataImage(at: index, image: unknown)
                    let p = JTMediaCollectionViewCellDatas.JTMediaCollectionViewCellData(url: nil, type: .Unknown)
                    datas[index].data = p
                }
            }
        }
        if let hh = handler {
            hh(datas)
        }
    }
    
}
