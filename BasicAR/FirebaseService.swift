//
//  FirestoreService.swift
//  BasicAR
//
//  Created by heber on 17/04/20.
//  Copyright © 2020 heber. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestore

class FirebaseService{
    private init(){}
    static let shared = FirebaseService()
    
    func configure() {
        FirebaseApp.configure()
    }
    
    
    
    func create<T: Encodable>(for encondabelObject: T) {
       
        do {
            let json =  try encondabelObject.toJson()
            let patientsReference = Firestore.firestore().collection("patients")
                   patientsReference.addDocument(data: json)
            
        } catch {
            print(error)
        }
        
        // let parameters : [String: Any] = ["id":1, "name":"Maria","age":32, "gender":"F" ]
        
       // let patientsReference = Firestore.firestore().collection("patients")
       // patientsReference.addDocument(data: parameters)
    }
    
    func read<T: Decodable>(returning objectType: T.Type, completion: @escaping ([T])->Void) {
        let patientsReference = Firestore.firestore().collection("patients")
        
        patientsReference.addSnapshotListener { (snapshot, _) in
            guard let snapshot = snapshot else { return }
            do {
                var objects = [T]()
                for document in snapshot.documents {
                    let object = try  document.decode(as:  objectType.self)
                    objects.append(object)
                   // print(document.data())
                }
                
                completion(objects)
            } catch {
                print(error)
            }
        }
    }
    
    func update() {
        let patientsReference = Firestore.firestore().collection("patients")
        patientsReference.document("d1Ct4IyEQPAOXESr1l0O").setData(["id":01, "name":"Maria Eduarda"])
        
    }
    
    func delete() {
        
    }
}
