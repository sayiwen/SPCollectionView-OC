//
//  SPCollectionView.h
//  SPCollectionView
//
//  Created by GheniAblez on 2023/8/14.
//

#import <UIKit/UIKit.h>
#import "SPViewModel.h"
#import <MJRefresh/MJRefresh.h>
#import "SPCollectionView.h"
#import "SPBaseItem.h"
#import "SPCollectionViewDelegate.h"


NS_ASSUME_NONNULL_BEGIN
@interface SPCollectionView : UICollectionView

@property (nonatomic, weak, nullable) id <SPCollectionViewDelegate> userDelegate;

+ (void)registerItem:(NSInteger)viewType class:(Class)itemClass;

+ (SPCollectionView *)create:(id)delegate;


- (void)setData:(NSArray<SPViewModel *> *)data;

- (void)addData:(NSArray<SPViewModel *> *)data;

- (void)enableRefresh;
- (void)enableRefresh:(MJRefreshHeader *)header;

- (void)enableLoadMore;
- (void)enableLoadMore:(MJRefreshFooter *)footer;

- (void)stopRefresh;

- (void)stopLoadMore;


@end

NS_ASSUME_NONNULL_END
