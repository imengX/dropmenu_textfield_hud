//
//  XCTextField.h
//  HelloWorld
//
//  Created by XenonChau on 24/08/2017.
//  Copyright © 2017 Code1Bit Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XCTextFieldHelper.h"

@interface XCTextField : UITextField

@property (copy, nonatomic) UIFont *placeholderFont;
@property (copy, nonatomic) UIColor *placeholderColor;
@property (assign, nonatomic) CGFloat placeholderOffsetY;
@property (assign, nonatomic) CGFloat placeholderOffsetX;
@property (assign, nonatomic) CGFloat textOffsetX;
@property (assign, nonatomic) CGFloat textOffsetY;

@end
