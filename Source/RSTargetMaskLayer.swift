//
//  RSTargetMaskLayer.swift
//  RSBarcodes
//
//  Created by William Lawson on 3/6/16.
//

import UIKit
import QuartzCore

public class RSTargetMaskLayer: CALayer {
    open var regionOfInterest: CGRect = CGRect(x: 0, y: 0, width: 0, height: 0) {
        willSet {
            DispatchQueue.main.async {
                self.setNeedsDisplay()
            }
        }
    }
    
    override open func draw(in ctx: CGContext) {
        objc_sync_enter(self)
        ctx.saveGState()
        
        ctx.setShouldAntialias(true)
        ctx.setAllowsAntialiasing(true)
        
        self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        self.opacity = 0.6
        
        let maskLayer = CAShapeLayer()
        let maskPath = CGMutablePath()
        maskPath.addRect(CGRect(x: 0, y: 0, width: 2000, height: 2000))
        maskPath.addPath(UIBezierPath(roundedRect: regionOfInterest, cornerRadius: 10).cgPath)
        maskLayer.path = maskPath
        maskLayer.fillRule = CAShapeLayerFillRule.evenOdd
        self.mask = maskLayer
        
        ctx.drawPath(using: CGPathDrawingMode.fillStroke)
        
        ctx.restoreGState()
        
        objc_sync_exit(self)
    }
}
