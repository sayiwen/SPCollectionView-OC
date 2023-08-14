//
//  SPViewController.m
//  SPCollectionView
//
//  Created by sayiwen on 08/14/2023.
//  Copyright (c) 2023 sayiwen. All rights reserved.
//

#import "SPViewController.h"
#import <SPCollectionView/SPCollectionView.h>
#import <SPLayout/SPLayout.h>
#import "SPSongItem.h"

@interface SPViewController ()<SPCollectionViewDelegate>

@property (nonatomic, strong) SPCollectionView *collectionView;

@property (nonatomic, assign) NSInteger page;

@end

@implementation SPViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [SPCollectionView registerItem:0 class:SPSongItem.class];
    
	// Do any additional setup after loading the view, typically from a nib.
    SPCollectionView *collectionView = [SPCollectionView create:self];
    self.collectionView = collectionView;
    
    [collectionView enableRefresh];
    
    MJRefreshNormalHeader *header = (MJRefreshNormalHeader *)collectionView.mj_header;
    header.lastUpdatedTimeLabel.hidden = YES;
    [header setTitle:@"Hello" forState:MJRefreshStateRefreshing];

    
    [collectionView enableLoadMore];
    
    NSMutableArray *array = [NSMutableArray array];
    //20 data
    for (int i = 0; i < 20; i++) {
        SPViewModel *model = [[SPViewModel alloc] init];
        model.viewType = 0;
        [array addObject:model];
    }
    self.page = 1;
    [collectionView setData:[array copy]];
    
    collectionView.backgroundColor = UIColor.whiteColor;
    
    [self.view addSubview:collectionView];
}

- (void)onRefresh{
    [self.collectionView stopRefresh];
}

- (void)onLoadMore{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.page++;
        NSMutableArray *array = [NSMutableArray array];
        //20 data
        for (int i = 0; i < 20; i++) {
            SPViewModel *model = [[SPViewModel alloc] init];
            model.viewType = 0;
            model.viewSpan = 60/self.page;
            [array addObject:model];
        }
        
        
        [self.collectionView addData:[array copy]];
        [self.collectionView stopLoadMore];
    });
    
}

- (void)viewWillLayoutSubviews{
    SPLayout.layout(self.collectionView)
    .rightToRightOfMargin(self.view,10)
    .leftToLeftOfMargin(self.view,10)
    .topToTopOfMargin(self.view,60)
    .bottomToBottomOf(self.view)
    .install();
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
