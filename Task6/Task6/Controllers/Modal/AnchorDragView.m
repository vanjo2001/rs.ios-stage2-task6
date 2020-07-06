//
//  AnchorDragView.m
//  Task6
//
//  Created by IvanLyuhtikov on 7/2/20.
//  Copyright © 2020 IvanLyuhtikov. All rights reserved.
//

#import "AnchorDragView.h"

@interface AnchorDragView() {
    CGSize _intrinsicContentSize;
}
@end

@implementation AnchorDragView



- (void)layoutSubviews {
    [super layoutSubviews];
    self.drag.layer.cornerRadius = 5;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [[NSBundle mainBundle] loadNibNamed:@"AnchorDragView" owner:self options:nil];
        
        self.bounds = self.view.bounds;
        _intrinsicContentSize = self.bounds.size;
        
        [self addSubview:self.view];
        
    }
    return self;
}


- (CGSize)intrinsicContentSize {
    return _intrinsicContentSize;
}

@end
