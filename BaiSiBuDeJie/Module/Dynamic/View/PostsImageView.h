//
//  PostsImageView.h
//  BaiSiBuDeJie
//
//  Created by bjovov on 2018/1/2.
//  Copyright © 2018年 caoxueliang.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 图片View
 */
@class PostsModel;
@interface PostsImageView : UIView
@property (nonatomic,strong) PostsModel *model;
@end
