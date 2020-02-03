//
//  ViewController.swift
//  BasicAR
//
//  Created by heber on 23/01/20.
//  Copyright © 2020 heber. All rights reserved.
//

import UIKit
import SpriteKit
import ARKit

class ViewController: UIViewController, ARSKViewDelegate, ARSessionDelegate {
    
    @IBOutlet var sceneView: ARSKView!
   
    @IBOutlet weak var button: UIButton!
    var ciimage : CIImage = CIImage()
    var height : CGFloat = 0.0
    var width : CGFloat = 0.0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        sceneView.session.delegate = self
        
        // Show statistics such as fps and node count
        sceneView.showsFPS = true
        sceneView.showsNodeCount = true
    
        button.frame = CGRect(x: 160, y: 160, width: 40, height: 40)
        button.backgroundColor = UIColor.white
        button.layer.cornerRadius = 0.5 * button.bounds.size.width/2
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.borderWidth = 1.0
        button.clipsToBounds = true
        button.center.y = self.view.bounds.size.height - 60
        button.center.x = self.view.center.x
        
        
    
        
        
        // Load the SKScene from 'Scene.sks'
        if let scene = SKScene(fileNamed: "Scene") {

            scene.size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                        
            sceneView.presentScene(scene)
            var size = sceneView.scene?.size
            print( "SCENE \(size?.width)  \(size?.height) ")
            

            //UIScreen.main.bounds.width
             size = sceneView.scene?.size
            print( "SCENE \(size?.width)  \(size?.height) ")
            
            var point = CGPoint()
            point.x = -(size?.width)!/2
            point.y = -(size?.height)!/2
            
            addPoint(point: point)
            print( "POINT \(point.x)  \(point.y) ")
        }
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("* viewWillAppear *")
        // Create a session configuration
        let configuration = ARBodyTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
        
        let yourline = SKShapeNode()
        let pathToDraw = CGMutablePath()
        pathToDraw.move(to: CGPoint(x: 0.0, y: 0.0))
        pathToDraw.addLine(to: CGPoint(x: 1.0, y: 1.0))
        yourline.path = pathToDraw
        yourline.strokeColor = SKColor.red
        sceneView.scene?.addChild(yourline)
    }
    
    func addLine( point1 : CGPoint, point2 : CGPoint){
        
        let line = SKShapeNode()
        let pathToDraw = CGMutablePath()
        pathToDraw.move(to: point1)
        pathToDraw.addLine(to: point2)
        line.path = pathToDraw
        line.strokeColor = SKColor.red
        sceneView.scene?.addChild(line)
    }
    
    
    func addPoint(point : CGPoint){
        
        
        
        let circle = SKShapeNode(circleOfRadius: 5)
        
        circle.position = point
        circle.fillColor = SKColor.yellow
        sceneView.scene?.addChild(circle)
        
        
        
    }

    func addLabel(point : CGPoint, text : String){
        let label = SKShapeNode(rectOf: CGSize(width: 80, height: 45), cornerRadius: 5)
        label.fillColor = UIColor.white
        
        let textNode = SKLabelNode()
        textNode.numberOfLines = 2
        textNode.verticalAlignmentMode = .center
        
        textNode.fontSize = 16
        textNode.fontColor = UIColor.black
        textNode.text = text
        label.position = point
        label.strokeColor = UIColor.black
        
        label.addChild(textNode)
        
        
        sceneView.scene?.addChild(label)
        
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    // MARK: - ARSKViewDelegate
    
    func view(_ view: ARSKView, nodeFor anchor: ARAnchor) -> SKNode? {
        // Create and configure a node for the anchor added to the view's session.
        
        //print("view metod")
        if let bodyAnchor = anchor as? ARBodyAnchor {
            // obj is a string array. Do something with stringArray
            
            return nil
        }
        else {
            let labelNode = SKLabelNode(text: "👾")
            labelNode.horizontalAlignmentMode = .center
            labelNode.verticalAlignmentMode = .center
            return labelNode;
        }
        
        
        
    }
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
    
    func cgImage(from ciImage: CIImage) -> CGImage? {
        let context = CIContext(options: nil)
        return context.createCGImage(ciImage, from: ciImage.extent)
    }
    
    @IBAction func buttonAction(_ sender: Any) {
        
        let cgimage = cgImage(from: ciimage)
        //var uiImage = UIImage(cgImage: cgimage!)
        var uiImage = sceneView.largeContentImage!
        let imageSaver = ImageSaver()
        imageSaver.successHandler = {
            print("Success!")
        }

        imageSaver.errorHandler = {
            print("Oops: \($0.localizedDescription)")
        }
        imageSaver.writeToPhotoAlbum(image: uiImage)
    }
    
   
    
    func session(_ session: ARSession, didUpdate frame: ARFrame){         // Accessing ARBody2D Object from ARFrame
        sceneView.scene?.removeAllChildren()
        
        height = (sceneView.scene?.size.height)!
        width = (sceneView.scene?.size.width)!
        
        let imageBuffer = frame.capturedImage
        ciimage = CIImage(cvImageBuffer: imageBuffer)
        
        let orientation = self.sceneView.window!.windowScene!.interfaceOrientation
                
        let imageSize = CGSize(
            width:  CVPixelBufferGetWidth(imageBuffer),
            height: CVPixelBufferGetHeight(imageBuffer))
                        
        let viewPortSize = sceneView.bounds.size

        
        if let person = frame.detectedBody as? ARBody2D {
            
            
         drawBody(body: person, viewPortSize: viewPortSize, imageSize: imageSize, orientation: orientation)
         
         drawLabels(body: person, viewPortSize: viewPortSize, imageSize: imageSize, orientation: orientation)
            
        }
        
        
        
    }
    
    
    func drawBody(body :ARBody2D, viewPortSize:CGSize, imageSize: CGSize, orientation:UIInterfaceOrientation){
        
        let jointBody = JointBody(body: body)
        var transform = TransformPointToView( viewPortSize: viewPortSize, imageSize: imageSize, orientation: orientation)

             let head = transform.pointToView(point: jointBody.head)
             let torax = transform.pointToView(point: jointBody.torax)
             let root = transform.pointToView(point: jointBody.root)
             let leftShoulder = transform.pointToView(point: jointBody.leftShoulder)
             let rightShoulder = transform.pointToView(point: jointBody.rightShoulder)
             let leftElbow = transform.pointToView(point: jointBody.leftElbow)
             let rightElbow = transform.pointToView(point: jointBody.rightElbow)
             let leftHand = transform.pointToView(point: jointBody.leftHand)
             let rightHand = transform.pointToView(point: jointBody.rightHand)
             let leftHip = transform.pointToView(point: jointBody.leftHip)
             let rightHip = transform.pointToView(point: jointBody.rightHip)
             let leftKnee = transform.pointToView(point: jointBody.leftKnee)
             let rightKnee = transform.pointToView(point: jointBody.rightKnee)
             let leftFoot = transform.pointToView(point: jointBody.leftFoot)
             let rightFoot = transform.pointToView(point: jointBody.rightFoot)
             addLine(point1: head, point2: torax)
             addLine(point1: torax, point2: leftShoulder)
             addLine(point1: leftShoulder, point2: leftElbow)
             addLine(point1: leftElbow, point2: leftHand)
             addLine(point1: torax, point2: rightShoulder)
             addLine(point1: rightShoulder, point2: rightElbow)
             addLine(point1: rightElbow, point2: rightHand)
             addLine(point1: torax, point2: root)
             addLine(point1: root, point2: leftHip)
             addLine(point1: leftHip, point2: leftKnee)
             addLine(point1: leftKnee, point2: leftFoot)
             addLine(point1: root, point2: rightHip)
             addLine(point1: rightHip, point2: rightKnee)
             addLine(point1: rightKnee, point2: rightFoot)
        
            for joint in jointBody.joints{
                
                let p = transform.pointToView(point: joint)
                addPoint(point: p)
            }
        
            
    }
    
    
    
    
    func drawLabels(body :ARBody2D, viewPortSize:CGSize, imageSize: CGSize, orientation:UIInterfaceOrientation){
        
        let jointBody = JointBody(body: body)
        var transform = TransformPointToView( viewPortSize: viewPortSize, imageSize: imageSize, orientation: orientation)

        let leftKnee = transform.pointToView(point: jointBody.leftKnee)
        let rightKnee = transform.pointToView(point: jointBody.rightKnee)
        let leftHip = transform.pointToView(point: jointBody.leftHip)
        let rightHip = transform.pointToView(point: jointBody.rightHip)
        let leftFoot = transform.pointToView(point: jointBody.leftFoot)
        let rightFoot = transform.pointToView(point: jointBody.rightFoot)
        
        var lPosition = leftKnee
             lPosition.x += 50
             var rPosition = rightKnee
             rPosition.x -= 50
             
             let rightAngle = Angle.right(hip: rightHip, knee: rightKnee, foot: rightFoot)
             let leftAngle = Angle.left(hip: leftHip, knee: leftKnee, foot: leftFoot)
             
             let ltype = leftAngle.devianType()
             var lang = leftAngle.angle()
             let rtype = rightAngle.devianType()
             var rang = rightAngle.angle()
             
             if lang != nil, !lang.isNaN {
                 lang = Float(floor(10*lang)/10) // leaves on first three decimal places
                 let leftText = " \( lang)\n\(ltype)"
                 addLabel(point: lPosition, text: leftText)
             }
             
             if rang != nil, !rang.isNaN {
                 rang = Float(floor(10*rang)/10) // leaves on first three decimal places
                 let rightText = " \( rang)\n\(rtype)"
                 addLabel(point: rPosition, text: rightText)
                 
             }
    }
    
    
    
    func simd2Point( simd : simd_float2)->CGPoint{
        var point = CGPoint()
        point.x = CGFloat(simd[0])
        point.y = CGFloat(simd[1])
        return point
    }
}
