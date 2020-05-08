//
//  EncodableExtension.swift
//  BasicAR
//
//  Created by heber on 17/04/20.
//  Copyright © 2020 heber. All rights reserved.
//

import Foundation

enum MyError: Error {
    case encodingError
}
extension Encodable {
    
    func toJson() throws ->[String : Any] {
        let objectData = try JSONEncoder().encode(self)
        let jsonObject = try JSONSerialization.jsonObject(with: objectData, options:[] )
        guard var json = jsonObject as? [String: Any] else {throw MyError.encodingError}
        
        return json
        
    }
}
