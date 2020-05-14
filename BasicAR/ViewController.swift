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
import Photos


class ViewController: UIViewController, ARSKViewDelegate, ARSessionDelegate {
    
    enum StorageType {
        case userDefaults
        case fileSystem
    }

    
    @IBOutlet var sceneView: ARSKView!
   
    @IBOutlet weak var patienceButton: UIButton!
    @IBOutlet weak var button: UIButton!
    var ciimage : CIImage = CIImage()
    var height : CGFloat = 0.0
    var width : CGFloat = 0.0
    var countFrames = 1000.0
    var rightAngle : Angle = Angle()
    var leftAngle : Angle = Angle()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        self.navigationController?.isNavigationBarHidden = true
        // Set the view's delegate
        sceneView.delegate = self
        sceneView.session.delegate = self
        
        // Show statistics such as fps and node count
        sceneView.showsFPS = true
        sceneView.showsNodeCount = true
    
        estilizeButton( button)
        estilizeButton( patienceButton)
        
        /*
        button.frame = CGRect(x: 160, y: 160, width: 40, height: 40)
        button.backgroundColor = UIColor.white
        button.layer.cornerRadius = 0.5 * button.bounds.size.width/2
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.borderWidth = 1.0
        button.clipsToBounds = true
        */
       // button.center.y = self.view.bounds.size.height - 60
       // button.center.x = self.view.center.x
        
        
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
        
        self.navigationController?.isNavigationBarHidden = true
        // If the iOS device doesn't support body tracking, raise a developer error for
        // this unhandled case.
        if !ARBodyTrackingConfiguration.isSupported  {
            //fatalError("This feature is only supported on devices with an A12 chip")
             addLabel(point : CGPoint(x: 0.0, y: 0.0), text : "Aparelho nao suportado",width: 200)
        }
        
        
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
    
    func estilizeButton(_ bt : UIButton){
        
        bt.frame = CGRect(x: 160, y: 160, width: 40, height: 40)
        bt.backgroundColor = UIColor.white
        bt.layer.cornerRadius = 0.5 * bt.bounds.size.width/2
        bt.layer.borderColor = UIColor.lightGray.cgColor
        bt.layer.borderWidth = 1.0
        bt.clipsToBounds = true
        
        
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

    func addLabel(point : CGPoint, text : String, width: CGFloat = 80){

        let label = SKShapeNode(rectOf: CGSize(width: width, height: 45), cornerRadius: 5)
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
        
        
        FirebaseService.shared.countDocuments() { (count) in
                   
            self.saveImage(key: String(count))
            let leftA = self.leftAngle
            let rightA = self.rightAngle
            
            AlertService.add(in: self) { patient in
                var p = patient
                p.order = count
                p.leftAngle = leftA
                p.rightAngle = rightA
                
                print(p)
                
                FirebaseService.shared.create(for: p) { (id) in
                
                    //self.saveImage(key: id)
                }
                
            }
                       
            
        }
        
        
        

        
        
   
    }
    
    func saveImage(key: String){
        
        
           let cgimage = cgImage(from: ciimage)
           var uiImage = UIImage(cgImage: cgimage!)
           //let portraitImage = UIImage(cgImage: landscapeCGImage, scale: landscapeImage.scale, orientation: .right)
        let portraitImage = UIImage(cgImage: cgimage!, scale: uiImage.scale, orientation: .right)
           
           let imageSaver = ImageSaver()
           imageSaver.successHandler = {
               print("Success!")
               
               self.takeScreenshot()
               
           }

           imageSaver.errorHandler = {
               print("Oops: \($0.localizedDescription)")
           }
       // imageSaver.writeToPhotoAlbum(image: portraitImage)
        
            self.takeScreenshot()
        
            DispatchQueue.global(qos: .background).async {
                ImageIOService.store(image: portraitImage,
                           forKey: key,
                           withStorageType: .fileSystem)
                                
            }
        
            
        
        /*
        UIImageWriteToSavedPhotosAlbum(image: portraitImage,)
        
        ALAssetsLibrary().writeImageToSavedPhotosAlbum(editedImage.CGImage, orientation: ALAssetOrientation(rawValue: editedImage.imageOrientation.rawValue)!,
            completionBlock:{ (path:NSURL!, error:NSError!) -> Void in
                print("\(path)")
        })
        */
    }
    
    func session(_ session: ARSession, didUpdate frame: ARFrame){         // Accessing ARBody2D Object from ARFrame
        sceneView.scene?.removeAllChildren()
        
       /*
        switch frame.camera.trackingState {
            case .normal:
                print("Normal")
            case .limited:
                print("Limited")
            default:
                print("Not Available")
        }
      */
    
        
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
        var transform = TransformBodyPositionToView(body: jointBody, viewPortSize: viewPortSize, imageSize: imageSize, orientation: orientation)

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
        
            for joint in jointBody.joints{
                
                let p = transform.pointToView(point: joint)
                addPoint(point: p)
            }
        
            
    }
    
    
    
    
    func drawLabels(body :ARBody2D, viewPortSize:CGSize, imageSize: CGSize, orientation:UIInterfaceOrientation){
        
        let jointBody = JointBody(body: body)
        let transform = TransformBodyPositionToView(body: jointBody, viewPortSize: viewPortSize, imageSize: imageSize, orientation: orientation)

        let body = transform.body
        

        if(countFrames > 60){
             rightAngle = Angle.right(hip: body.wRightHip, knee: body.wRightKnee, foot: body.wRightFoot)
             leftAngle = Angle.left(hip: body.wLeftHip, knee: body.wLeftKnee, foot: body.wLeftFoot)
   
            countFrames = 0
        }

        countFrames+=1
        
         var lang = leftAngle.angle()
         let ltype = leftAngle.devianType()
        
        var rang = rightAngle.angle()
         let rtype = rightAngle.devianType()

         body.leftKnee.x += 50
         body.rightKnee.x -= 50
        
        if !lang.isNaN  {
             lang = Float(floor(10*lang)/10) // leaves on first three decimal places
             let leftText = " \( lang)\n\(ltype)"
            print(leftText)
            addLabel(point: body.leftKnee, text: leftText)
        }
         
         if !rang.isNaN {
             rang = Float(floor(10*rang)/10) // leaves on first three decimal places
             let rightText = " \( rang)\n\(rtype)"
            print(rightText)
            addLabel(point: body.rightKnee, text: rightText)
             
         }
        
    }
    
    
    
    func simd2Point( simd : simd_float2)->CGPoint{
        var point = CGPoint()
        point.x = CGFloat(simd[0])
        point.y = CGFloat(simd[1])
        return point
    }
    
    
    func showToast(message : String) {

        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
       // toastLabel.font = font
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        toastLabel.center = self.view.center
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
             toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
    func takeScreenshot(){
        let scene = (self.sceneView.scene)!
        let bounds = scene.view?.bounds
        UIGraphicsBeginImageContextWithOptions(bounds!.size, true, UIScreen.main.scale )
        scene.view!.drawHierarchy(in: bounds!, afterScreenUpdates: true)
        let screenshot = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        UIImageWriteToSavedPhotosAlbum(screenshot!,nil,nil,nil)
        
        self.showToast(message: "Foto Capturada")
        
        
    }
    
    
    @objc
    private func save() {
        if let buildingImage = UIImage(named: "building") {
            DispatchQueue.global(qos: .background).async {
                ImageIOService.store(image: buildingImage,
                           forKey: "buildingImage",
                           withStorageType: .fileSystem)
            }
        }
    }
    
    @objc
    private func display() {
        DispatchQueue.global(qos: .background).async {
            if let savedImage = ImageIOService.retrieveImage(forKey: "buildingImage",
                                                   inStorageType: .fileSystem) {
                /*
                DispatchQueue.main.async {
                    self.savedImageDisplayImageView.image = savedImage
                }
                */
            }
        }
    }
    
    
    
   
}
