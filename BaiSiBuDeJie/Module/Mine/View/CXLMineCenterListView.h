//
//  CXLMineCenterListView.h
//  BaiSiBuDeJie
//
//  Created by 曹学亮 on 2018/1/30.
//  Copyright © 2018年 caoxueliang.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger ,MemberListType) {
    MemberListTypePosts,
    MemberListTypeShare,
    MemberListTypeComment,
};

/**
 个人中心ListView
 */
@interface CXLMineCenterListView : UIView
- (instancetype)initWithFrame:(CGRect)frame type:(MemberListType)type memberId:(NSString *)uid;
@end
