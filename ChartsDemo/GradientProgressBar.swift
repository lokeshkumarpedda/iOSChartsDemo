//
//  GradientProgressBar.swift
//  GradientProgressBar
//
//  Created by Felix Mau on 01.03.17.
//  Copyright © 2017 Felix Mau. All rights reserved.
//

import Foundation
import UIKit

public class GradientProgressBar : UIProgressView {
    
    lazy private var gradientLayer: CAGradientLayer! = self.initGradientLayer()
    lazy private var alphaLayer: CALayer! = self.initAlphaLayer()
    
    public var MBackgroundColor : UIColor = UIColor(hexString:"#e5e9eb")
    
    public var gradientColors : [CGColor] = [
        UIColor(hexString:"#FE5C57").cgColor,
        UIColor(hexString:"#FFCB4C").cgColor,
        UIColor(hexString:"#4CFFB6").cgColor
        //        UIColor(hexString:"#4cd964").cgColor,
        //        UIColor(hexString:"#5ac8fa").cgColor,
        //        UIColor(hexString:"#007aff").cgColor,
        //        UIColor(hexString:"#34aadc").cgColor,
        //        UIColor(hexString:"#5856d6").cgColor,
        //        UIColor(hexString:"#ff2d55").cgColor
    ]
    override init (frame : CGRect) {
        super.init(frame : frame)
        
        self.initColors()
        self.layer.insertSublayer(self.gradientLayer, at: 0)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.initColors()
        self.layer.insertSublayer(self.gradientLayer, at: 0)
    }
    
    func initColors() {
        self.backgroundColor = MBackgroundColor
        
        self.trackTintColor = UIColor.clear
        self.progressTintColor = UIColor.clear
    }
    
    // MARK: Lazy initializers
    
    func initGradientLayer() -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        
        gradientLayer.anchorPoint = CGPoint(x: 0, y: 0)
        gradientLayer.position = CGPoint(x: 0, y: 0)
        
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0);
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.0);
        
        gradientLayer.colors = gradientColors
        
        gradientLayer.mask = self.alphaLayer
        
        return gradientLayer
    }
    
    func initAlphaLayer() -> CALayer {
        let alphaLayer = CALayer()
        alphaLayer.frame = self.bounds
        
        alphaLayer.anchorPoint = CGPoint(x: 0, y: 0)
        alphaLayer.position = CGPoint(x: 0, y: 0)
        
        alphaLayer.backgroundColor = UIColor.white.cgColor
        
        return alphaLayer
    }
    
    // MARK: Layout
    
    func updateAlphaLayerWidth() {
        self.alphaLayer.frame =
            self.bounds.sizeByPercentage(width: CGFloat(self.progress))
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        self.gradientLayer.frame = self.bounds
        self.updateAlphaLayerWidth()
    }
    
    override public func setProgress(_ progress: Float, animated: Bool) {
        super.setProgress(progress, animated: animated)
        
        self.updateAlphaLayerWidth()
    }
}

extension CGRect {
    func sizeByPercentage(width: CGFloat, height: CGFloat = 1.0) -> CGRect {
        let width = self.width * width
        let height = self.height * height
        
        return CGRect(
            x: self.origin.x, y: self.origin.y, width: width, height: height
        )
    }
}

extension UIColor
{
    convenience init(hexString: String)
    {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.characters.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}

