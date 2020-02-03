//
//  Angle.swift
//  BasicAR
//
//  Created by heber on 02/02/20.
//  Copyright © 2020 heber. All rights reserved.
//

import Foundation
import SpriteKit

class Angle{
    
    var hip = CGPoint()
    var foot = CGPoint()
    var knee = CGPoint()
    var isRight = true
    
    private init() {
        
    }
    
    
    static func right(hip : CGPoint, knee : CGPoint, foot : CGPoint) -> Angle {
        let angle = Angle()
        angle.foot =  foot
        angle.foot = foot
        angle.knee = knee
        angle.hip = hip
        angle.isRight = true
           return angle
       }
    
    static func left(hip : CGPoint, knee : CGPoint, foot : CGPoint) -> Angle {
        let angle = Angle()
        angle.foot =  foot
        angle.foot = foot
        angle.knee = knee
        angle.hip = hip
        angle.isRight = false
           return angle
       }
    
    func angle()->Float
    {
        let k =  cgToFloat(knee)
        let h = cgToFloat(hip)
        let f = cgToFloat(foot)
        
        let KF = h - k
        let KT = f - k;
        let  dotProduct = simd_dot(KF,KT)
        let norms = getVectorDistance(KF, KT);
        let cosin = dotProduct / norms;

        return radianToDegree(acos(cosin));
    }
    
    private func angleDirection() -> Float
        {
             let tf = cgToFloat(hip) - cgToFloat( foot)
             var  tk =  cgToFloat( knee) - cgToFloat( foot);
             tk = simd_normalize(tk)
             let ortho = perpendicular(tf)
         
             return  simd_dot(ortho, tk)
            
        }
    
    
    private func getVectorDistance(_ v1 : simd_float2,_ v2 : simd_float2)->Float
    {
        let normv1 = sqrt(pow(v1.x,2) + pow(v1.y,2))
        let normv2 = sqrt(pow(v2.x,2) + pow(v2.y,2))
        return normv1 * normv2
        
    }
    
    private func radianToDegree(_ angle : Float) -> Float
    {
        return 180.0 - (angle * (180.0 / Float.pi));
    }
    
    
    private func cgToFloat(_ point : CGPoint)->simd_float2{
        
        return simd_float2(x: Float(point.x), y: Float(point.y))
    }
    
    
    private func perpendicular( _ point: simd_float2)-> simd_float2{
        
        return simd_float2(x: -point.y , y:point.x)
                    
    }
    
    
    func devianType()-> String
    {
        let direction = angleDirection()
        
        if isRight {
            return (direction < 0 ) ? "Valgo" : "Varo"
        }
        else{
            return (direction >= 0 ) ? "Valgo" : "Varo"
        }
    }
}
