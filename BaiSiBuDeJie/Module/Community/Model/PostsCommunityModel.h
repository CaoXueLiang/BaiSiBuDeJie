//
//  PostsCommunityModel.h
//  BaiSiBuDeJie
//
//  Created by 曹学亮 on 2018/1/21.
//  Copyright © 2018年 caoxueliang.cn. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 社区Model
 */
@interface PostsCommunityModel : NSObject
@property (nonatomic,copy) NSString *today_topic_num;
@property (nonatomic,copy) NSString *tail;
@property (nonatomic,copy) NSString *post_num;
@property (nonatomic,copy) NSString *sub_number;
@property (nonatomic,copy) NSString *theme_name;
@property (nonatomic,copy) NSString *display_level;
@property (nonatomic,copy) NSString *is_sub;
@property (nonatomic,copy) NSString *visit;
@property (nonatomic,copy) NSString *colum_set;
@property (nonatomic,copy) NSString *theme_id;
@property (nonatomic,copy) NSString *image_detail;
@property (nonatomic,copy) NSString *info;
@property (nonatomic,copy) NSString *image_list;
@end

