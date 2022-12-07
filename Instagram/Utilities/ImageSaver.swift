//
//  ImageSaver.swift
//  Instagram
//
//  Created by lhduc on 06/12/2022.
//

import SwiftUI

class ImageSaver: NSObject {
    var successHandler: (() -> Void)?
    var errorHandler: ((Error) -> Void)?
    
    init(successHandler: (() -> Void)? = nil, errorHandler: ((Error) -> Void)? = nil) {
        self.successHandler = successHandler
        self.errorHandler = errorHandler
    }
    
    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveCompleted), nil)
    }

    @objc func saveCompleted(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            errorHandler?(error)
            print("Error, something was wrong!")
            return
        }
        
        successHandler?()
        print("Save finished!")
    }
}
