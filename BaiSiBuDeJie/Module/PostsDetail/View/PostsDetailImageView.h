//
//  PostsDetailImageView.h
//  BaiSiBuDeJie
//
//  Created by 曹学亮 on 2018/1/14.
//  Copyright © 2018年 caoxueliang.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 帖子详情图片View
 */
@class PostsModel;
@interface PostsDetailImageView : UIView
@property (nonatomic,strong) PostsModel *postsModel;
@end
