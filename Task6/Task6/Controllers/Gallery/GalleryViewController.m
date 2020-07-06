//
//  GalleryViewController.m
//  Task6
//
//  Created by IvanLyuhtikov on 6/24/20.
//  Copyright © 2020 IvanLyuhtikov. All rights reserved.
//

#import <Photos/Photos.h>

#import "GalleryViewController.h"
#import "ModalControllerViewController.h"

#import "PhotoCell.h"
#import "Constants.h"



#define let __auto_type const
#define var __auto_type

@interface GalleryViewController ()

@property (nonatomic, strong) PHFetchResult *fetchResult;
@property (nonatomic, strong) PHCachingImageManager *imageManager;


@end

@implementation GalleryViewController

static NSString * const reuseIdentifier = @"PhotoCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.collectionView.backgroundColor = UIColor.whiteColor;
    
    UINib *nibCell = [UINib nibWithNibName:reuseIdentifier bundle:[NSBundle mainBundle]];
    
    [self.collectionView registerNib:nibCell forCellWithReuseIdentifier:reuseIdentifier];
    self.navigationItem.title = @"Gallery";
    
    
    
    self.fetchResult = [PHAsset fetchAssetsWithMediaType:PHAssetMediaTypeImage options:0];

    self.imageManager = [[PHCachingImageManager alloc] init];
    
    
    
    [PHPhotoLibrary.sharedPhotoLibrary registerChangeObserver: self];
    
    
}



#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.fetchResult.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PhotoCell *cell = (PhotoCell *)[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    
    PHAsset *asset = [self.fetchResult objectAtIndex:indexPath.row];
    
    
    [self.imageManager requestImageForAsset:asset targetSize:cell.frame.size contentMode: PHImageContentModeAspectFill options:nil resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        cell.imageView.image = result;
    }];
    
    
    
    
    cell.backgroundColor = YELLOW_COLOR;
    
    // Configure the cell
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ModalControllerViewController *vc = [ModalControllerViewController new];
    
    if (@available(iOS 13.0, *)) {
        vc.modalPresentationStyle = UIModalPresentationPageSheet;
    } else {
        vc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    }
    
    
    
    vc.view.backgroundColor = WHITE_COLOR;
    
    [self presentViewController:vc animated:true completion:nil];
}



//MARK: photo library did change
- (void)photoLibraryDidChange:(PHChange *)changeInstance {
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        PHFetchResultChangeDetails *collectionChanges = [changeInstance changeDetailsForFetchResult:self.fetchResult];
        
        
        if (collectionChanges.hasIncrementalChanges) {
            
            [self.collectionView performBatchUpdates:^{
                
                NSIndexSet *inserted = collectionChanges.insertedIndexes;
                
                if (inserted.count) {
                    
                    NSMutableArray *allIndexPaths = [[NSMutableArray alloc] init];

                    [inserted enumerateIndexesUsingBlock:^(NSUInteger index, BOOL * _Nonnull stop) {
                            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];
                            [allIndexPaths addObject:indexPath];
                    }];
                    
                    
                    self.fetchResult = [collectionChanges fetchResultAfterChanges];
                    
                    [self.collectionView insertItemsAtIndexPaths:allIndexPaths];
                    
                }
                
                NSIndexSet *deleted = collectionChanges.removedIndexes;
                
                if (deleted.count) {
                    
                    NSMutableArray *allIndexPaths = [[NSMutableArray alloc] init];

                    [deleted enumerateIndexesUsingBlock:^(NSUInteger index, BOOL * _Nonnull stop) {
                            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];
                            [allIndexPaths addObject:indexPath];
                    }];
                    
                    
                    self.fetchResult = [collectionChanges fetchResultAfterChanges];
                    
                    [self.collectionView deleteItemsAtIndexPaths:allIndexPaths];
                    
                }
                
            } completion: nil];
            
        }
        
        
    });
}


- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    
    [self.collectionView.collectionViewLayout invalidateLayout];
}

//- (void)willTransitionToTraitCollection:(UITraitCollection *)newCollection withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
//    [super willTransitionToTraitCollection:newCollection withTransitionCoordinator:coordinator];
//
//
//}

#pragma mark <UICollectionViewDelegate>

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    return CGSizeMake(UIScreen.mainScreen.bounds.size.width/3 - 6.7, UIScreen.mainScreen.bounds.size.width/3 - 6.7);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 5;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 5;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(5, 5, 5, 5);
}


- (BOOL)prefersStatusBarHidden {
    return true;
}

@end
