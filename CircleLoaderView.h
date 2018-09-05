//
//  CircleLoaderView.h
//
//  Created by Javier Torrón Díaz on 30/8/18.
//  Copyright © 2018. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CircleLoaderView : UIView
// Objeto del círculo
@property (nonatomic) CAShapeLayer* circlePathLayer;
// Propiedades del círculo
@property (nonatomic) CGFloat circleRadius;
@property (nonatomic) CGFloat radiusMultiplier;
@property (nonatomic) CGFloat lineWidth;
@property (nonatomic) UIColor *circleColor;
@property (nonatomic) CGFloat progress;

// Métodos
-(instancetype)initWithLayer:(CGRect) layer withColor:(UIColor*) circleColor withRadius:(CGFloat)radius;
-(instancetype)initWithDecoder:(NSCoder*) aDecoder withColor:(UIColor*) circleColor withRadius:(CGFloat)radius;
-(void)configure;
-(CGRect) circleFrame;
-(UIBezierPath*) circlePath;
-(CGPoint) getCenterPoint;
@end

NS_ASSUME_NONNULL_END
