//
//  DetailController.swift
//  BasicAR
//
//  Created by heber on 14/05/20.
//  Copyright © 2020 heber. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var patient: Patient = Patient(name: "", age: 0, gender: "")
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var nome: UILabel!
    
    @IBOutlet weak var leftQAngle: UILabel!
    @IBOutlet weak var rightQAngle: UILabel!
    @IBOutlet weak var idade: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.nome.text = " \(patient.name)"
        self.idade.text = " \(patient.age)  Anos"
        
        if let angle = patient.leftAngle {
            var vangle = Float(floor(10*angle.angle())/10)
            self.leftQAngle.text = " Left \(vangle)  \(angle.devianType())"
        } else {
            self.leftQAngle.text = ""
        }

        if let angle = patient.rightAngle {
            var vangle = Float(floor(10*angle.angle())/10)
            self.rightQAngle.text = " Right \(vangle)  \(angle.devianType())"
        } else {
            self.rightQAngle.text = ""
        }
        
        
        if(patient.id != nil){
            
            DispatchQueue.global(qos: .background).async {
                let key = String(self.patient.order)
                if let img = ImageIOService.retrieveImage(forKey: key, inStorageType:.fileSystem){
                           
                           DispatchQueue.main.async {
                                self.imageView.image = UIImage(cgImage: img.cgImage!, scale: img.scale, orientation: .right)
                                }
                        }
        }
        // Do any additional setup after loading the view.
    }
        
    }
    


}
