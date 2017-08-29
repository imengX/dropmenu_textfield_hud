//
//  XCTextFieldHelper.m
//  HelloWorld
//
//  Created by XenonChau on 24/08/2017.
//  Copyright © 2017 Code1Bit Co.,Ltd. All rights reserved.
//

#import "XCTextFieldHelper.h"

@interface XCTextFieldHelper ()

@end

@implementation XCTextFieldHelper

- (BOOL)textField:(UITextField *)textField
        shouldChangeCharactersInRange:(NSRange)range
        replacementString:(NSString *)string {
    
    return YES;
}

@end
