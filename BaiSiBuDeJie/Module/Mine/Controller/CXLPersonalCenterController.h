//
//  CXLPersonalCenterController.h
//  BaiSiBuDeJie
//
//  Created by 曹学亮 on 2018/1/24.
//  Copyright © 2018年 caoxueliang.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 个人中心
 */
@class PostsModel;
@interface CXLPersonalCenterController : UIViewController
+ (instancetype)initWithModel:(PostsModel *)model;
@end

/**
 * 个人信息详情URL：
 * http://d.api.budejie.com/user/profile?appname=bs0315&asid=91344335-9305-4C86-881F-56E9C333D8BA&client=iphone&device=iPhone%205S&from=ios&jbk=1&market=&openudid=26a043f8294d182c9ca9d4665eb74d69ca6b8ee3&sex=m&t=1516956353&udid=&uid=21665716&userid=21062946&ver=4.5.7
 
 * 帖子：
 * http://s.budejie.com/topic/user-topic/21062946/1/desc/bs0315-iphone-4.5.7/0-20.json
 *
 * 分享：
 * http://s.budejie.com/topic/share-topic/21062946/bs0315-iphone-4.5.7/0-20.json
 *
 * 评论：
 * http://s.budejie.com/comment/user-comment/21062946/bs0315-iphone-4.5.7/0-20.json
 */
