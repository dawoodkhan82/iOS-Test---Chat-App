//
//  CustomUINavigationBar.m
//  iOSTest
//
//  Created by Dawood Khan on 8/28/17.
//  Copyright © 2017 AppPartner. All rights reserved.
//

#import "CustomUINavigationBar.h"

@implementation UINavigationBar (CustomNav)

- (CGSize)sizeThatFits:(CGSize)size
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGSize newSize = CGSizeMake(width, 44);
    
    return newSize;
}

@end
