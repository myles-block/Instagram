//
//  FeedCell.h
//  Instagram
//
//  Created by Myles Block on 6/29/22.
//

#import <UIKit/UIKit.h>
#import "Post.h"
#import "Parse/Parse.h"
#import "Parse/PFImageView.h"

NS_ASSUME_NONNULL_BEGIN

@interface FeedCell : UITableViewCell
@property (weak, nonatomic) IBOutlet PFImageView *connectedFeedImage;
@property (weak, nonatomic) IBOutlet UILabel *connectedFeedCaption;

@end

NS_ASSUME_NONNULL_END
