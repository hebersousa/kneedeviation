//
//  TransformBodyPositionToView.swift
//  BasicAR
//
//  Created by heber on 03/02/20.
//  Copyright © 2020 heber. All rights reserved.
//

import Foundation
import SpriteKit
import ARKit


class TransformBodyPositionToView : TransformPointToView{
    
    var body : JointBody
    
    init(body: JointBody, viewPortSize:CGSize, imageSize: CGSize, orientation:UIInterfaceOrientation){
        self.body = body
        super.init(viewPortSize: viewPortSize, imageSize: imageSize, orientation: orientation)
        
        self.body.head = self.pointToView(point: body.head)
        self.body.torax = self.pointToView(point: body.torax)
        self.body.root = self.pointToView(point: body.root)
        self.body.leftShoulder = self.pointToView(point: body.leftShoulder)
        self.body.rightShoulder = self.pointToView(point: body.rightShoulder)
        self.body.leftElbow = self.pointToView(point: body.leftElbow)
        self.body.rightElbow = self.pointToView(point: body.rightElbow)
        self.body.leftHand = self.pointToView(point: body.leftHand)
        self.body.rightHand = self.pointToView(point: body.rightHand)
        self.body.leftHip = self.pointToView(point: body.leftHip)
        self.body.rightHip = self.pointToView(point: body.rightHip)
        self.body.leftKnee = self.pointToView(point: body.leftKnee)
        self.body.rightKnee = self.pointToView(point: body.rightKnee)
        self.body.leftFoot = self.pointToView(point: body.leftFoot)
        self.body.rightFoot = self.pointToView(point: body.rightFoot)
        
        self.body.wLeftHip = self.pointToWorld(point: body.leftHip)
        self.body.wRightHip = self.pointToWorld(point: body.rightHip)
        self.body.wLeftKnee = self.pointToWorld(point: body.leftKnee)
        self.body.wRightKnee = self.pointToWorld(point: body.rightKnee)
        self.body.wLeftFoot = self.pointToWorld(point: body.leftFoot)
        self.body.wRightFoot = self.pointToWorld(point: body.rightFoot)
        
    }
}
