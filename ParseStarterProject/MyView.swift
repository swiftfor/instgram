//
//  File.swift
//  ParseStarterProject-Swift
//
//  Created by Hamada on 8/7/18.
//  Copyright © 2018 Parse. All rights reserved.
//

import UIKit
@IBDesignable
class myView : UIView {
    @IBInspectable var FirstColor : UIColor = UIColor.clear {
        didSet
        {
            UpdateView()
        }
    }
    @IBInspectable var SecondColor : UIColor = UIColor.clear {
        didSet
        {
            UpdateView()
        }
    }
    override class var layerClass : AnyClass {
        get{
            return CAGradientLayer.self
        }
    }
    
    func UpdateView(){
        let Layer = self.layer as! CAGradientLayer
        Layer.colors = [FirstColor.cgColor,SecondColor.cgColor]
    }
    
}
