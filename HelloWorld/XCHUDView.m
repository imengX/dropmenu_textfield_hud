//
//  XCHUDView.m
//  HelloWorld
//
//  Created by XenonChau on 24/08/2017.
//  Copyright © 2017 Code1Bit Co.,Ltd. All rights reserved.
//

#import "XCHUDView.h"

@implementation XCHUDView

- (void)layoutSubviews {
    [super layoutSubviews];
    switch (self.position) {
        case XCHUDPositionCenter: {
            [self centerLayout];
            break;
        }
        case XCHUDPositionTop: {
            
            break;
        }
        case XCHUDPositionBottom: {
            
            break;
        }
        default:
            break;
    }
    
}

- (void)centerLayout {
    switch (self.style) {
        case XCHUDMessage: {
            
            break;
        }
        case XCHUDLoading: {
            
            break;
        }
        case XCHUDSuccess: {
            
            break;
        }
        case XCHUDFailed: {
            
            break;
        }
        default: {
            NSLog(@"不支持的样式");
            break;
        }
    }
    
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectZero];
    bgView.backgroundColor = [UIColor darkGrayColor];
    bgView.tag = 890;
    bgView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:bgView];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.titleLabel.text = @"卧槽";
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.titleLabel.textColor = [UIColor redColor];
    [self addSubview:self.titleLabel];
    
    UIView *horiLine0 = [[UIView alloc] init];
    horiLine0.backgroundColor = [UIColor whiteColor];
    horiLine0.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:horiLine0];
    
    self.detailTitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.detailTitleLabel.text = @"南无阿弥陀佛南无阿弥陀佛南无阿弥陀佛南无阿弥陀佛南无阿弥陀佛南无阿弥陀佛南无阿弥陀佛南无阿弥陀佛";
    self.detailTitleLabel.textColor = [UIColor whiteColor];
    self.detailTitleLabel.textAlignment = NSTextAlignmentLeft;
    self.detailTitleLabel.numberOfLines = 0;
    self.detailTitleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    self.detailTitleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.detailTitleLabel];
    
    
    const CGFloat _bg_margin_leading_trailing = 80;
    const CGFloat _container_margin_vertival = 5;
    const CGFloat _container_margin_horizon = 10;
    //
    NSLayoutConstraint * bg_leading = [NSLayoutConstraint constraintWithItem:bgView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1 constant:_bg_margin_leading_trailing];
    NSLayoutConstraint * bg_trailing = [NSLayoutConstraint constraintWithItem:bgView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:1 constant:-_bg_margin_leading_trailing];
    NSLayoutConstraint * bg_center_y = [NSLayoutConstraint constraintWithItem:bgView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
    NSLayoutConstraint * bg_height = [NSLayoutConstraint constraintWithItem:bgView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:210];
    bg_height.priority = UILayoutPriorityDefaultHigh;
    
    NSLayoutConstraint * title_leading = [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:bgView attribute:NSLayoutAttributeLeading multiplier:1 constant:0];
    NSLayoutConstraint * title_trailing = [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:bgView attribute:NSLayoutAttributeTrailing multiplier:1 constant:0];
    NSLayoutConstraint * title_top = [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:bgView attribute:NSLayoutAttributeTop multiplier:1 constant:_container_margin_vertival];
    NSLayoutConstraint * title_height = [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:20];
    title_height.priority = UILayoutPriorityDefaultHigh;
    
    NSLayoutConstraint * hori_line_0_leading = [NSLayoutConstraint constraintWithItem:horiLine0 attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:bgView attribute:NSLayoutAttributeLeading multiplier:1 constant:0];
    NSLayoutConstraint * hori_line_0_trailing = [NSLayoutConstraint constraintWithItem:horiLine0 attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:bgView attribute:NSLayoutAttributeTrailing multiplier:1 constant:0];
    NSLayoutConstraint * hori_line_0_top = [NSLayoutConstraint constraintWithItem:horiLine0 attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.titleLabel attribute:NSLayoutAttributeBottom multiplier:1 constant:_container_margin_vertival];
    NSLayoutConstraint * hori_line_0_height = [NSLayoutConstraint constraintWithItem:horiLine0 attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:1];
    
    NSLayoutConstraint * detail_leading = [NSLayoutConstraint constraintWithItem:self.detailTitleLabel attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:bgView attribute:NSLayoutAttributeLeading multiplier:1 constant:_container_margin_horizon];
    NSLayoutConstraint * detail_trailing = [NSLayoutConstraint constraintWithItem:self.detailTitleLabel attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:bgView attribute:NSLayoutAttributeTrailing multiplier:1 constant:-_container_margin_horizon];
    NSLayoutConstraint * detail_top = [NSLayoutConstraint constraintWithItem:self.detailTitleLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:horiLine0 attribute:NSLayoutAttributeTop multiplier:1 constant:5];
    NSLayoutConstraint * detail_height = [NSLayoutConstraint constraintWithItem:self.detailTitleLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:100];
    
    [NSLayoutConstraint activateConstraints:@[bg_leading, bg_trailing, bg_center_y, bg_height]];
    [NSLayoutConstraint activateConstraints:@[title_leading, title_trailing, title_top, title_height]];
    [NSLayoutConstraint activateConstraints:@[hori_line_0_leading, hori_line_0_trailing, hori_line_0_top, hori_line_0_height]];
    [NSLayoutConstraint activateConstraints:@[detail_leading, detail_trailing, detail_top, detail_height]];
    
}

- (void)topLayout {
    switch (self.style) {
        case XCHUDMessage: {
            
            break;
        }
        case XCHUDLoading: {
            
            break;
        }
        case XCHUDSuccess: {
            
            break;
        }
        case XCHUDFailed: {
            
            break;
        }
        case XCHUDStyleAlertView: {
            // 弹出对话框
            
            break;
        }
        default: {
            NSLog(@"不支持的样式");
            break;
        }
    }
    
    
    
    
}

- (void)bottomLayout {
    switch (self.style) {
        case XCHUDMessage: {
            
            break;
        }
        case XCHUDLoading: {
            
            break;
        }
        case XCHUDSuccess: {
            
            break;
        }
        case XCHUDFailed: {
            
            break;
        }
        case XCHUDStyleShareSheet: {
            // 分享样式
            
            break;
        }
        case XCHUDStyleActionSheet: {
            // 底部菜单栏
            
            break;
        }
        default: {
            NSLog(@"不支持的样式");
            break;
        }
    }
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    if (!self.isUserInteractionEnabled || self.isHidden || self.alpha <= 0.01) {
        return nil;
    }
    if (self.style == XCHUDStyleAlertView) {
        
    } else {
        if ([self pointInside:point withEvent:event]) {
            for (UIView *subview in [self.subviews reverseObjectEnumerator]) {
                CGPoint convertedPoint = [subview convertPoint:point fromView:self];
                UIView *hitTestView = [subview hitTest:convertedPoint withEvent:event];
                if (hitTestView) {
                    return hitTestView;
                }
            }
            [self hideHUD];
            return self;
        }
    }
    return nil;
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    [self fallInFromTop];
}

- (void)hideHUD {
    [self fallOutToBottom];
}


#pragma mark - Aminations
- (void)fallInFromTop {
    CGAffineTransform transform = CGAffineTransformIdentity;
    transform = CGAffineTransformTranslate(transform, 0, -524);
    [UIView animateWithDuration:0 animations:^{
        self.layer.affineTransform = transform;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5f animations:^{
            self.layer.affineTransform = CGAffineTransformMakeTranslation(0, 0);
        }];
    }];
}

- (void)fallOutToBottom {
    CGAffineTransform transform = CGAffineTransformIdentity;
    transform = CGAffineTransformTranslate(transform, 0, 1024);
    [UIView animateWithDuration:0.5f animations:^{
        self.layer.affineTransform = transform;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}


@end
