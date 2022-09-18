//
//  UIButton+EnlargeClickZone.m
//  UIButtonEnlargeFrame
//
//  Created by 王宇辰 on 2022/9/18.
//

#import "UIButton+EnlargeClickZone.h"
#import <objc/runtime.h>

static CGFloat topNameKey;
static CGFloat rightNameKey;
static CGFloat bottomNameKey;
static CGFloat leftNameKey;


@implementation UIButton (EnlargeClickZone)

- (void) setEnlargeEdgeWithTop:(CGFloat) top right:(CGFloat) right bottom:(CGFloat) bottom left:(CGFloat) left
{
    objc_setAssociatedObject(self, &topNameKey, [NSNumber numberWithFloat:top], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &rightNameKey, [NSNumber numberWithFloat:right], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &bottomNameKey, [NSNumber numberWithFloat:bottom], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &leftNameKey, [NSNumber numberWithFloat:left], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

/**
 返回增加范围后的结果

 @return return value description
 */
- (CGRect) enlargedRect
{
    NSNumber* topEdge = objc_getAssociatedObject(self, &topNameKey);
    NSNumber* rightEdge = objc_getAssociatedObject(self, &rightNameKey);
    NSNumber* bottomEdge = objc_getAssociatedObject(self, &bottomNameKey);
    NSNumber* leftEdge = objc_getAssociatedObject(self, &leftNameKey);
    if (topEdge && rightEdge && bottomEdge && leftEdge)
    {
        return CGRectMake(self.bounds.origin.x - leftEdge.floatValue,
                          self.bounds.origin.y - topEdge.floatValue,
                          self.bounds.size.width + leftEdge.floatValue + rightEdge.floatValue,
                          self.bounds.size.height + topEdge.floatValue + bottomEdge.floatValue);
    }
    else
    {
        return self.bounds;
    }
}

- (UIView*) hitTest:(CGPoint) point withEvent:(UIEvent*) event
{
    CGRect rect = [self enlargedRect];//获得了获得新范围的CGRect
    
    if (CGRectEqualToRect(rect, self.bounds))  //如果没有增加点击范围就调用super 看看点击范围是不是在父控件上
    {
        return [super hitTest:point withEvent:event];
    }
    //如果触摸点为在增加后的范围内就返回此view为触摸点
    return CGRectContainsPoint(rect, point) ? self : nil;
}

@end
