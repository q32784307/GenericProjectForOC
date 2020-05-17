//
//  RadiusImageView.m
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2017/10/24.
//  Copyright © 2017年 漠然丶情到深处. All rights reserved.
//

#import "RadiusImageView.h"

@implementation RadiusImageView

+ (UIImageView *)bgImageViewWith:(RadiusType)type bgImageViewWithFrame:(CGRect)frame Radius:(CGFloat)radius {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
    
    switch (type) {
        case Normal:{
            
        }
            break;
        case Singel:{
            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:imageView.bounds cornerRadius:radius];
            CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
            maskLayer.frame = imageView.bounds;
            maskLayer.path = maskPath.CGPath;
            imageView.layer.mask = maskLayer;
        }
            break;
        case TopFillet:{
            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:imageView.bounds byRoundingCorners:UIRectCornerTopRight | UIRectCornerTopLeft cornerRadii:CGSizeMake(radius, radius)];
            CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
            maskLayer.frame = imageView.bounds;
            maskLayer.path = maskPath.CGPath;
            imageView.layer.mask = maskLayer;
        }
            break;
        case BottomFillet:{
            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:imageView.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(radius, radius)];
            CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
            maskLayer.frame = imageView.bounds;
            maskLayer.path = maskPath.CGPath;
            imageView.layer.mask = maskLayer;
        }
            break;
        case LeftFillet:{
            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:imageView.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerTopLeft cornerRadii:CGSizeMake(radius, radius)];
            CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
            maskLayer.frame = imageView.bounds;
            maskLayer.path = maskPath.CGPath;
            imageView.layer.mask = maskLayer;
        }
            break;
        case RightFillet:{
            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:imageView.bounds byRoundingCorners:UIRectCornerBottomRight | UIRectCornerTopRight cornerRadii:CGSizeMake(radius, radius)];
            CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
            maskLayer.frame = imageView.bounds;
            maskLayer.path = maskPath.CGPath;
            imageView.layer.mask = maskLayer;
        }
            break;
        case TopLeftFillet:{
            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:imageView.bounds byRoundingCorners:UIRectCornerTopLeft cornerRadii:CGSizeMake(radius, radius)];
            CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
            maskLayer.frame = imageView.bounds;
            maskLayer.path = maskPath.CGPath;
            imageView.layer.mask = maskLayer;
        }
            break;
        case TopRightFillet:{
            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:imageView.bounds byRoundingCorners:UIRectCornerTopRight cornerRadii:CGSizeMake(radius, radius)];
            CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
            maskLayer.frame = imageView.bounds;
            maskLayer.path = maskPath.CGPath;
            imageView.layer.mask = maskLayer;
        }
            break;
        case BottomLeftFillet:{
            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:imageView.bounds byRoundingCorners:UIRectCornerBottomLeft cornerRadii:CGSizeMake(radius, radius)];
            CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
            maskLayer.frame = imageView.bounds;
            maskLayer.path = maskPath.CGPath;
            imageView.layer.mask = maskLayer;
        }
            break;
        case BottomRightFillet:{
            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:imageView.bounds byRoundingCorners:UIRectCornerBottomRight cornerRadii:CGSizeMake(radius, radius)];
            CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
            maskLayer.frame = imageView.bounds;
            maskLayer.path = maskPath.CGPath;
            imageView.layer.mask = maskLayer;
        }
            break;
        case TopLeftAndBottomRightFillet:{
            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:imageView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(radius, radius)];
            CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
            maskLayer.frame = imageView.bounds;
            maskLayer.path = maskPath.CGPath;
            imageView.layer.mask = maskLayer;
        }
            break;
        case BottomLeftAndTopRightFillet:{
            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:imageView.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(radius, radius)];
            CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
            maskLayer.frame = imageView.bounds;
            maskLayer.path = maskPath.CGPath;
            imageView.layer.mask = maskLayer;
        }
            break;
        case TopLeftAndBottomLeftAndTopRightFillet:{
            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:imageView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerBottomLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(radius, radius)];
            CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
            maskLayer.frame = imageView.bounds;
            maskLayer.path = maskPath.CGPath;
            imageView.layer.mask = maskLayer;
        }
            break;
        case TopLeftAndBottomLeftAndBottomRightFillet:{
            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:imageView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(radius, radius)];
            CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
            maskLayer.frame = imageView.bounds;
            maskLayer.path = maskPath.CGPath;
            imageView.layer.mask = maskLayer;
        }
            break;
        case BottomLeftAndBottomRightAndTopRightFillet:{
            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:imageView.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight | UIRectCornerTopRight cornerRadii:CGSizeMake(radius, radius)];
            CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
            maskLayer.frame = imageView.bounds;
            maskLayer.path = maskPath.CGPath;
            imageView.layer.mask = maskLayer;
        }
            break;
        case BottomRightAndTopRightAndTopLeftFillet:{
            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:imageView.bounds byRoundingCorners:UIRectCornerBottomRight | UIRectCornerTopRight | UIRectCornerTopLeft cornerRadii:CGSizeMake(radius, radius)];
            CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
            maskLayer.frame = imageView.bounds;
            maskLayer.path = maskPath.CGPath;
            imageView.layer.mask = maskLayer;
        }
            break;
        default:
            break;
    }
    
    return imageView;
}

@end
