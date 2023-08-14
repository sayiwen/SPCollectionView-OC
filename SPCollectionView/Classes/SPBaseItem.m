//
//  SPBaseItem.m
//  SPCollectionView
//
//  Created by GheniAblez on 2023/8/14.
//

#import "SPBaseItem.h"

@implementation SPBaseItem

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void)setupView{
    
}

@end
