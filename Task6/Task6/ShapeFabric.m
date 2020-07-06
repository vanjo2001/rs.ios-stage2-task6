//
//  ShapeFabric.m
//  Task6
//
//  Created by IvanLyuhtikov on 6/25/20.
//  Copyright © 2020 IvanLyuhtikov. All rights reserved.
//

#import "ShapeFabric.h"
#import "Constants.h"

@implementation ShapeFabric

+ (UIView *)createCircle {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 70, 70)];
    view.backgroundColor = RED_COLOR;

    CAShapeLayer *shape = [CAShapeLayer layer];
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:view.center radius:(view.bounds.size.width / 2) startAngle:0 endAngle:(2 * M_PI) clockwise:YES];
    shape.path = path.CGPath;
    view.layer.mask = shape;
    
    return view;
}

+ (UIView *)createRectangle {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 70, 70)];
    
    view.backgroundColor = BLUE_COLOR;
    
    return view;
}

+ (UIView *)createTriangle {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 70, 70)];
    
    view.backgroundColor = GREEN_COLOR;
    CAShapeLayer *shape = [CAShapeLayer layer];
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(view.bounds.origin.x, view.bounds.size.height)];
    [path addLineToPoint:CGPointMake(view.bounds.size.width/2, 0)];
    [path addLineToPoint:CGPointMake(view.bounds.size.width, view.bounds.size.height)];
    [path closePath];
    
    shape.path = path.CGPath;
    view.layer.mask = shape;
    
    return view;
}

@end
