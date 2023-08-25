//
//  SPCollectionViewDelegate.h
//  SPCollectionView
//
//  Created by GheniAblez on 2023/8/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@class SPCollectionView;
@class SPViewModel;
@protocol SPCollectionViewDelegate <NSObject>
@optional
- (void)onItemClick:(SPCollectionView *)collectionView model:(SPViewModel *)model index:(NSInteger)index;
- (void)onItemChildClick:(NSDictionary *)data;
- (void)onRefresh;
- (void)onLoadMore;
- (void)onGetHeight:(CGFloat)height;
- (void)onScroll:(UIScrollView *)scrollView;
- (void)onScrollBegin:(UIScrollView *)scrollView;
- (void)onScrollEnd:(UIScrollView *)scrollView;
@end

NS_ASSUME_NONNULL_END
