//
//  AlertService.swift
//  BasicAR
//
//  Created by heber on 17/04/20.
//  Copyright © 2020 heber. All rights reserved.
//

import Foundation


import UIKit

class AlertService {
    
    private init() {}
    
    static func add(in vc: UIViewController, completion: @escaping (Patient) -> Void) {
        let alert = UIAlertController(title: "Dados do Paciente", message: nil, preferredStyle: .alert)
        alert.addTextField { (nameTF) in
            nameTF.placeholder = "Nome"
        }
        alert.addTextField { (ageTF) in
            ageTF.placeholder = "Idade"
            ageTF.keyboardType = .numberPad
        }
        let add = UIAlertAction(title: "OK", style: .default) { _ in
            guard
                let name = alert.textFields?.first?.text,
                let ageString = alert.textFields?.last?.text,
                let age = Int(ageString)
                else {
                    
                    return }
            let patient = Patient( name: name, age: age , gender: "M")
            completion(patient)
           
        }
        alert.addAction(add)
        vc.present(alert, animated: true)
    }
    
    
    
    
    static func update(_ patient: Patient, in vc: UIViewController, completion: @escaping (Patient) -> Void) {
        let alert = UIAlertController(title: "Update User", message: nil, preferredStyle: .alert)
        alert.addTextField { (ageTF) in
            ageTF.placeholder = "Age"
            ageTF.keyboardType = .numberPad
            ageTF.text = String(patient.age)
        }
        let update = UIAlertAction(title: "Update", style: .default) { _ in
            guard
                let name = alert.textFields?.first?.text,
                let ageString = alert.textFields?.last?.text,
                let age = Int(ageString)
                else { return }
            
            var newPatient = patient
            newPatient.age = age
            newPatient.name = name
            
            completion(newPatient)
            
            
        }
        alert.addAction(update)
        vc.present(alert, animated: true)
    }
    
}
