//
//  SPSongItem.m
//  SPCollectionView_Example
//
//  Created by GheniAblez on 2023/8/14.
//  Copyright © 2023 sayiwen. All rights reserved.
//

#import "SPSongItem.h"
#import <SPLayout/SPLayout.h>

@implementation SPSongItem


+ (CGFloat)itemHeight:(CGFloat)width{
    return 100;
}

- (void)setupView{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor systemBlueColor];
    [self addSubview:view];
    SPLayout.layout(view).leftToLeftOfMargin(self,10).rightToRightOfMargin(self,10).height(50).install();
    
}

@end
