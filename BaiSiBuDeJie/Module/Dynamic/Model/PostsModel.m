//
//  PostsModel.m
//  BaiSiBuDeJie
//
//  Created by bjovov on 2018/1/2.
//  Copyright © 2018年 caoxueliang.cn. All rights reserved.
//

#import "PostsModel.h"

@implementation PostsImageModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"downloadArray" : @"download_url",
             @"thumbnailArray" : @"thumbnail_small",
             @"bigArray" : @"big",
             };
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"downloadArray" : [NSString class],
             @"thumbnailArray" : [NSString class],
             @"bigArray" : [NSString class],
             };
}
@end


@implementation PostsVideoModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"thumbnailArray" : @"thumbnail",
             @"downloadArray" : @"download",
             @"thumbnailSmallArray" : @"thumbnail_small",
             @"videoArray" : @"video",
             };
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"thumbnailArray" : [NSString class],
             @"downloadArray" : [NSString class],
             @"thumbnailSmallArray" : [NSString class],
             @"videoArray" : [NSString class],
             };
}
@end


@implementation PostsTagModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"tagId" : @"id",
             };
}
@end


@implementation PostsUserModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"headerArray" : @"header",
             };
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"headerArray" : [NSString class],
             };
}
@end


@implementation PostsCommentModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"commentId" : @"id",
             };
}
@end


@implementation PostsModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"postsId" : @"id",
             };
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"tags" : [PostsTagModel class],
             @"top_comments" : [PostsCommentModel class],
             };
}

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    NSString *type = dic[@"type"];
    if ([type isEqualToString:@"text"]) {
        _contentType = postsContentTypeText;
    }else if ([type isEqualToString:@"image"]){
        _contentType = postsContentTypeImage;
    }else if ([type isEqualToString:@"video"]){
        _contentType = postsContentTypeVideo;
    }
    return YES;
}

@end

