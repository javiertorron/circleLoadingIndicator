//
//  CircleLoaderView.m
//
//  Created by Javier Torrón Díaz on 30/8/18.
//  Copyright © 2018. All rights reserved.
//

#import "CircleLoaderView.h"

@implementation CircleLoaderView

// Importante sintetizar progress para que coja el getter y el setter
@synthesize progress = _progress;

#pragma mark - Inicializadores
-(instancetype)initWithLayer:(CGRect) layer withColor:(UIColor*) circleColor  withRadius:(CGFloat)radius {
    self = [super initWithFrame:layer];
    if (self) {
        self.circleColor = circleColor;
        self.circleRadius = radius;
        [self circleConstants];
        [self configure];
    }
    return self;
}

-(instancetype)initWithDecoder:(NSCoder*)aDecoder withColor:(UIColor*) circleColor  withRadius:(CGFloat)radius {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.circleColor = circleColor;
        self.circleRadius = radius;
        [self circleConstants];
        [self configure];
    }
    return self;
}

#pragma mark - Configuración de vistas y círculos
-(void) circleConstants {
    self.radiusMultiplier = 2.0;
    self.lineWidth = 3.0;
}

/**
 *  Configuración del objeto (tamaños, colores, etc)
 */
-(void) configure {
    CAShapeLayer *configureCircle = [CAShapeLayer layer];
    configureCircle.fillColor = [UIColor clearColor].CGColor;
    configureCircle.strokeColor = self.circleColor.CGColor;
    configureCircle.lineWidth = self.lineWidth;
    _circlePathLayer = configureCircle;
    self.progress = 0;
    [self.layer addSublayer:_circlePathLayer];
    self.backgroundColor = [UIColor clearColor];
}

/**
 *  Genera el rectángulo de la vista según los parámetros de la clase
 */
-(CGRect) circleFrame {
    NSLog(@"%f", self.layer.frame.size.width);
    CGRect circleFrame = CGRectMake(0, 0, self.layer.frame.size.width, self.layer.frame.size.width);
    CGRect circlePathBounds = _circlePathLayer.bounds;
    circleFrame.origin.x = circlePathBounds.origin.x - circleFrame.origin.x;
    circleFrame.origin.y = circlePathBounds.origin.y - circleFrame.origin.y;
    return circleFrame;
}

/**
 *  Configura el circulo con una curva Bezier dentro del frame del método circleFrame
 */
-(UIBezierPath*) circlePath {
    return [UIBezierPath bezierPathWithOvalInRect:[self circleFrame]];
}


-(void) layoutSubviews {
    [super layoutSubviews];
    _circlePathLayer.frame = self.bounds;
    // Llamamos a circlePath porque un cambio en el frame debería también conllevar recalcular el Path
    _circlePathLayer.path = [self circlePath].CGPath;
}

#pragma mark - Getter y Setter para la variable de progreso
-(CGFloat) progress {
    return _circlePathLayer.strokeEnd;
}

-(void) setProgress:(CGFloat)n{
    if (n > 1) {
        _circlePathLayer.strokeEnd = 1;
    } else if (n < 0) {
        _circlePathLayer.strokeEnd = 0;
    } else {
        _circlePathLayer.strokeEnd = n;
    }
}

-(CGPoint) getCenterPoint {
    return CGPointMake(self.frame.origin.x + self.frame.size.width / 2, self.frame.origin.y + self.frame.size.height);
}
@end
