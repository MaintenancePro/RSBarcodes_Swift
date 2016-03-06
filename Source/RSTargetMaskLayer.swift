//
//  RSTargetMaskLayer.swift
//  RSBarcodes
//
//  Created by William Lawson on 3/6/16.
//

import UIKit
import QuartzCore

public class RSTargetMaskLayer: CALayer {
    public var regionOfInterest: CGRect = CGRect(x: 0, y: 0, width: 0, height: 0) {
        willSet {
            dispatch_async(dispatch_get_main_queue(), {
                self.setNeedsDisplay()
            })
        }
    }
    
    override public func drawInContext(ctx: CGContext) {
        objc_sync_enter(self)
        CGContextSaveGState(ctx)
        
        CGContextSetShouldAntialias(ctx, true)
        CGContextSetAllowsAntialiasing(ctx, true)
        
        self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).CGColor
        self.opacity = 0.6
        
        let maskLayer = CAShapeLayer()
        let maskPath = CGPathCreateMutable();
        CGPathAddRect(maskPath, nil, CGRectMake(0,0,2000,2000))
        CGPathAddPath(maskPath, nil, UIBezierPath(roundedRect: regionOfInterest, cornerRadius: 10).CGPath)
        maskLayer.path = maskPath
        maskLayer.fillRule = kCAFillRuleEvenOdd
        self.mask = maskLayer
        
        CGContextDrawPath(ctx, CGPathDrawingMode.FillStroke)
        
        CGContextRestoreGState(ctx)
        
        objc_sync_exit(self)
    }
}