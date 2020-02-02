//
//  JointBody.swift
//  BasicAR
//
//  Created by heber on 02/02/20.
//  Copyright © 2020 heber. All rights reserved.
//

import Foundation
import ARKit
class JointBody{
    
    var body : ARBody2D
    var root : CGPoint = CGPoint()
    var head : CGPoint = CGPoint()
    var leftShoulder : CGPoint = CGPoint()
    var rightShoulder : CGPoint = CGPoint()
    var leftHand : CGPoint = CGPoint()
    var rightHand : CGPoint = CGPoint()
    var leftHip : CGPoint = CGPoint()
    var rightHip : CGPoint = CGPoint()
    var leftFoot : CGPoint = CGPoint()
    var rightFoot : CGPoint = CGPoint()
    var leftElbow : CGPoint = CGPoint()
    var rightElbow : CGPoint = CGPoint()
    var leftKnee : CGPoint = CGPoint()
    var rightKnee : CGPoint = CGPoint()
    var torax = CGPoint()
    var joints : Array<CGPoint> = []
    
    init(body: ARBody2D){
        
        self.body = body
        
        let definition = body.skeleton.definition
         
         let head_ = definition.index(for: ARSkeleton.JointName.head)
         let leftShoulder = definition.index(for: ARSkeleton.JointName.leftShoulder)
         let rightShoulder = definition.index(for: ARSkeleton.JointName.rightShoulder)
         let root = definition.index(for: ARSkeleton.JointName.root)
         
         let leftHand = definition.index(for: ARSkeleton.JointName.leftHand)
         let rightHand = definition.index(for: ARSkeleton.JointName.rightHand)
         let leftFoot = definition.index(for: ARSkeleton.JointName.leftFoot)
         let rightFoot = definition.index(for: ARSkeleton.JointName.rightFoot)
         
         let rightKnee = definition.parentIndices[rightFoot]
         let rightHip = definition.parentIndices[rightKnee]
         let leftKnee = definition.parentIndices[leftFoot]
         let leftHip = definition.parentIndices[leftKnee]
        let leftElbow = definition.parentIndices[leftHand]
        let rightElbow = definition.parentIndices[rightHand]
        let torax = definition.parentIndices[rightShoulder]
        
         
         let joint = body.skeleton.jointLandmarks
        
        self.head = simd2Point(simd: joint[head_])
        self.rightHand = simd2Point(simd: joint[rightHand])
        self.root = simd2Point(simd: joint[root])
        self.leftElbow = simd2Point(simd: joint[leftElbow])
        self.leftShoulder = simd2Point(simd: joint[leftShoulder])
        self.leftFoot = simd2Point(simd: joint[leftFoot])
        self.leftHip = simd2Point(simd: joint[leftHip])
        self.leftKnee = simd2Point(simd: joint[leftKnee])
        self.leftHand = simd2Point(simd: joint[leftHand])
        self.rightHand = simd2Point(simd: joint[rightHand])
        self.rightFoot = simd2Point(simd: joint[rightFoot])
        self.rightHip = simd2Point(simd: joint[rightHip])
        self.rightElbow = simd2Point(simd: joint[rightElbow])
        self.rightKnee = simd2Point(simd: joint[rightKnee])
        self.rightShoulder = simd2Point(simd: joint[rightShoulder])
        self.torax = simd2Point(simd: joint[torax])
        
        self.joints = [self.head,self.torax, self.root, self.rightShoulder, self.rightElbow, self.rightHand, self.leftShoulder, self.leftElbow, self.leftHand, self.rightHip, self.rightKnee, self.rightFoot, self.leftHip, self.leftKnee, self.leftFoot]
      
    }
    
     func simd2Point( simd : simd_float2)->CGPoint{
        var point = CGPoint()
        point.x = CGFloat(simd[0])
        point.y = CGFloat(simd[1])
        return point
    }
}
