//
//  ComposeViewController.h
//  Instagram
//
//  Created by Myles Block on 6/28/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ComposeViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *selectedPhotoImageView;

@end

NS_ASSUME_NONNULL_END
