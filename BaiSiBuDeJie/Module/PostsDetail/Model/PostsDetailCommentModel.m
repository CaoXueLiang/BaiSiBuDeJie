//
//  PostsDetailCommentModel.m
//  BaiSiBuDeJie
//
//  Created by bjovov on 2018/1/11.
//  Copyright © 2018年 caoxueliang.cn. All rights reserved.
//

#import "PostsDetailCommentModel.h"

@implementation PostsDetailUserModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"userId" : @"id",};
}
@end


@implementation PostsImageCommentModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"downloadArray" : @"download",
             @"thumbnailArray" : @"thumbnail",
             @"imagesArray" : @"images",
             };
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"downloadArray" : [NSString class],
             @"thumbnailArray" : [NSString class],
             @"imagesArray" : [NSString class],
             };
}
@end


@implementation PostsAudioCommentModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"audioArray" : @"audio",};
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"audioArray" : [NSString class],};
}
@end

@implementation PostsDetailCommentModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"precmtsArray" : @"precmts",
             @"commentId" : @"id",
             };
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"precmtsArray" : [PostsDetailCommentModel class],
             };
}

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    NSString *type = dic[@"type"];
    if ([type isEqualToString:@"text"]) {
        _commentType = postsCommentTypeImage;
    }else if ([type isEqualToString:@"image"]){
        _commentType = postsCommentTypeImage;
    }else if ([type isEqualToString:@"video"]){
        _commentType = postsCommentTypeVideo;
    }else if ([type isEqualToString:@"audio"]){
        _commentType = postsCommentTypeAudio;
    }
    return YES;
}


@end
