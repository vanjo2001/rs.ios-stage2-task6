//
//  AnchorDragView.h
//  Task6
//
//  Created by IvanLyuhtikov on 7/2/20.
//  Copyright © 2020 IvanLyuhtikov. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AnchorDragView : UIView

@property (weak, nonatomic) IBOutlet UIView *drag;
@property (strong, nonatomic) IBOutlet UIView *view;

@end

NS_ASSUME_NONNULL_END
