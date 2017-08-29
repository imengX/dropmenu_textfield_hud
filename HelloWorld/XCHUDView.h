//
//  XCHUDView.h
//  HelloWorld
//
//  Created by XenonChau on 24/08/2017.
//  Copyright © 2017 Code1Bit Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, XCHUDPositions) {
    XCHUDPositionCenter = 0,
    XCHUDPositionTop,
    XCHUDPositionBottom,
};

typedef NS_ENUM(NSUInteger, XCHUDStyle) {
    // 文字
    XCHUDMessage = 0, // default
    // 加载动画
    XCHUDLoading,
    // 成功
    XCHUDSuccess,
    // 失败
    XCHUDFailed,
    
    // 底部选择器
    XCHUDStyleActionSheet,
    // 分享
    XCHUDStyleShareSheet,
    // 对话框
    XCHUDStyleAlertView,
};

typedef NS_OPTIONS(NSUInteger, XCHUDAnimationStyle) {
    // 坠入坠出
    XCHUDAnimationStyleFallInAndOut     = 8 << 0, // 0000 1000
    // 坠入坠出
    XCHUDAnimationStyleRaiseInAndOut    = 8 << 0, // 0000 1000
    // 弹出缩回
    XCHUDAnimationStylePopInAndOut      = 8 << 1, // 0001 0000
    // 顶端滑入滑回（并有手动驱动划回）
    XCHUDAnimationStyleNotifications    = 8 << 2, // 0010 0000
};

@interface XCHUDView : UIView

@property (assign, nonatomic) XCHUDPositions position;
@property (assign, nonatomic) XCHUDStyle style;
@property (assign, nonatomic) XCHUDAnimationStyle animations;

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *detailTitleLabel;

@end
