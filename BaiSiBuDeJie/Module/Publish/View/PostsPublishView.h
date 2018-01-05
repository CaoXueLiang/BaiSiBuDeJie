//
//  PostsPublishView.h
//  BaiSiBuDeJie
//
//  Created by bjovov on 2018/1/4.
//  Copyright © 2018年 caoxueliang.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 发布视图
 */
@interface PostsPublishView : UIView
@property (nonatomic,copy) void(^doneBlock)(NSString *itermString);
- (void)showPickerView;
- (instancetype)initWithDoneBlock:(void(^)(NSString *itermString))block;
@end
