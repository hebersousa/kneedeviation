//
//  DetailController.swift
//  BasicAR
//
//  Created by heber on 14/05/20.
//  Copyright © 2020 heber. All rights reserved.
//

import UIKit
import SpriteKit

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
    
    func addLine( point1 : CGPoint, point2 : CGPoint){
          
          let line = SKShapeNode()
          let pathToDraw = CGMutablePath()
          pathToDraw.move(to: point1)
          pathToDraw.addLine(to: point2)
          line.path = pathToDraw
          line.strokeColor = SKColor.red
        
        //  imageView.scene?.addChild(line)
      }
    /*
    func drawBody(body :ARBody2D, viewPortSize:CGSize, imageSize: CGSize, orientation:UIInterfaceOrientation){
           
           self.jointBody = JointBody(body: body, imageSize: imageSize)
           let transform = TransformBodyPositionToView(body: self.jointBody!, viewPortSize: viewPortSize, imageSize: imageSize, orientation: orientation)

           let body = transform.body
           
           addLine(point1: body.head, point2: body.torax)
           addLine(point1: body.torax, point2: body.leftShoulder)
           addLine(point1: body.leftShoulder, point2: body.leftElbow)
           addLine(point1: body.leftElbow, point2: body.leftHand)
           addLine(point1: body.torax, point2: body.rightShoulder)
           addLine(point1: body.rightShoulder, point2: body.rightElbow)
           addLine(point1: body.rightElbow, point2: body.rightHand)
           addLine(point1: body.torax, point2: body.root)
           addLine(point1: body.root, point2: body.leftHip)
           addLine(point1: body.leftHip, point2: body.leftKnee)
           addLine(point1: body.leftKnee, point2: body.leftFoot)
           addLine(point1: body.root, point2: body.rightHip)
           addLine(point1: body.rightHip, point2: body.rightKnee)
           addLine(point1: body.rightKnee, point2: body.rightFoot)
           
           let joints = transform.joints
           
           for point in joints{
               addPoint(point: point)
           }
       }
    */


}
