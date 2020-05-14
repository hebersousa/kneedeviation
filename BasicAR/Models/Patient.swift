//
//  Patient.swift
//  BasicAR
//
//  Created by heber on 17/04/20.
//  Copyright © 2020 heber. All rights reserved.
//

import Foundation
import SpriteKit

protocol Identifiable{
    
    var id: String? { get set }
}

struct Patient: Codable, Identifiable{
    //let id : Int
    var id : String? = ""
    var name : String
    var age : Int
    var gender : String
    var order : Int
    var leftAngle: Angle?
    var rightAngle: Angle?
    
    init(name: String, age: Int, gender: String) {
        self.name = name
        self.age = age
        self.gender = gender
        self.order = 0
        self.leftAngle = nil
        self.rightAngle = nil
        
    }
}
