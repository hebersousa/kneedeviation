//
//  Patient.swift
//  BasicAR
//
//  Created by heber on 17/04/20.
//  Copyright © 2020 heber. All rights reserved.
//

import Foundation

struct Patient: Codable{
    //let id : Int
    var id : String? = ""
    var name : String
    var age : Int
    var gender : String
    
    init(name: String, age: Int, gender: String) {
        self.name = name
        self.age = age
        self.gender = gender
        
        
    }
}
