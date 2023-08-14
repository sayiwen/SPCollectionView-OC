//
//  SPSongItem.m
//  SPCollectionView_Example
//
//  Created by GheniAblez on 2023/8/14.
//  Copyright © 2023 sayiwen. All rights reserved.
//

#import "SPSongItem.h"
#import <SPLayout/SPLayout.h>
#import "SPSong.h"


@interface SPSongItem()

//title
@property (nonatomic, weak) UILabel *title;


@end

@implementation SPSongItem


+ (CGFloat)itemHeight:(CGFloat)width{
    return 100;
}

- (void)setupView{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor systemBlueColor];
    [self addSubview:view];
    SPLayout.layout(view).leftToLeftOfMargin(self,10).rightToRightOfMargin(self,10).height(50).centerY(self).install();
    [view.layer setCornerRadius:10];
    view.clipsToBounds = YES;
    
    UILabel *title = [UILabel new];
    title.text = @"title";
    title.textColor = UIColor.whiteColor;
    [view addSubview:title];
    self.title = title;
    SPLayout.layout(title).center(view).install();
    
}

- (void)setData:(SPSong *)data{
    [self.title setText:data.title];
}

@end
