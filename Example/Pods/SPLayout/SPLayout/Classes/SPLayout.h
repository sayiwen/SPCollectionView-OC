//
//  SPLayout.h
//  SPLayout
//
//  Created by GheniAblez on 2023/8/9.
//

#import <Foundation/Foundation.h>
#import <Masonry/Masonry.h>

NS_ASSUME_NONNULL_BEGIN

@interface SPLayout : NSObject

@property (nonatomic,strong) MASConstraintMaker *constraintMaker;
@property (nonatomic,strong) UIView *view;
@property (nonatomic,assign) BOOL isRtlOnly;

+ (void)setRtl:(BOOL)rtl;

+ (SPLayout * (^)(UIView *attr))layout;

#pragma mark - rtlOnly
- (SPLayout * (^)(void))rtlOnly;

#pragma mark - right
- (SPLayout * (^)(id attr))rightToRightOf;
- (SPLayout * (^)(id attr))rightToLeftOf;
- (SPLayout * (^)(id attr,CGFloat margin))rightToRightOfMargin;
- (SPLayout * (^)(id attr,CGFloat margin))rightToLeftOfMargin;

#pragma mark - left
- (SPLayout * (^)(id attr))leftToLeftOf;
- (SPLayout * (^)(id attr))leftToRightOf;
- (SPLayout * (^)(id attr,CGFloat margin))leftToLeftOfMargin;
- (SPLayout * (^)(id attr,CGFloat margin))leftToRightOfMargin;

#pragma mark - center
- (SPLayout * (^)(id attr))center;
- (SPLayout * (^)(id attr))centerX;
- (SPLayout * (^)(CGFloat x))centerXEqual;
- (SPLayout * (^)(id attr,CGFloat margin))centerXMargin;
- (SPLayout * (^)(id attr))centerY;
- (SPLayout * (^)(id attr,CGFloat margin))centerYMargin;

#pragma mark - top
- (SPLayout * (^)(id attr))topToTopOf;
- (SPLayout * (^)(id attr))topToBottomOf;
- (SPLayout * (^)(id attr,CGFloat margin))topToTopOfMargin;
- (SPLayout * (^)(id attr,CGFloat margin))topToBottomOfMargin;

#pragma mark - bottom
- (SPLayout * (^)(id attr))bottomToBottomOf;
- (SPLayout * (^)(id attr))bottomToTopOf;
- (SPLayout * (^)(id attr,CGFloat margin))bottomToBottomOfMargin;
- (SPLayout * (^)(id attr,CGFloat margin))bottomToTopOfMargin;

#pragma mark - width
- (SPLayout * (^)(CGFloat width))width;
- (SPLayout * (^)(id attr))widthEqual;
- (SPLayout * (^)(id attr,CGFloat multiplier))widthEqualWithMultiplier;

#pragma mark - height
- (SPLayout * (^)(CGFloat height))height;
- (SPLayout * (^)(id attr))heightEqual;
- (SPLayout * (^)(id attr,CGFloat multiplier))heightEqualWithMultiplier;

#pragma mark - size
- (SPLayout * (^)(CGSize size))size;
- (SPLayout * (^)(id attr))sizeEqual;
- (SPLayout * (^)(id attr,CGFloat multiplier))sizeEqualWithMultiplier;

#pragma mark - tools
- (SPLayout * (^)(void))debug;

- (SPLayout * (^)(void))install;



@end

NS_ASSUME_NONNULL_END
