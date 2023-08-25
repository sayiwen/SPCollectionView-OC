//
//  SPBaseItem.h
//  SPCollectionView
//
//  Created by GheniAblez on 2023/8/14.
//

#import <UIKit/UIKit.h>
#import "SPViewModel.h"
#import "SPCollectionViewDelegate.h"



NS_ASSUME_NONNULL_BEGIN

@interface SPBaseItem : UICollectionViewCell

@property (nonatomic, strong) SPViewModel *data;

@property (nonatomic, strong, nullable) id <SPCollectionViewDelegate> userDelegate;

+(CGFloat)itemHeight:(CGFloat)width;

- (void)setupView;


@end

NS_ASSUME_NONNULL_END
