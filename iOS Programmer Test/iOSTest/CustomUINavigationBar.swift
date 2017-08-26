//
//  CustomUINavigationBar.swift
//  iOSTest
//
//  Created by Dawood Khan on 8/22/17.
//  Copyright © 2017 AppPartner. All rights reserved.
//

import UIKit

class CustomUINavigationBar: UINavigationBar {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        let width = UIScreen.main.bounds.size.width
        let updatedSize = CGSize(width: width, height: 44)
        return updatedSize
    }

}
