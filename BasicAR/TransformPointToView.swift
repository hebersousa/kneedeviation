//
//  TransformPointToView.swift
//  BasicAR
//
//  Created by heber on 02/02/20.
//  Copyright © 2020 heber. All rights reserved.
//

import Foundation
import SpriteKit
class TransformPointToView {
    
    var viewPortSize : CGSize
    var imageSize : CGSize
    var orientation : UIInterfaceOrientation
    
    init(viewPortSize:CGSize, imageSize: CGSize, orientation:UIInterfaceOrientation){
        self.viewPortSize = viewPortSize
        self.imageSize = imageSize
        self.orientation = orientation
    }
    
    func pointToView (
        point:CGPoint )->CGPoint{
                     
            var imgSize = self.imageSize
        
            var pImage = CGPoint()
                     
            pImage.x = point.x * self.imageSize.width
            pImage.y = point.y * self.imageSize.height
                             
                             
            var size = self.viewPortSize
            if(self.orientation.isPortrait){
                                 
                 size = swapAxis(size: viewPortSize)
             }
             
             let newHeight = imageSize.width * size.height/size.width
             
             let cropedHeight = imageSize.height - newHeight
             
             imgSize.height = newHeight
             pImage.y = pImage.y - cropedHeight/2
                             
             var pScene = CGPoint()
              pScene.x = pImage.x *  size.width / imgSize.width
              pScene.y = pImage.y * size.height / imgSize.height
             
             if(orientation.isLandscape){
             
                 if(orientation == UIInterfaceOrientation.landscapeLeft){
                     pScene = invertXAxis(point: pScene, size: viewPortSize)
                 pScene = invertYAxis(point: pScene, size: viewPortSize)
                 }
                 
                 pScene.y = viewPortSize.height - pScene.y
                 
             }else if(orientation.isPortrait){

                 pScene = swapAxis(point: pScene )
                 //se de cabeça para cima
                 if(orientation == UIInterfaceOrientation.portrait){
                   
                     pScene = invertYAxis(point: pScene, size: viewPortSize)
                     pScene = invertXAxis(point: pScene, size: viewPortSize)
                 }
             }
             
             var pView = CGPoint()
             pView.x = pScene.x - viewPortSize.width/2
             pView.y = pScene.y - viewPortSize.height/2
             
             return pView

        
    }
    
    func pointToWorld (
        point:CGPoint )->CGPoint{
        
        var imgSize = self.imageSize
        var pImage = CGPoint()
        pImage.x = point.x * self.imageSize.width
        pImage.y = point.y * self.imageSize.height
        
                         
        var size = self.viewPortSize
        if(self.orientation.isPortrait){
                             
             size = swapAxis(size: viewPortSize)
         }
         
         let newHeight = imageSize.width * size.height/size.width
         
         let cropedHeight = imageSize.height - newHeight
         
         imgSize.height = newHeight
         pImage.y = newHeight - pImage.y
        
        return pImage
    }
    

    private func invertXAxis( point:CGPoint, size:CGSize) ->CGPoint{
       var p = point;
         p.x = size.width - point.x
         return p;
     }
     
    private func invertYAxis( point:CGPoint, size:CGSize) ->CGPoint{
         var p = point;
         p.y = size.height - point.y
         return p;
     }
    private func swapAxis( point:CGPoint) ->CGPoint{
         var p = CGPoint();
         p.x = point.y
         p.y = point.x
         return p;
     }
     
     private func swapAxis( size:CGSize) ->CGSize{
         var s = CGSize();
         s.height = size.width
         s.width = size.height
         return s;
     }
    
     
}
