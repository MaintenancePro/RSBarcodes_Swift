//
//  RSTargetLineLayer.swift
//  RSBarcodes
//
//  Created by William Lawson on 3/6/16.
//  Copyright © 2016 William Lawson. All rights reserved.
//

import UIKit
import QuartzCore

public class RSTargetLineLayer: CALayer {
    public var strokeColor = UIColor(red: 255, green: 0, blue: 0, alpha: 1).CGColor
    public var strokeWidth: CGFloat = 1
    
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
        
        CGContextSetStrokeColorWithColor(ctx, self.strokeColor)
        CGContextSetLineWidth(ctx, self.strokeWidth)
        CGContextMoveToPoint(ctx, regionOfInterest.minX, regionOfInterest.midY)
        let endPoint = CGPointMake(regionOfInterest.maxX,regionOfInterest.midY)
        CGContextAddLineToPoint(ctx, endPoint.x, endPoint.y)
        
        CGContextDrawPath(ctx, CGPathDrawingMode.FillStroke)
        
        CGContextRestoreGState(ctx)
        
        objc_sync_exit(self)
    }
}