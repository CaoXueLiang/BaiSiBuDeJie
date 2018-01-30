//
//  CXLTableView.m
//  BaiSiBuDeJie
//
//  Created by 曹学亮 on 2018/1/30.
//  Copyright © 2018年 caoxueliang.cn. All rights reserved.
//

#import "CXLTableView.h"

@implementation CXLTableView

// 这个方法是支持多手势，当滑动子控制器中的scrollView时，MyTableView也能接收滑动事件
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return [gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]] && [otherGestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]];
}

@end
