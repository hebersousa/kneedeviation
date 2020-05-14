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
    
    func countDocuments(completion: @escaping (Int)->Void ) {
        let patientsReference = Firestore.firestore().collection("patients")
        patientsReference.getDocuments()
             {
                 (querySnapshot, err) in

                 if let err = err
                 {
                     print("Error getting documents: \(err)");
                 }
                 else
                 {
                    completion(querySnapshot!.count)
                     
                 }
             }
    }
    
    func create<T: Encodable>(for encondabelObject: T/*, returning objectType: T*/, completion: @escaping (String)->Void)  {
       
        do {
            let json =  try encondabelObject.toJson()
            let patientsReference = Firestore.firestore().collection("patients")
            
            var ref: DocumentReference? = nil
            
             ref = patientsReference.addDocument(data: json){ err in
                if let err = err {
                    print("Error adding document: \(err)")
                } else {
                    do {
                        
                       // let object = try  ref!.decode(as:  T)
                        completion(ref!.documentID)
                        
                    }catch {
                        
                    }
                   
                    print("Document added with ID: \(ref!.documentID)")
                    
                }
            }
            
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
                    print(document.data())
                    print(object)
                }
                
                completion(objects)
            } catch {
                print(error)
            }
        }
    }
    
    func update<T: Encodable &  Identifiable>(for encodableObject: T) {
        
        do{
            let patientsReference = Firestore.firestore().collection("patients")
            let json = try encodableObject.toJson()
            guard let  id = encodableObject.id else { throw MyError.encodingError }
            patientsReference.document(id).setData(json)
            
        }catch{
            print(error)
        }
        
        //let patientsReference = Firestore.firestore().collection("patients")
        //patientsReference.document("d1Ct4IyEQPAOXESr1l0O").setData(["id":01, "name":"Maria Eduarda"])
    }
    
    func delete<T: Identifiable >(_ identifiableObject: T) {
        do{
             
            guard let id = identifiableObject.id else  { throw MyError.encodingError }
            let patientsReference = Firestore.firestore().collection("patients")
            patientsReference.document(id).delete()
            
        } catch {
            print(error)
        }
        
    }
}
