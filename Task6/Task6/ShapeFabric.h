//
//  ShapeFabric.h
//  Task6
//
//  Created by IvanLyuhtikov on 6/25/20.
//  Copyright © 2020 IvanLyuhtikov. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ShapeFabric : NSObject

+ (UIView *)createTriangle;
+ (UIView *)createRectangle;
+ (UIView *)createCircle;

@end

NS_ASSUME_NONNULL_END
