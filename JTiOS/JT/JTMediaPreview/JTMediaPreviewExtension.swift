//
//  JTMediaPreviewExtension.swift
//  JTiOS
//
//  Created by JT on 2018/1/29.
//  Copyright © 2018年 JT. All rights reserved.
//
import Alamofire
extension JTMediaPreview {
    
    func setNoImage(index: Int) {
        if let no = Assets.shareInstance.noImage2() {
            self.setDataImage(at: index, image: no)
        }
    }
    func setVideoPrevew(index: Int) {
        let image = Assets.shareInstance.play3()
        guard let img = image else {
            setNoImage(index: index)
            return
        }
        self.setDataImage(at: index, image: img)
    }
    
    func setImagePreview(index: Int, file: Object_File) {
        guard let typenumInt = file.typenum else { return }
        let fileTypenum = FileTypenum(rawValue: typenumInt)
        guard let fileType = fileTypenum else { return }
        let imagePrefix = ImagePrefix.Minimum
        guard let fridInt = file.frid else { return }
        guard let filename = file.path else { return }
        let url = SystemFile.shareInstance.getFileURL(typenum: fileType, frid: Int64(fridInt), filename: imagePrefix.rawValue + filename)
        if FileManage.shareInstance.fileExist(atPath: url.path), let image = UIImage(contentsOfFile: url.path) {
            self.setDataImage(at: index, image: image)
        } else {
            let req = RequestObject_FileDownload(typenum: fileType, frid: fridInt, filename: filename, prefix: imagePrefix, destination: { temporaryUrl, response in
                return (url, DownloadRequest.DownloadOptions.removePreviousFile)
            })
            WebFile.shareInstance.saveFile(requestObject: req) {
                [weak self] success, msg in
                if success, let image = UIImage(contentsOfFile: url.path)  {
                    self?.setDataImage(at: index, image: image)
                } else {
                    self?.setNoImage(index: index)
                }
            }
        }
    }
    
    func setFilesToJTMediaPreview(datas: [Object_File]?, jtMediaPreview: JTMediaPreview?) {
        guard let files = datas else { return }
        let count = files.count
        guard count > 0 else { return }
        var ss = [JTMediaPreviewData]()
        for _ in 0 ..< count {
            ss.append(JTMediaPreviewData())
        }
        jtMediaPreview?.addData(dataRange: ss)
        for index in 0 ..< count {
            let file = files[index]
            guard let contentType = file.contenttype else { continue }
            if contentType.containsCaseInsensitive(other: "image") {
                jtMediaPreview?.setImagePreview(index: index, file: file)
            } else if contentType.containsCaseInsensitive(other: "video") {
                jtMediaPreview?.setVideoPrevew(index: index)
            } else {
                if let unknown = Assets.shareInstance.unknownFile() {
                    jtMediaPreview?.setDataImage(at: index, image: unknown)
                }
            }
        }
    }
    
}
