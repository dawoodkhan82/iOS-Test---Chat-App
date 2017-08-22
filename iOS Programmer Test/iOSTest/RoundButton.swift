//
//  RoundButton.swift
//  iOSTest
//
//  Created by Dawood Khan on 8/22/17.
//  Copyright © 2017 AppPartner. All rights reserved.
//

import UIKit

class RoundedButton: UIButton {
    
    
    override func draw(_ rect: CGRect) {
        
        layer.cornerRadius = 25.0
        layer.masksToBounds = true
        
        
    }
}
