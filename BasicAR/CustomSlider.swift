//
//  CustomSlider.swift
//  BasicAR
//
//  Created by heber on 15/05/20.
//  Copyright © 2020 heber. All rights reserved.
//

import Foundation
import UIKit

class CustomSlider: UISlider {
    @IBInspectable var trackHeight: CGFloat = 1.0
/*
  override func trackRect(forBounds bounds: CGRect) -> CGRect {
    return CGRect(origin: bounds.origin, size: CGSize(width: bounds.width, height: trackHeight))
  }
    */
    /*
    override func thumbRect(forBounds bounds: CGRect, trackRect rect: CGRect, value: Float) -> CGRect {
        return CGRect(origin: bounds.origin, size: CGSize(width: bounds.width, height: 1.0))
    }*/
}
