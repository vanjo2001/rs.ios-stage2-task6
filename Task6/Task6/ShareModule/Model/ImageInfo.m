//
//  ImageInfo.m
//  Task6
//
//  Created by IvanLyuhtikov on 7/7/20.
//  Copyright © 2020 IvanLyuhtikov. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, MediaType) {
    MediaTypePhoto,
    MediaTypeVideo,
    MediaTypeAudio
};


@interface ImageInfo : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) NSString *creationDate;
@property (nonatomic, strong) NSString *modifictaionDate;
@property (nonatomic, assign) MediaType mediaType;

@end
