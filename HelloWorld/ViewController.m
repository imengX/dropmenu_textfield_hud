//
//  ViewController.m
//  HelloWorld
//
//  Created by XenonChau on 22/08/2017.
//  Copyright © 2017 Code1Bit Co.,Ltd. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
#import "HexColors.h"
#import "ReactiveCocoa.h"

#import "XCDropMenu.h"
#import "XCTextField.h"
#import "XCHUDView.h"

@interface ViewController ()

@end

UIColor *bgColor;
UIColor *naviColor;
@implementation ViewController

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    naviColor = [UIColor hx_colorWithHexRGBAString:@"#1C1C1C"];
    bgColor = [UIColor hx_colorWithHexRGBAString:@"#2B2B2B"];
    [self setNeedsStatusBarAppearanceUpdate];
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = naviColor;
    [self.navigationController.navigationBar addSubview:view];
    
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.equalTo(self.navigationController.navigationBar);
        make.top.equalTo(self.navigationController.navigationBar).offset(-20);
    }];
    
    
    
    self.view.backgroundColor = bgColor;
    
    NSArray *fullCoinNames = @[@"BTC", @"COC", @"ETH", @"ETC"];
    XCDropMenu *topMenu = [[XCDropMenu alloc] initWithDataSource:fullCoinNames];
    topMenu.selectedCoin = @"BTC";
    [self.view addSubview:topMenu];
    [topMenu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(120);
        make.left.equalTo(self.view).offset(20);
        make.height.mas_equalTo(50);
        make.width.mas_equalTo(165);
    }];
//    topMenu.dataSource = fullCoinNames;
    
    
    XCDropMenu *secondMenu = [[XCDropMenu alloc] initWithDataSource:fullCoinNames];
    secondMenu.selectedCoin = @"COC";
    [self.view addSubview:secondMenu];
    [secondMenu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topMenu.mas_bottom).offset(20);
        make.leading.equalTo(self.view).offset(20);
        make.height.mas_equalTo(50);
        make.width.mas_equalTo(165);
    }];
//    secondMenu.dataSource = fullCoinNames;
    
    
    
    secondMenu.itemSelectCallback = ^(NSInteger index, NSString *coinName) {
        NSLog(@"%@", fullCoinNames[index]);
//        if ([coinName isEqualToString:@"COC"]) {
//            if ([topMenu.selectedCoin isEqualToString:@"COC"]) {
//                topMenu.titleLabel.text = @"BTC";
//                topMenu.iconView.image = [UIImage imageNamed:@"BTC"];
//                topMenu.selectedCoin = @"BTC";
//                [topMenu reloadDataSource];
//            }
//        } else {
//            topMenu.selectedCoin = @"COC";
//            [topMenu reloadDataSource];
//        }
    };
    
    topMenu.itemSelectCallback = ^(NSInteger index, NSString *coinName) {
        NSLog(@"%@", fullCoinNames[index]);
//        if ([coinName isEqualToString:@"COC"]) {
//            if ([secondMenu.selectedCoin isEqualToString:@"COC"]) {
//                secondMenu.titleLabel.text = @"BTC";
//                secondMenu.iconView.image = [UIImage imageNamed:@"BTC"];
//                secondMenu.selectedCoin = @"BTC";
//                [secondMenu reloadDataSource];
//            }
//        } else {
//            secondMenu.selectedCoin = @"COC";
//            [secondMenu reloadDataSource];
//        }
    };
    
    XCTextField *laolaoTextField = [[XCTextField alloc] init];
    laolaoTextField.placeholder = @"请输入你姥姥的名字";
    [self.view addSubview:laolaoTextField];
    [laolaoTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(topMenu.mas_trailing).offset(10);
        make.centerY.height.equalTo(topMenu);
        make.trailing.equalTo(self.view).offset(-20);
    }];
    
    XCTextField *yeyeTextField = [[XCTextField alloc] init];
    yeyeTextField.placeholder = @"请输入你爷爷的名字";
    [self.view addSubview:yeyeTextField];
    [yeyeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(secondMenu.mas_trailing).offset(10);
        make.centerY.height.equalTo(secondMenu);
        make.trailing.equalTo(self.view).offset(-20);
    }];
    
    XCHUDView *hud = [[XCHUDView alloc] init];
    hud.position = XCHUDPositionCenter;
    hud.style = XCHUDMessage;
    hud.animations = XCHUDAnimationStyleFallInAndOut;
    [self.view addSubview:hud];
    [hud mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.top.bottom.equalTo(self.view);
    }];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = (CGRect){100, 300, 50, 20};
    [button setTitle:@"next" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)buttonAction:(UIButton *)button {
    UIViewController *vc = [[UIViewController alloc] init];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:[UIView new]];
    vc.navigationItem.leftBarButtonItem = item;
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = (CGRect){100, 400, 80, 50};
    [button1 addTarget:self action:@selector(acb) forControlEvents:UIControlEventTouchUpInside];
    [button1 setTitle:@"返回" forState:UIControlStateNormal];
    [vc.view addSubview:button1];
    [self.navigationController showViewController:vc sender:nil];
}

- (void)acb {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
