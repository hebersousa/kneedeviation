//
//  SnapshotExtension.swift
//  BasicAR
//
//  Created by heber on 17/04/20.
//  Copyright © 2020 heber. All rights reserved.
//

import Foundation
import FirebaseFirestore

extension DocumentSnapshot {
    
    func  decode<T:  Decodable>(as objectType: T.Type, includingId: Bool = true) throws -> T {
        var documentJson = data()
        if includingId {
            documentJson?["id"] = documentID
        }
        let documentData = try  JSONSerialization.data(withJSONObject: documentJson, options: [])
        let decodedObject  = try JSONDecoder().decode(objectType, from: documentData)
        
        return decodedObject
        
    }
}


