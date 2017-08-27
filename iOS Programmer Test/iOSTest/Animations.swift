//
//  Animations.swift
//  iOSTest
//
//  Created by Dawood Khan on 8/22/17.
//  Copyright © 2017 AppPartner. All rights reserved.
//

import Foundation
import UIKit

@objc public class Animations: NSObject {
    
    func bounce(_ sender: AnyObject)
    {
        let logoImage = sender as! UIImageView
        let bounds = logoImage.bounds
        
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 10, options: .curveEaseInOut, animations: {
            logoImage.bounds = CGRect(x: bounds.origin.x - 20, y: bounds.origin.y, width: bounds.size.width + 60, height: bounds.size.height)
        }) { (success:Bool) in
            if success {
                
                UIView.animate(withDuration: 0.5, animations: {
                    logoImage.bounds = bounds
                })
                
            }
        }
    }
    
    
    func fade(_ sender: AnyObject)
    {
        let logoImage = sender as! UIImageView
        
        UIView.animate(withDuration: 1) {
            logoImage.alpha = 0.0
        }
        
        UIView.animate(withDuration: 1) {
            logoImage.alpha = 1
        }

    }
    
}
