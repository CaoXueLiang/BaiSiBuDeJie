//
//  PostsCell.h
//  BaiSiBuDeJie
//
//  Created by bjovov on 2018/1/2.
//  Copyright © 2018年 caoxueliang.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PostsLayouts,PostsCell,PostsToolBarView,PostsProfileView;
@protocol PostsCellDelegate <NSObject>
- (void)didClickedExpendButton:(NSInteger)index;
- (void)didClickedUpButon:(NSInteger)index;
- (void)didClickedDownButton:(NSInteger)index;
@end

/**
 帖子Cell
 */
@interface PostsCell : UITableViewCell
@property (nonatomic,weak) id<PostsCellDelegate> delegate;
@property (nonatomic,strong) PostsLayouts *layout;
@property (nonatomic,assign) NSInteger selectIndex;
@property (nonatomic,strong) PostsProfileView *profileView;
@property (nonatomic,strong) PostsToolBarView *toolbarView;

/*点赞动画*/
- (void)upButtonAnimation;
/*踩动画*/
- (void)downButtonAnimation;

@end
