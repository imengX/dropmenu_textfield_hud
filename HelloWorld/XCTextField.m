//
//  XCTextField.m
//  HelloWorld
//
//  Created by XenonChau on 24/08/2017.
//  Copyright © 2017 Code1Bit Co.,Ltd. All rights reserved.
//

#import "XCTextField.h"

@implementation XCTextField

- (void)layoutSubviews {
    [super layoutSubviews];
    
    /*
     co-in token default setting:
     text color, font, etc.
     border radius width color, etc.
     spell checking
     return key
     placeholder
     */
    
    self.tintColor = [UIColor whiteColor];
    self.textColor = [UIColor whiteColor];
    self.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:15];
    
    self.layer.cornerRadius = 2;
    self.layer.borderWidth = 0.5;
    
    self.layer.borderColor = [UIColor colorWithRed:128.f/255.f green:138.f/255.f blue:172.f/255.f alpha:1].CGColor;
    self.backgroundColor = [UIColor colorWithRed:121.f/255.f green:119.f/255.f blue:165.f/255.f alpha:.6f];
    
    self.autocorrectionType = UITextAutocorrectionTypeNo;
    self.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.spellCheckingType = UITextSpellCheckingTypeNo;
    self.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.enablesReturnKeyAutomatically = YES;
    
    NSAttributedString *attributedPlaceholder =
    [[NSAttributedString alloc]
     initWithString:self.placeholder ? : @""
     attributes:@{
                  NSFontAttributeName : self.placeholderFont ? : self.font,
                  NSBaselineOffsetAttributeName : @(self.placeholderOffsetY) ? : @(-2),// Y_offset: positive is up; negative is down;
                  NSForegroundColorAttributeName : self.placeholderColor ? : [UIColor colorWithRed:125.f/255.f green:124.f/255.f blue:166.f/255.f alpha:.6f],
                  }];
    self.attributedPlaceholder = attributedPlaceholder;
    
    XCTextFieldHelper *helper = [XCTextFieldHelper new];
    self.delegate = helper;
    
}

// placeholder position
- (CGRect)textRectForBounds:(CGRect)bounds {
    CGFloat offsetX = self.placeholderOffsetX ? : 20;
    CGFloat offsetY = self.placeholderOffsetY ? : 0;
    return CGRectInset(bounds, offsetX, offsetY);
}

// text position
- (CGRect)editingRectForBounds:(CGRect)bounds {
    CGFloat offsetX = self.textOffsetX ? : 20;
    CGFloat offsetY = self.textOffsetY ? : 0;
    return CGRectInset(bounds, offsetX, offsetY);
}

@end
