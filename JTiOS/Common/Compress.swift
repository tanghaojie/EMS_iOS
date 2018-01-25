//
//  Compress.swift
//  JTiOS
//
//  Created by JT on 2018/1/24.
//  Copyright © 2018年 JT. All rights reserved.
//
class Compress {
    static let shareInstance = Compress()
    private init() {}
    
    func image(image: UIImage, maxLength: CGFloat = 1280) -> UIImage {
        let originW = image.size.width
        let originH = image.size.height
        let scale = originW / originH
        var sizeChange = CGSize()
        
        guard originW > maxLength || originH > maxLength else { return image }
        
        if scale > 0.5 && scale <= 1 {
            let h = maxLength
            let w = h * scale
            sizeChange = CGSize(width: w, height: h)
        } else if scale > 1 && scale <= 2 {
            let w = maxLength
            let h = w / scale
            sizeChange = CGSize(width: w, height: h)
        } else if originW > maxLength && originH > maxLength {
            if scale > 2 {
                let h = maxLength
                let w = h * scale
                sizeChange = CGSize(width: w, height: h)
            } else if scale < 0.5{
                let w = maxLength
                let h = w / scale
                sizeChange = CGSize(width: w, height: h)
            } else { return image }
        } else { return image }
        UIGraphicsBeginImageContext(sizeChange)
        image.draw(in: CGRect(x: 0, y: 0, width: sizeChange.width, height: sizeChange.height))
        let newImg = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImg == nil ? image : newImg!
    }

    func video(inUrl: URL, outUrl: URL, handler: ((AVAssetExportSessionStatus) -> Void)? = nil) {
        let asset = AVURLAsset(url: inUrl)
        let exportSession = AVAssetExportSession(asset: asset, presetName: AVAssetExportPresetMediumQuality)
        guard let es = exportSession else { return }
        es.shouldOptimizeForNetworkUse = true
        es.outputURL = outUrl
        es.outputFileType = .mp4
        es.exportAsynchronously {
            let status = es.status
            if let h = handler {
                h(status)
            }
        }
    }
    
}
