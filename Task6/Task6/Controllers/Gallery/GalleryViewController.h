//
//  GalleryViewController.h
//  Task6
//
//  Created by IvanLyuhtikov on 6/24/20.
//  Copyright © 2020 IvanLyuhtikov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

NS_ASSUME_NONNULL_BEGIN

@interface GalleryViewController : UICollectionViewController<UICollectionViewDelegateFlowLayout, PHPhotoLibraryChangeObserver>


@end

NS_ASSUME_NONNULL_END
