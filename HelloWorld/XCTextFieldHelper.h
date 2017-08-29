//
//  XCTextFieldHelper.h
//  HelloWorld
//
//  Created by XenonChau on 24/08/2017.
//  Copyright © 2017 Code1Bit Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, XCTextFieldType) {
    XCTextFieldTypeNone = 0,
    XCTextFieldTypeCellPhone,
    XCTextFieldTypePassword,
    XCTextFieldTypeCurrency,
    XCTextFieldTypeCaptcha,
};

@interface XCTextFieldHelper : NSObject <UITextFieldDelegate>



@end
