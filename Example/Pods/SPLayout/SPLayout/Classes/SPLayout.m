//
//  SPLayout.m
//  SPLayout
//
//  Created by GheniAblez on 2023/8/9.
//

#import "SPLayout.h"

//static isRtl
static BOOL isRTL = NO;


@implementation SPLayout


- (instancetype)initWithView:(UIView *)view;
{
    self = [super init];
    if (self) {
        self.view = view;
        view.translatesAutoresizingMaskIntoConstraints = NO;
        self.constraintMaker = [[MASConstraintMaker alloc] initWithView:view];
    }
    return self;
}

+ (void)setRtl:(BOOL)rtl{
    isRTL = rtl;
}

+ (SPLayout * (^)(UIView*))layout {
    return ^id(id view) {
        return [[SPLayout alloc] initWithView:view];
    };
}

#pragma mark - rtlOnly
- (SPLayout * (^)(void))rtlOnly{
    return ^id() {
        self.isRtlOnly = YES;
        return self;
    };
}


#pragma mark - right
- (SPLayout * (^)(id attr,CGFloat margin))rightToRightOfMargin{
    return ^id(id attribute,CGFloat margin) {
        return [self rightToRightOfReal:attribute margin:margin];
    };
}
- (SPLayout *)rightToRightOfReal:(UIView *)view margin:(CGFloat)margin{
    if(isRTL || self.isRtlOnly){
        self.constraintMaker.right.equalTo(view).offset(margin*-1);
    }else{
        self.constraintMaker.left.equalTo(view).offset(margin);
    }
    return self;
}
- (SPLayout * (^)(id attr))rightToRightOf{
    return ^id(id attribute) {
        return [self rightToRightOfReal:attribute margin:0];
    };
}
- (SPLayout * (^)(id attr))rightToLeftOf{
    return ^id(id attribute) {
        return [self rightToLeftOfReal:attribute margin:0];
    };
}
- (SPLayout * (^)(id attr,CGFloat margin))rightToLeftOfMargin{
    return ^id(id attribute,CGFloat margin) {
        return [self rightToLeftOfReal:attribute margin:margin];
    };
}
- (SPLayout *)rightToLeftOfReal:(UIView *)view margin:(CGFloat)margin{
    if(isRTL || self.isRtlOnly){
        self.constraintMaker.right.equalTo(view.mas_left).offset(margin*-1);
    }else{
        self.constraintMaker.left.equalTo(view.mas_right).offset(margin);
    }
    return self;
}

#pragma mark - left
- (SPLayout * (^)(id attr))leftToLeftOf{
    return ^id(id attribute) {
        return [self leftToLeftOfReal:attribute margin:0];
    };
}
- (SPLayout * (^)(id attr))leftToRightOf{
    return ^id(id attribute) {
        return [self leftToRightOfReal:attribute margin:0];
    };
}
- (SPLayout * (^)(id attr,CGFloat margin))leftToLeftOfMargin{
    return ^id(id attribute,CGFloat margin) {
        return [self leftToLeftOfReal:attribute margin:margin];
    };
}
- (SPLayout *)leftToLeftOfReal:(UIView *)view margin:(CGFloat)margin{
    if(isRTL || self.isRtlOnly){
        self.constraintMaker.left.equalTo(view).offset(margin);
    }else{
        self.constraintMaker.right.equalTo(view).offset(margin*-1);
    }
    return self;
}
- (SPLayout * (^)(id attr,CGFloat margin))leftToRightOfMargin{
    return ^id(id attribute,CGFloat margin) {
        return [self leftToRightOfReal:attribute margin:margin];
    };
}
- (SPLayout *)leftToRightOfReal:(UIView *)view margin:(CGFloat)margin{
    if(isRTL || self.isRtlOnly){
        self.constraintMaker.left.equalTo(view.mas_right).offset(margin);
    }else{
        self.constraintMaker.right.equalTo(view.mas_left).offset(margin*-1);
    }
    return self;
}

#pragma mark - top
- (SPLayout * (^)(id attr))topToTopOf{
    return ^id(id attribute) {
        return [self topToTopOfReal:attribute margin:0];
    };
}
- (SPLayout * (^)(id attr))topToBottomOf{
    return ^id(id attribute) {
        return [self topToBottomOfReal:attribute margin:0];
    };
}
- (SPLayout * (^)(id attr,CGFloat margin))topToTopOfMargin{
    return ^id(id attribute,CGFloat margin) {
        return [self topToTopOfReal:attribute margin:margin];
    };
}
- (SPLayout *)topToTopOfReal:(UIView *)view margin:(CGFloat)margin{
    self.constraintMaker.top.equalTo(view).offset(margin);
    return self;
}
- (SPLayout * (^)(id attr,CGFloat margin))topToBottomOfMargin{
    return ^id(id attribute,CGFloat margin) {
        return [self topToBottomOfReal:attribute margin:margin];
    };
}
- (SPLayout *)topToBottomOfReal:(UIView *)view margin:(CGFloat)margin{
    self.constraintMaker.top.equalTo(view.mas_bottom).offset(margin);
    return self;
}

#pragma mark - bottom
- (SPLayout * (^)(id attr))bottomToBottomOf{
    return ^id(id attribute) {
        return [self bottomToBottomOfReal:attribute margin:0];
    };
}
- (SPLayout * (^)(id attr))bottomToTopOf{
    return ^id(id attribute) {
        return [self bottomToTopOfReal:attribute margin:0];
    };
}
- (SPLayout * (^)(id attr,CGFloat margin))bottomToBottomOfMargin{
    return ^id(id attribute,CGFloat margin) {
        return [self bottomToBottomOfReal:attribute margin:margin];
    };
}
- (SPLayout *)bottomToBottomOfReal:(UIView *)view margin:(CGFloat)margin{
    self.constraintMaker.bottom.equalTo(view).offset(margin);
    return self;
}
- (SPLayout * (^)(id attr,CGFloat margin))bottomToTopOfMargin{
    return ^id(id attribute,CGFloat margin) {
        return [self bottomToTopOfReal:attribute margin:margin];
    };
}
- (SPLayout *)bottomToTopOfReal:(UIView *)view margin:(CGFloat)margin{
    self.constraintMaker.bottom.equalTo(view).offset(margin);
    return self;
}

#pragma mark - center
- (SPLayout * (^)(id attr))center{
    return ^id(id attribute) {
        return [self centerReal:attribute];
    };
}
- (SPLayout *)centerReal:(UIView *)view{
    self.constraintMaker.center.equalTo(view);
    return self;
}

- (SPLayout * (^)(id attr,CGFloat margin))centerXMargin{
    return ^id(id attribute,CGFloat margin) {
        return [self centerXReal:attribute margin:margin];
    };
}
- (SPLayout * (^)(id attr))centerX{
    return ^id(id attribute) {
        return [self centerXReal:attribute margin:0];
    };
}
- (SPLayout * (^)(CGFloat x))centerXEqual{
    return ^id(CGFloat x) {
        self.constraintMaker.centerX.mas_equalTo(x);
        return self;
    };
}

- (SPLayout *)centerXReal:(UIView *)view margin:(CGFloat)margin{
    if(isRTL || self.isRtlOnly){
        margin = -1 * margin;
    }
    self.constraintMaker.centerX.equalTo(view).offset(margin);
    return self;
}
- (SPLayout * (^)(id attr,CGFloat margin))centerYMargin{
    return ^id(id attribute,CGFloat margin) {
        return [self centerYReal:attribute margin:margin];
    };
}
- (SPLayout * (^)(id attr))centerY{
    return ^id(id attribute) {
        return [self centerYReal:attribute margin:0];
    };
}
- (SPLayout *)centerYReal:(UIView *)view margin:(CGFloat)margin{
    self.constraintMaker.centerY.equalTo(view).offset(margin);
    return self;
}

#pragma mark - width
- (SPLayout * (^)(CGFloat width))width{
    return ^id(CGFloat width) {
        self.constraintMaker.width.equalTo(@(width));
        return self;
    };
}
- (SPLayout * (^)(id attr))widthEqual{
    return ^id(id attribute) {
        self.constraintMaker.width.equalTo(attribute);
        return self;
    };
}
- (SPLayout * (^)(id attr,CGFloat multiplier))widthEqualWithMultiplier{
    return ^id(id attribute,CGFloat multiplier) {
        self.constraintMaker.width.equalTo(attribute).multipliedBy(multiplier);
        return self;
    };
}

#pragma mark - height
- (SPLayout * (^)(CGFloat height))height{
    return ^id(CGFloat height) {
        self.constraintMaker.height.equalTo(@(height));
        return self;
    };
}
- (SPLayout * (^)(id attr))heightEqual{
    return ^id(id attribute) {
        self.constraintMaker.height.equalTo(attribute);
        return self;
    };
}
- (SPLayout * (^)(id attr,CGFloat multiplier))heightEqualWithMultiplier{
    return ^id(id attribute,CGFloat multiplier) {
        self.constraintMaker.height.equalTo(attribute).multipliedBy(multiplier);
        return self;
    };
}

#pragma mark - size
- (SPLayout * (^)(CGSize size))size{
    return ^id(CGSize size) {
        self.constraintMaker.size.equalTo([NSValue valueWithCGSize:size]);
        return self;
    };
}
- (SPLayout * (^)(id attr))sizeEqual{
    return ^id(id attribute) {
        self.constraintMaker.size.equalTo(attribute);
        return self;
    };
}
- (SPLayout * (^)(id attr,CGFloat multiplier))sizeEqualWithMultiplier{
    return ^id(id attribute,CGFloat multiplier) {
        self.constraintMaker.size.equalTo(attribute).multipliedBy(multiplier);
        return self;
    };
}

#pragma mark - edges
- (SPLayout * (^)(id attr))edges{
    return ^id(id attribute) {
        return [self edgesReal:attribute];
    };
}
- (SPLayout *)edgesReal:(UIView *)view{
    self.constraintMaker.edges.equalTo(view);
    return self;
}


#pragma mark - install
- (SPLayout * (^)(void))install{
    return ^id() {
        [self.constraintMaker install];
        return self;
    };
}

- (SPLayout * (^)(void))debug{
    return ^id() {
        UIColor *randColor = [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0  blue:arc4random_uniform(256)/255.0  alpha:1];
        self.view.backgroundColor = randColor;
        return self;
    };
}
@end
