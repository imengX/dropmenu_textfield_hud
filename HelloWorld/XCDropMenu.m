//
//  XCDropMenu.m
//  HelloWorld
//
//  Created by XenonChau on 22/08/2017.
//  Copyright © 2017 Code1Bit Co.,Ltd. All rights reserved.
//

#import "XCDropMenu.h"
#import "HexColors.h"
#import "Masonry.h"

@interface XCDropMenu () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UIView *menuView;
@property (strong, nonatomic) UITableView *tableView;

@property (copy, nonatomic) NSArray *originDataSource;

@property (assign, nonatomic, getter=isReveal) BOOL reveal;

@property(nonatomic, strong) NSLayoutConstraint *menu_height;

@end

@implementation XCDropMenu

- (instancetype)initWithDataSource:(NSArray *)dataSource
{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        self.dataSource = dataSource;
        [self initialValues];
        [self initialViews];
    }
    return self;
}

- (UIView *)menuView {
    if (!_menuView) {
        _menuView = [[UIView alloc] initWithFrame:CGRectZero];
        _menuView.alpha = 0;
        _menuView.layer.masksToBounds = YES;
        _menuView.layer.cornerRadius = 2;
        _menuView.layer.borderWidth = 0.5;
        _menuView.layer.borderColor = self.borderColor.CGColor;
        _menuView.backgroundColor = self.backgroundColor;
        _menuView.translatesAutoresizingMaskIntoConstraints = NO;
        [_menuView addSubview:self.tableView];
    }
    return _menuView;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero
                                                  style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.layer.cornerRadius = 2;
        _tableView.layer.masksToBounds = YES;
        _tableView.layer.borderColor = self.borderColor.CGColor;
        _tableView.layer.borderWidth = 0.5;
        _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _tableView.separatorColor = self.borderColor;
        _tableView.alpha = 0;
        _tableView.rowHeight = self.itemHeight;
        _tableView.estimatedRowHeight = self.itemHeight;
        _tableView.translatesAutoresizingMaskIntoConstraints = NO;
        [_tableView registerClass:[DMCell class] forCellReuseIdentifier:NSStringFromClass([DMCell class])];
        
    }
    return _tableView;
}

- (void)initialValues {
    
    self.itemHeight = 50;
    self.numberOfShownItems = 4;
    self.hideMenuAfterTouch = YES;
    self.selectedCoin = self.selectedCoin ? : @"BTC";
    self.reveal = NO;
    
}

- (void)initialViews {
    
    self.layer.cornerRadius = 2;
    self.layer.borderColor = self.borderColor.CGColor;
    self.layer.borderWidth = 0.5;
    
    self.backgroundColor = [UIColor colorWithRed:28.f/255.f green:28.f/255.f blue:28.f/255.f alpha:1];
    self.borderColor = [UIColor colorWithRed:186.f/255.f green:186.f/255.f blue:186.f/255.f alpha:1];
    self.textColor = [UIColor whiteColor];
    
    [self addTarget:self action:@selector(controlAction:) forControlEvents:UIControlEventTouchUpInside];
    
    if (!self.originDataSource) {
        // 可以用 init 传值。
        // 同时也要注意，init 传值后，远端更新数据源时，origin 也需要再赋值“一”次。
        self.originDataSource = self.dataSource.copy;
    }

    [self addSubview:self.menuView];
    
    _iconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:self.selectedCoin]];
    _iconView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_iconView];
    
//    if (!self.titleLabel) {
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.titleLabel.text = self.selectedCoin;
        self.titleLabel.textColor = self.textColor;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:self.titleLabel];
//    }
    
//    if (!self.indicatorView) {
        self.indicatorView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"triangle"]];
        self.indicatorView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:self.indicatorView];
//    }
    
    [self menuLayout];
    [self tableLayout];
    [self iconLayout];
    [self titleLayout];
    [self indicatorLayout];
}

- (void)updateConstraints {
    [super updateConstraints];
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

- (void)updateDataSource:(NSArray *)newDataSource {
    self.originDataSource = newDataSource;
}

- (void)reloadDataSource {
    NSMutableArray *temp = [self.originDataSource mutableCopy];
    [temp removeObject:self.selectedCoin];
    self.dataSource = temp;
}

- (void)controlAction:(UIControl *)control {
    
    self.selected = !self.selected;
    
    if (self.selected) {
        [self showMenuAnimated:YES];
    } else {
        [self hideMenuAnimated:YES];
    }
}

#pragma mark - TableView Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 外部传入 reuseIdentifier, Class？
    DMCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([DMCell class]) forIndexPath:indexPath];
    [cell updateCell:self.dataSource[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    NSString *coinName = self.dataSource[indexPath.row];
    self.titleLabel.text = coinName;
    self.iconView.image = [UIImage imageNamed:coinName];
    self.selectedCoin = coinName;
    [self reloadDataSource];
    [UIView transitionWithView:self.tableView
                      duration:0.35f
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        [self.tableView reloadData];
                    } completion:^ (BOOL complete) {
                        !_itemSelectCallback ? : _itemSelectCallback(indexPath.row, self.dataSource[indexPath.row]);
                        if (self.hideMenuAfterTouch) {
                            [self hideMenuOutside];
                        }
                    }];
}

#pragma mark - hitTest

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    if (!self.isUserInteractionEnabled || self.isHidden || self.alpha <= 0.01) {
        return nil;
    }
    CGPoint menuTouchPoint = CGPointMake(point.x,
                                         point.y - self.frame.size.height - 5);
    
    if ([self pointInside:point withEvent:event]) {
        return self;
    } else if ([self.menuView pointInside:menuTouchPoint withEvent:event]) {
        return [self.menuView hitTest:menuTouchPoint withEvent:event];
    } else {
        [self hideMenuOutside];
    }
    return nil;
}

#pragma mark - Menu Animation

- (void)showMenuAnimated:(BOOL)animate {
    [self reloadDataSource];
    if (self.numberOfShownItems >= self.dataSource.count) {
        self.numberOfShownItems = self.dataSource.count;
        self.tableView.scrollEnabled = NO;
    } else {
        self.tableView.scrollEnabled = YES;
    }
    [self.superview bringSubviewToFront:self.menuView];
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    transform = CGAffineTransformRotate(transform, M_PI);
    
    self.reveal = YES;
    [self updateMenuViewState];
    [self.tableView reloadData];
    
    [UIView animateWithDuration:animate ? 0.25f : 0.0f animations:^{
        self.menuView.alpha = 1;
        self.tableView.alpha = 1;
        [self.menuView layoutIfNeeded];
//        self.menuView.frame = (CGRect){
//                                         self.frame.origin.x,
//                                         self.frame.origin.y + self.frame.size.height + 5,
//                                         self.frame.size.width,
//                                         self.itemHeight * self.numberOfShownItems
//                                        };
//        self.tableView.frame = (CGRect){
//                                         0,
//                                         0,
//                                         self.frame.size.width,
//                                         self.itemHeight * self.numberOfShownItems
//                                       };
        
        self.indicatorView.layer.affineTransform = transform;
    }];
}

- (void)hideMenuAnimated:(BOOL)animate {
    if (self.numberOfShownItems >= self.dataSource.count) {
        self.numberOfShownItems = self.dataSource.count;
        self.tableView.scrollEnabled = NO;
    } else {
        self.tableView.scrollEnabled = YES;
    }
    [self.superview sendSubviewToBack:self.menuView];
    
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    transform = CGAffineTransformRotate(transform, 0);
    
    [UIView animateWithDuration:animate ? 0.25f : 0.0f animations:^{
        for (NSLayoutConstraint *constraint in self.menuView.constraints) {
            if ([constraint.identifier isEqualToString:@"menu_height"]) {
                [NSLayoutConstraint deactivateConstraints:@[constraint]];
            }
        }
        self.menuView.alpha = 0;
        self.tableView.alpha = 0;
        self.reveal = NO;
        [self layoutSubviews];
        [self.tableView needsUpdateConstraints];
        [self.tableView reloadData];
//        self.menuView.frame = (CGRect){
//                                         self.frame.origin.x,
//                                         self.frame.origin.y + self.frame.size.height + 5,
//                                         self.frame.size.width,
//                                         0
//                                        };
//
//        self.tableView.frame = (CGRect){
//                                         0,
//                                         0,
//                                         self.frame.size.width,
//                                         0
//                                       };
        
        self.indicatorView.layer.affineTransform = transform;
//        [self needsUpdateConstraints];
//        [self.menuView needsUpdateConstraints];
//        [self.menuView layoutSubviews];
//        [self.tableView needsUpdateConstraints];
    }];
}

- (void)hideMenuOutside {
    self.selected = NO;
    [self hideMenuAnimated:YES];
}

- (void)updateMenuViewState {
    CGFloat menuHeight = self.itemHeight * self.numberOfShownItems;
    self.menu_height.constant = self.reveal ? menuHeight : 0;
}

- (void)menuLayout {
    NSLayoutConstraint *menu_leading = [NSLayoutConstraint constraintWithItem:self.menuView
                                                                    attribute:NSLayoutAttributeLeading
                                                                    relatedBy:NSLayoutRelationEqual
                                                                       toItem:self
                                                                    attribute:NSLayoutAttributeLeading
                                                                   multiplier:1
                                                                     constant:0];
    NSLayoutConstraint *menu_trailing = [NSLayoutConstraint constraintWithItem:self.menuView
                                                                    attribute:NSLayoutAttributeTrailing
                                                                    relatedBy:NSLayoutRelationEqual
                                                                       toItem:self
                                                                    attribute:NSLayoutAttributeTrailing
                                                                   multiplier:1
                                                                     constant:0];
    NSLayoutConstraint *menu_top = [NSLayoutConstraint constraintWithItem:self.menuView
                                                                    attribute:NSLayoutAttributeTop
                                                                    relatedBy:NSLayoutRelationEqual
                                                                       toItem:self
                                                                    attribute:NSLayoutAttributeBottom
                                                                   multiplier:1
                                                                     constant:5];
    _menu_height = [NSLayoutConstraint constraintWithItem:self.menuView
                                                                    attribute:NSLayoutAttributeHeight
                                                                    relatedBy:NSLayoutRelationEqual
                                                                       toItem:nil
                                                                    attribute:NSLayoutAttributeNotAnAttribute
                                                                   multiplier:1
                                                                     constant:0];
//    _menu_height.identifier = @"menu_height";
    [NSLayoutConstraint activateConstraints:@[menu_leading, menu_trailing, menu_top, _menu_height]];
}

- (void)tableLayout {
    NSLayoutConstraint *table_leading = [NSLayoutConstraint constraintWithItem:self.tableView
                                                                    attribute:NSLayoutAttributeLeading
                                                                    relatedBy:NSLayoutRelationEqual
                                                                       toItem:self.menuView
                                                                    attribute:NSLayoutAttributeLeading
                                                                   multiplier:1
                                                                     constant:0];
    NSLayoutConstraint *table_trailing = [NSLayoutConstraint constraintWithItem:self.tableView
                                                                     attribute:NSLayoutAttributeTrailing
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.menuView
                                                                     attribute:NSLayoutAttributeTrailing
                                                                    multiplier:1
                                                                      constant:0];
    NSLayoutConstraint *table_top = [NSLayoutConstraint constraintWithItem:self.tableView
                                                                attribute:NSLayoutAttributeTop
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:self.menuView
                                                                attribute:NSLayoutAttributeTop
                                                               multiplier:1
                                                                 constant:0];
    NSLayoutConstraint *table_bottom = [NSLayoutConstraint constraintWithItem:self.tableView
                                                                attribute:NSLayoutAttributeBottom
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:self.menuView
                                                                attribute:NSLayoutAttributeBottom
                                                               multiplier:1
                                                                 constant:0];
    [NSLayoutConstraint activateConstraints:@[table_leading, table_trailing, table_top, table_bottom]];
}

- (void)iconLayout {
    NSLayoutConstraint *iconView_centerX = [NSLayoutConstraint
                                            constraintWithItem:self.iconView
                                            attribute:NSLayoutAttributeCenterX
                                            relatedBy:NSLayoutRelationEqual
                                            toItem:self
                                            attribute:NSLayoutAttributeLeading
                                            multiplier:1
                                            constant:25];
    NSLayoutConstraint *iconView_centerY = [NSLayoutConstraint
                                            constraintWithItem:self.iconView
                                            attribute:NSLayoutAttributeCenterY
                                            relatedBy:NSLayoutRelationEqual
                                            toItem:self
                                            attribute:NSLayoutAttributeCenterY
                                            multiplier:1
                                            constant:0];
    [NSLayoutConstraint activateConstraints:@[iconView_centerX, iconView_centerY]];
}

- (void)titleLayout {
    NSLayoutConstraint *title_centerX = [NSLayoutConstraint
                                         constraintWithItem:self.titleLabel
                                         attribute:NSLayoutAttributeCenterX
                                         relatedBy:NSLayoutRelationEqual
                                         toItem:self
                                         attribute:NSLayoutAttributeCenterX
                                         multiplier:1
                                         constant:0];
    NSLayoutConstraint *title_centerY = [NSLayoutConstraint
                                         constraintWithItem:self.titleLabel
                                         attribute:NSLayoutAttributeCenterY
                                         relatedBy:NSLayoutRelationEqual
                                         toItem:self
                                         attribute:NSLayoutAttributeCenterY
                                         multiplier:1
                                         constant:0];
    [NSLayoutConstraint activateConstraints:@[title_centerX, title_centerY]];
}

- (void)indicatorLayout {
    NSLayoutConstraint *indicator_trailing = [NSLayoutConstraint
                                              constraintWithItem:self.indicatorView
                                              attribute:NSLayoutAttributeTrailing
                                              relatedBy:NSLayoutRelationEqual
                                              toItem:self
                                              attribute:NSLayoutAttributeTrailing
                                              multiplier:1
                                              constant:-5.5];
    NSLayoutConstraint *indicator_width    = [NSLayoutConstraint
                                              constraintWithItem:self.indicatorView
                                              attribute:NSLayoutAttributeWidth
                                              relatedBy:NSLayoutRelationEqual
                                              toItem:nil
                                              attribute:NSLayoutAttributeNotAnAttribute
                                              multiplier:1
                                              constant:18];
    NSLayoutConstraint *indicator_height   = [NSLayoutConstraint
                                              constraintWithItem:self.indicatorView
                                              attribute:NSLayoutAttributeHeight
                                              relatedBy:NSLayoutRelationEqual
                                              toItem:nil
                                              attribute:NSLayoutAttributeNotAnAttribute
                                              multiplier:1
                                              constant:15];
    NSLayoutConstraint *indicator_centerY  = [NSLayoutConstraint
                                              constraintWithItem:self.indicatorView
                                              attribute:NSLayoutAttributeCenterY
                                              relatedBy:NSLayoutRelationEqual
                                              toItem:self
                                              attribute:NSLayoutAttributeCenterY
                                              multiplier:1
                                              constant:0];
    [NSLayoutConstraint activateConstraints:@[indicator_trailing, indicator_centerY, indicator_width, indicator_height]];
}

@end

@interface DMCell ()

@property (strong, nonatomic) UIImageView *iconImage;
@property (strong, nonatomic) UILabel *titleLabel;

@end

@implementation DMCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor colorWithRed:28.f/255.f green:28.f/255.f blue:28.f/255.f alpha:1];

        self.iconImage = [[UIImageView alloc] init];
        self.iconImage.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:self.iconImage];
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:self.titleLabel];
        
        [self iconLayout];
        [self titleLayout];

    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

- (void)updateCell:(id)model {
    self.iconImage.image = [UIImage imageNamed:model];
    self.titleLabel.text = model;
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    self.backgroundColor = [UIColor darkGrayColor];
}

- (void)iconLayout {
    NSLayoutConstraint *icon_centerX = [NSLayoutConstraint
                                        constraintWithItem:self.iconImage
                                        attribute:NSLayoutAttributeCenterX
                                        relatedBy:NSLayoutRelationEqual
                                        toItem:self.contentView
                                        attribute:NSLayoutAttributeLeading
                                        multiplier:1
                                        constant:25];
    NSLayoutConstraint *icon_top     = [NSLayoutConstraint
                                        constraintWithItem:self.iconImage
                                        attribute:NSLayoutAttributeTop
                                        relatedBy:NSLayoutRelationEqual
                                        toItem:self.contentView
                                        attribute:NSLayoutAttributeTop
                                        multiplier:1
                                        constant:10];
    NSLayoutConstraint *icon_bottom  = [NSLayoutConstraint
                                        constraintWithItem:self.iconImage
                                        attribute:NSLayoutAttributeBottom
                                        relatedBy:NSLayoutRelationEqual
                                        toItem:self.contentView
                                        attribute:NSLayoutAttributeBottom
                                        multiplier:1
                                        constant:-10];
    
    [NSLayoutConstraint activateConstraints:@[icon_centerX, icon_top, icon_bottom]];
}

- (void)titleLayout {
    NSLayoutConstraint *title_centerX = [NSLayoutConstraint
                                         constraintWithItem:self.titleLabel
                                         attribute:NSLayoutAttributeCenterX
                                         relatedBy:NSLayoutRelationEqual
                                         toItem:self.contentView
                                         attribute:NSLayoutAttributeCenterX
                                         multiplier:1
                                         constant:0];
    NSLayoutConstraint *title_centerY = [NSLayoutConstraint
                                         constraintWithItem:self.titleLabel
                                         attribute:NSLayoutAttributeCenterY
                                         relatedBy:NSLayoutRelationEqual
                                         toItem:self.contentView
                                         attribute:NSLayoutAttributeCenterY
                                         multiplier:1
                                         constant:0];
    NSLayoutConstraint *title_width = [NSLayoutConstraint
                                         constraintWithItem:self.titleLabel
                                         attribute:NSLayoutAttributeWidth
                                         relatedBy:NSLayoutRelationEqual
                                         toItem:self.contentView
                                         attribute:NSLayoutAttributeWidth
                                         multiplier:1
                                         constant:0];
    [NSLayoutConstraint activateConstraints:@[title_centerX, title_centerY, title_width]];
}

@end
