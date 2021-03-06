//
//  ActivityIndicatorView.swift
//  AppleTv
//
//  Created by Nav146 on 06/07/18.
//  Copyright © 2018 Nav146. All rights reserved.
//

import Foundation
import UIKit
import Foundation

class ActivityIndicatorView
{
    var view: UIView!

    var activityIndicator: UIActivityIndicatorView!

    var title: String!

    init(title: String, center: CGPoint, width: CGFloat = 200.0, height: CGFloat = 50.0)
    {
        self.title = title

        let x = center.x - width/2.0
        let y = center.y - height/2.0

        self.view = UIView(frame: CGRect(x: x, y: y, width: width, height: height))
        self.view.backgroundColor = UIColor.clear
        self.view.layer.cornerRadius = 10

        self.activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 75, height: 75))
        self.activityIndicator.color = UIColor.black
        self.activityIndicator.hidesWhenStopped = false

        let titleLabel = UILabel(frame: CGRect(x: 60, y: 0, width: 200, height: 50))
        titleLabel.text = title
        titleLabel.textColor = UIColor.black

        self.view.addSubview(self.activityIndicator)
        //self.view.addSubview(titleLabel)
    }

    func getViewActivityIndicator() -> UIView
    {
        return self.view
    }

    func startAnimating()
    {
        self.activityIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
    }

    func stopAnimating()
    {
        self.activityIndicator.stopAnimating()
        UIApplication.shared.endIgnoringInteractionEvents()

        self.view.removeFromSuperview()
    }
    
    func hexStringToUIColor (_ hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.characters.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    //end
}
