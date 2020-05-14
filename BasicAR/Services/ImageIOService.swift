//
//  ImageIOService.swift
//  BasicAR
//
//  Created by heber on 08/05/20.
//  Copyright © 2020 heber. All rights reserved.
//

import Foundation
import UIKit

class ImageIOService {
    
    private init() { }
    
    enum StorageType {
             case userDefaults
             case fileSystem
         }
       
        static func store(image: UIImage,
                             forKey key: String,
                             withStorageType storageType: StorageType) {
              if let pngRepresentation = image.pngData() {
                  switch storageType {
                  case .fileSystem:
                      if let filePath = filePath(forKey: key) {
                          do {
                              try pngRepresentation.write(to: filePath,
                                                          options: .atomic)
                          } catch let err {
                              print("Saving results in error: ", err)
                          }
                      }
                  case .userDefaults:
                      UserDefaults.standard.set(pngRepresentation,
                                                forKey: key)
                  }
              }
          }
          
         static func retrieveImage(forKey key: String,
                                     inStorageType storageType: StorageType) -> UIImage? {
              switch storageType {
              case .fileSystem:
                  if let filePath = filePath(forKey: key),
                      let fileData = FileManager.default.contents(atPath: filePath.path),
                      let image = UIImage(data: fileData) {
                      return image
                  }
              case .userDefaults:
                  if let imageData = UserDefaults.standard.object(forKey: key) as? Data,
                      let image = UIImage(data: imageData) {
                      return image
                  }
              }
              
              return nil
          }
    
    static func deleteImage(forKey key: String) -> Void {
        
                    if let filePath = filePath(forKey: key){
                        do{
                            try FileManager.default.removeItem(at: filePath)
                        }catch{
                            print("comportamento inesperado")
                        }
                        
                    }
    }
        
        
        
    
       
       static func filePath(forKey key: String) -> URL? {
           let fileManager = FileManager.default
           guard let documentURL = fileManager.urls(for: .documentDirectory,
                                                    in: .userDomainMask).first else {
                                                       return nil
           }
           
           return documentURL.appendingPathComponent(key + ".png")
       }
       
    
}
