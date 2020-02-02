//
//  ImageSaver.swift
//  BasicAR
//
//  Created by heber on 01/02/20.
//  Copyright © 2020 heber. All rights reserved.
//
import UIKit
import Foundation



class ImageSaver: NSObject {
    
     var successHandler: (() -> Void)?
     var errorHandler: ((Error) -> Void)?
    
    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveError), nil)
    }

    @objc func saveError(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
     
        if let error = error {
            errorHandler?(error)
        } else {
            successHandler?()
        }
        
    }
}
