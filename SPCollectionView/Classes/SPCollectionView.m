//
//  SPCollectionView.m
//  SPCollectionView
//
//  Created by GheniAblez on 2023/8/14.
//

#import "SPCollectionView.h"
#import "SPBaseItem.h"
#import <MJRefresh/MJRefresh.h>

static NSMutableDictionary *itemDictioanry;

@interface SPCollectionView() <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic,strong) NSMutableArray<SPViewModel *> *dataList;

//总高度
@property (nonatomic,assign) CGFloat totalHeight;
//nsdictionary
@property (nonatomic,strong) NSMutableArray *breakLineDict;


@end

@implementation SPCollectionView

//注册
+ (void)registerItem:(NSInteger)viewType class:(Class)itemClass{
    if(itemDictioanry == nil){
        itemDictioanry = [[NSMutableDictionary alloc]init];
    }
    [itemDictioanry setObject:itemClass forKey:[NSString stringWithFormat:@"%ld",(long)viewType]];
}


//创建
+ (SPCollectionView *)create:(id)delegate{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    
    SPCollectionView *collectionView = [[SPCollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor clearColor];
    collectionView.delegate = collectionView;
    collectionView.dataSource = collectionView;
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.userDelegate = delegate;
    collectionView.semanticContentAttribute = UISemanticContentAttributeForceRightToLeft;
    collectionView.totalHeight = 0;
    return collectionView;
}


//点击回掉
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if(self.userDelegate != nil){
        if([self.userDelegate respondsToSelector:@selector(onItemClick:model:index:)]){
            [self.userDelegate onItemClick:self model:self.dataList[indexPath.row] index:indexPath.row];
        }
    }
}

//确定大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    SPViewModel *model = self.dataList[indexPath.row];
    CGFloat width;
    if(model.viewSpan != 0){
        width = (self.frame.size.width - 0.001) / (60.f / model.viewSpan);
    }else{
        width = self.frame.size.width;
    }
    CGSize size = CGSizeMake(width, 100);
    Class itemClass = [itemDictioanry objectForKey:[NSString stringWithFormat:@"%ld",(long)model.viewType]];
    if([itemClass respondsToSelector:@selector(itemHeight:)]){
        size = CGSizeMake(width, [itemClass itemHeight:width]);
    }
    

    
    
    //计算总高度
    long row = indexPath.row;
    //if row in the breakLineDict
    if([self.breakLineDict containsObject:@(row)]){
        self.totalHeight += size.height;
    }

    if(indexPath.row == self.dataList.count - 1){
        if(self.userDelegate != nil){
            if([self.userDelegate respondsToSelector:@selector(onGetHeight:)]){
                [self.userDelegate onGetHeight:self.totalHeight];
            }
        }
    }
    
    return size;
    
}

//确定数量
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSInteger span = 0;
    self.breakLineDict = [[NSMutableArray alloc]init];
    [self.breakLineDict addObject:@((long)0)];
    for (SPViewModel *model in self.dataList) {
        span += model.viewSpan;
        if(span > 60){
            long index = [self.dataList indexOfObject:model];
            [self.breakLineDict addObject:@(index)];
            span = model.viewSpan;
        }
    }
    return self.dataList.count;
}


//确定cell
- (SPBaseItem *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SPViewModel *model = self.dataList[(NSUInteger) indexPath.row];
    SPBaseItem *item = [self dequeueReusableCellWithReuseIdentifier:[@"viewType" stringByAppendingFormat:@"%ld",(long)model.viewType] forIndexPath:indexPath];
    item.data = self.dataList[(NSUInteger) indexPath.row];
    item.userDelegate = self.userDelegate;
    return item;
}


//数据源
- (void)setData:(NSArray<SPViewModel *> *)data{
    self.totalHeight = 0;
    _dataList = [[NSMutableArray alloc]initWithArray:data];
    for (SPViewModel *model in data) {
        [self registerClass:[itemDictioanry objectForKey:[NSString stringWithFormat:@"%ld",(long)model.viewType]] forCellWithReuseIdentifier:[@"viewType" stringByAppendingFormat:@"%ld",(long)model.viewType]];
    }
    [self reloadData];
}


//添加数据源
- (void)addData:(NSArray<SPViewModel *> *)data{
    self.totalHeight = 0;
    [_dataList addObjectsFromArray:data];
    for (SPViewModel *model in data) {
        [self registerClass:[itemDictioanry objectForKey:[NSString stringWithFormat:@"%ld",(long)model.viewType]] forCellWithReuseIdentifier:[@"viewType" stringByAppendingFormat:@"%ld",(long)model.viewType]];
    }
    [self reloadData];
}

//刷新
- (void)enableRefresh{
    self.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if(self.userDelegate != nil){
            if([self.userDelegate respondsToSelector:@selector(onRefresh)]){
                [self.userDelegate onRefresh];
            }
        }
    }];
}
- (void)enableRefresh:(MJRefreshHeader *)header{
    self.mj_header = header;
}

//停止刷新
- (void)stopRefresh{
    [self.mj_header endRefreshing];
}


//停止加载更多
- (void)stopLoadMore{
    [self.mj_footer endRefreshing];
}

//加载更多
- (void)enableLoadMore{
    self.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        if(self.userDelegate != nil){
            if([self.userDelegate respondsToSelector:@selector(onLoadMore)]){
                [self.userDelegate onLoadMore];
            }
        }
    }];
}
- (void)enableLoadMore:(MJRefreshFooter *)footer{
    self.mj_footer = footer;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if(self.userDelegate != nil){
        if([self.userDelegate respondsToSelector:@selector(onScroll:)]){
            [self.userDelegate onScroll:scrollView];
        }
    }

}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if(self.userDelegate != nil){
        if([self.userDelegate respondsToSelector:@selector(onScrollBegin:)]){
            [self.userDelegate onScrollBegin:scrollView];
        }
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if(self.userDelegate != nil){
        if([self.userDelegate respondsToSelector:@selector(onScrollEnd:)]){
            [self.userDelegate onScrollEnd:scrollView];
        }
    }
}

@end
