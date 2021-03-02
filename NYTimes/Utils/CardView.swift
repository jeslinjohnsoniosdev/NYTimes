//
//  CardView.swift
//  NYTimes
//
//  Created by Chanchal Raj on 02/03/2021.
//  Copyright © 2021 Jeslin Johnson. All rights reserved.
//

import UIKit

@IBDesignable
class CardView: UIView {

    @IBInspectable var cvCornerRadius: CGFloat = 12
    @IBInspectable var borderLineWidth: CGFloat = 0
    @IBInspectable var borderLineColor: UIColor? = .black
    @IBInspectable var shadowOffsetWidth: Int = 0
    @IBInspectable var shadowOffsetHeight: Int = 3
    @IBInspectable var cvShadowColor: UIColor? = .gray
    @IBInspectable var cvShadowOpacity: Float = 0.5

    override func layoutSubviews() {
        layer.cornerRadius = cvCornerRadius
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cvCornerRadius)

        layer.masksToBounds = false
        layer.shadowColor = cvShadowColor?.cgColor
        layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight);
        layer.shadowOpacity = cvShadowOpacity
        layer.shadowPath = shadowPath.cgPath
        
        if borderLineWidth > 0 {
            // Add rounded corners
            let maskLayer = CAShapeLayer()
            maskLayer.frame = bounds
            maskLayer.path = UIBezierPath(roundedRect: bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: cvCornerRadius, height: cvCornerRadius)).cgPath
            
            // Add border
            let borderLayer = CAShapeLayer()
            borderLayer.path = maskLayer.path // Reuse the Bezier path
            borderLayer.fillColor = UIColor.clear.cgColor
            borderLayer.strokeColor = borderLineColor?.cgColor
            borderLayer.lineWidth = borderLineWidth
            borderLayer.frame = bounds
            layer.addSublayer(borderLayer)
        }
    }
}
