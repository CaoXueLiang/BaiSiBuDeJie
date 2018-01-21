//
//  CXLMineItermCell.m
//  BaiSiBuDeJie
//
//  Created by 曹学亮 on 2018/1/21.
//  Copyright © 2018年 caoxueliang.cn. All rights reserved.
//

#import "CXLMineItermCell.h"
#import "CXLMineCollectionViewCell.h"
#import "CXLMineItermModel.h"

@interface CXLMineItermCell()
<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) UICollectionView *myCollection;
@end

@implementation CXLMineItermCell
#pragma mark - Init Menthod
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubViews];
    }
    return self;
}

- (void)addSubViews{
    [self.contentView addSubview:self.myCollection];
}

+ (CGFloat)cellHeight{
    return 170.0f;
}

#pragma mark - UICollectionView M
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CXLMineItermModel *model = self.dataArray[indexPath.row];
    CXLMineCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CXLMineCollectionViewCell" forIndexPath:indexPath];
    cell.itermModel = model;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark - Setter && Getter
- (UICollectionView *)myCollection{
    if (!_myCollection) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.itemSize = CGSizeMake(kScreenWidth/5.0, 85);
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        _myCollection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 170) collectionViewLayout:layout];
        _myCollection.backgroundColor = [UIColor whiteColor];
        _myCollection.delegate = self;
        _myCollection.dataSource = self;
        [_myCollection registerClass:[CXLMineCollectionViewCell class] forCellWithReuseIdentifier:@"CXLMineCollectionViewCell"];
    }
    return _myCollection;
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]init];
        NSArray *tmp = @[@{
                             @"imageName":@"mine-icon-recentHot_44x44_",
                             @"tip":@"排行榜",
                             },
                         @{
                             @"imageName":@"mine-icon-preview_44x44_",
                             @"tip":@"审帖",
                             },
                         @{
                             @"imageName":@"mine_icon_nearby_44x44_",
                             @"tip":@"我的收藏",
                             },
                         @{
                             @"imageName":@"mine-icon-recentHot_44x44_",
                             @"tip":@"内容贡献榜",
                             },
                         @{
                             @"imageName":@"mine_icon_random_44x44_",
                             @"tip":@"随机穿越",
                             },
                         @{
                             @"imageName":@"mine-icon-search_44x44_",
                             @"tip":@"搜索",
                             },
                         @{
                             @"imageName":@"mine-icon-feedback_44x44_",
                             @"tip":@"意见反馈",
                             },
                         @{
                             @"imageName":@"mine-icon-recentHot_44x44_",
                             @"tip":@"百思交友",
                             },
                         @{
                             @"imageName":@"mine-icon-recentHot_44x44_",
                             @"tip":@"百思帮派",
                             },
                         @{
                             @"imageName":@"mine-icon-more_44x44_",
                             @"tip":@"更多",
                             },
                         ];
        [tmp enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            CXLMineItermModel *model = [CXLMineItermModel yy_modelWithJSON:obj];
            [_dataArray addObject:model];
        }];
    }
    return _dataArray;
}

@end
