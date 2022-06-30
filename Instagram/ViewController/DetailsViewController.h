//
//  DetailsViewController.h
//  Instagram
//
//  Created by Myles Block on 6/30/22.
//

#import <UIKit/UIKit.h>
#import "HomeFeedViewController.h"
#import "Parse/Parse.h"
#import "Post.h"
#import "Parse/PFImageView.h"


NS_ASSUME_NONNULL_BEGIN

@interface DetailsViewController : UIViewController
@property (weak, nonatomic) IBOutlet PFImageView *detailImage;
@property (weak, nonatomic) IBOutlet UILabel *createdAtLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailsCaptionLabel;

@property(strong, nonatomic) Post *post;

@end

NS_ASSUME_NONNULL_END
