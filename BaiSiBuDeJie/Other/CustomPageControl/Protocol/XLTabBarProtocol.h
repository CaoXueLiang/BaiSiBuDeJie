//
//  XLTabBarProtocol.h
//  BaiSiBuDeJie
//
//  Created by 曹学亮 on 2018/1/25.
//  Copyright © 2018年 caoxueliang.cn. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - XLTabBarDataSource
@protocol XLTabBarDataSource <NSObject>
@required

/**
 每个索引对应的tarBar的名称
 @param index 索引
 @return tarBar名称
 */
- (NSString *)titleForIndex:(NSInteger)index;

@optional
/**
 索引下tarbar颜色
 @param index 索引
 @return tarbar颜色
 */
- (UIColor *)titleColorForIndex:(NSInteger)index;

/**
 高亮状态下文字颜色
 @param index 索引
 @return tarbar颜色
 */
- (UIColor *)titleHighLightColorForIndex:(NSInteger)index;

/**
 返回当前索引的字体大小
 @param index 索引
 @return tarbar字体
 */
- (UIFont *)titleFontForIndex:(NSInteger)index;


/**
 tarbar的iterm个数
 @return iterm个数
 */
- (NSInteger)numberOfTarBar;








@end
