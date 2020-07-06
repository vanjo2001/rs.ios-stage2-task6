//
//  InfoViewController.m
//  Task6
//
//  Created by IvanLyuhtikov on 6/24/20.
//  Copyright © 2020 IvanLyuhtikov. All rights reserved.
//

#import "InfoViewController.h"
#import "MediaCell.h"


#import "Constants.h"

@interface InfoViewController ()

@property (nonatomic, strong) PHFetchResult<PHAsset *> *fetchResult;
@property (nonatomic, strong) PHCachingImageManager *mediaManager;

@end

@implementation InfoViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UINib *nibCell = [UINib nibWithNibName:@"MediaCell" bundle:[NSBundle mainBundle]];
    [self.tableView registerNib:nibCell forCellReuseIdentifier:@"MediaCell"];
    
    self.navigationItem.title = @"Info";
    
    
    PHFetchOptions *fetchOptions = [[PHFetchOptions alloc] init];
    fetchOptions.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES]];
    self.fetchResult = [PHAsset fetchAssetsWithOptions:fetchOptions];
    
    self.mediaManager = [[PHCachingImageManager alloc] init];
    
    
    [[PHPhotoLibrary sharedPhotoLibrary] registerChangeObserver:self];
    
}

- (void)photoLibraryDidChange:(PHChange *)changeInstance {
    
    
    dispatch_async(dispatch_get_main_queue(), ^{

        PHFetchResultChangeDetails *collectionChanges = [changeInstance changeDetailsForFetchResult:self.fetchResult];


        if (collectionChanges.hasIncrementalChanges) {

            NSIndexSet *inserted = collectionChanges.insertedIndexes;

            if (inserted.count) {

                NSMutableArray *allIndexPaths = [[NSMutableArray alloc] init];

                [inserted enumerateIndexesUsingBlock:^(NSUInteger index, BOOL * _Nonnull stop) {
                        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];
                        [allIndexPaths addObject:indexPath];
                }];


                self.fetchResult = [collectionChanges fetchResultAfterChanges];

                [self.tableView insertRowsAtIndexPaths:allIndexPaths withRowAnimation:UITableViewRowAnimationFade];

            }

            NSIndexSet *deleted = collectionChanges.removedIndexes;

            if (deleted.count) {

                NSMutableArray *allIndexPaths = [[NSMutableArray alloc] init];

                [deleted enumerateIndexesUsingBlock:^(NSUInteger index, BOOL * _Nonnull stop) {
                        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];
                        [allIndexPaths addObject:indexPath];
                }];


                self.fetchResult = [collectionChanges fetchResultAfterChanges];

                [self.tableView deleteRowsAtIndexPaths: allIndexPaths withRowAnimation:UITableViewRowAnimationFade];

            }

        }


    });
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.fetchResult.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MediaCell *cell = (MediaCell *)[tableView dequeueReusableCellWithIdentifier:@"MediaCell" forIndexPath:indexPath];
    
    PHAsset *asset = [self.fetchResult objectAtIndex:indexPath.row];
    
    cell.resolution.text = [NSString stringWithFormat:@"%lux%lu", (unsigned long)asset.pixelWidth, (unsigned long)asset.pixelHeight];
    cell.title.text = [asset valueForKey:@"filename"];
    
    NSString *time = [self customTimeFormatter:asset.duration];
    
    switch (asset.mediaType) {
        case PHAssetMediaTypeImage:
            cell.infoImage.image = [UIImage imageNamed:@"photo-camera"];
            break;
        case PHAssetMediaTypeVideo:
            
            cell.infoImage.image = [UIImage imageNamed:@"video-camera"];
            
            cell.resolution.text = [NSString stringWithFormat:@"%lux%lu %@", (unsigned long)asset.pixelWidth, (unsigned long)asset.pixelHeight, time];
            
            break;
        case PHAssetMediaTypeAudio:
            cell.infoImage.image = [UIImage imageNamed:@""];
            break;
        default:
            cell.infoImage.image = [UIImage imageNamed:@""];
            break;
    }
    
    [self.mediaManager requestImageForAsset:asset targetSize:cell.frame.size contentMode: PHImageContentModeAspectFill options:nil resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        cell.image.image = result;
    }];
    
    
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    [self presentViewController:<#(nonnull UIViewController *)#> animated:<#(BOOL)#> completion:<#^(void)completion#>]
    
}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return SCREEN_HEIGHT/7;
}


- (BOOL)prefersStatusBarHidden {
    return true;
}

- (NSString *)customTimeFormatter:(NSTimeInterval)time {
    
    NSInteger timeInterval = (NSInteger)time;
    
    NSInteger seconds = timeInterval % 60;
    NSString *strSeconds = [NSString stringWithFormat:@"%ld", seconds];
    NSString *resultSeconds = (strSeconds.length < 2) ? [NSString stringWithFormat:@"0%@", strSeconds] : [NSString stringWithFormat:@"%@", strSeconds];
    
    NSInteger minutes = ((timeInterval - seconds) / 60) % 60;
    NSString *strMinutes = [NSString stringWithFormat:@"%ld", minutes];
    NSString *resultMinutes = (strSeconds.length < 2) ? [NSString stringWithFormat:@"0%@", strMinutes] : [NSString stringWithFormat:@"%@", strMinutes];
    
    NSInteger hours = (timeInterval - minutes) / 3600;
    
    if (hours == 0) {
        if (minutes == 0) {
            return [NSString stringWithFormat:@"0:%@", resultSeconds];
        } else {
            return [NSString stringWithFormat:@"%@:%@", resultMinutes, resultSeconds];
        }
    }
    
    return [NSString stringWithFormat:@"%ld:%@:%@", hours, resultMinutes, resultSeconds];
}


@end
