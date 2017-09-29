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
    open var strokeColor = UIColor(red: 255, green: 0, blue: 0, alpha: 1).cgColor
    open var strokeWidth: CGFloat = 1
    
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
        
        ctx.setStrokeColor(self.strokeColor)
        ctx.setLineWidth(self.strokeWidth)
        ctx.move(to: CGPoint(x: regionOfInterest.minX, y: regionOfInterest.midY))
        let endPoint = CGPoint(x: regionOfInterest.maxX, y: regionOfInterest.midY)
        ctx.addLine(to: CGPoint(x: endPoint.x, y: endPoint.y))
        
        ctx.drawPath(using: CGPathDrawingMode.fillStroke)
        
        ctx.restoreGState()
        
        objc_sync_exit(self)
    }
}
