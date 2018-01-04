//
//  PostsCell.h
//  BaiSiBuDeJie
//
//  Created by bjovov on 2018/1/2.
//  Copyright © 2018年 caoxueliang.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PostsLayouts;
@protocol PostsCellDelegate <NSObject>
- (void)didClickedExpendButton:(NSInteger)index;
@end

/**
 帖子Cell
 */
@interface PostsCell : UITableViewCell
@property (nonatomic,weak) id<PostsCellDelegate> delegate;
@property (nonatomic,strong) PostsLayouts *layout;
@property (nonatomic,assign) NSInteger selectIndex;
@end
