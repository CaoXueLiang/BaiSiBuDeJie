//
//  CXLPersonalCenterController.m
//  BaiSiBuDeJie
//
//  Created by 曹学亮 on 2018/1/24.
//  Copyright © 2018年 caoxueliang.cn. All rights reserved.
//

#import "CXLPersonalCenterController.h"

@interface CXLPersonalCenterController ()
@property (nonatomic,copy) NSString *memberId;
@end

@implementation CXLPersonalCenterController
#pragma mark - Init Menthod
+ (instancetype)initWithMemberId:(NSString *)memberId{
    CXLPersonalCenterController *controller = [[CXLPersonalCenterController alloc]init];
    controller.memberId = memberId;
    return controller;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
}



@end
