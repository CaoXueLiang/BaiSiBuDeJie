//
//  PostsVideoCollectionViewCell.h
//  BaiSiBuDeJie
//
//  Created by bjovov on 2018/1/4.
//  Copyright © 2018年 caoxueliang.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 视频CollectionViewCell
 */
@class PostsModel;
@interface PostsVideoCollectionViewCell : UICollectionViewCell
@property (nonatomic,strong) PostsModel *model;
+ (CGSize)cellSizeWithModel:(PostsModel *)model layout:(UICollectionViewLayout *)layout;
@end
