//
//  ComposeViewController.m
//  Instagram
//
//  Created by Myles Block on 6/28/22.
//

#import "ComposeViewController.h"
#import "HomeFeedViewController.h"
#import "SceneDelegate.h"
#import "Post.h"

@interface ComposeViewController ()

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}


- (IBAction)didTapCancel:(id)sender {//sends back to HomeFeed
    [self dismissViewControllerAnimated:true completion:nil];//only works when connecting view from button, if configured manually use scene delegation code
    
    
//MARK: Camera Functions
}
- (IBAction)didTapSetPhoto:(id)sender {//tap gesture that triggers camera roll
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];//creates new UIImagePickerController
    imagePickerVC.delegate = self;//delegates
    imagePickerVC.allowsEditing = YES;//allows editing

    // The Xcode simulator does not support taking pictures, so let's first check that the camera is indeed supported on the device before trying to present it.
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {//checks if camera is supported
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else {
        NSLog(@"Camera 🚫 available so we will use photo library instead");
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;//sets sourceType for controller to photo library
    }

    [self presentViewController:imagePickerVC animated:YES completion:nil];//presents image picker
    // Do any additional setup after loading the view.
}


- (IBAction)didTapAccessCameraRoll:(id)sender {
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];//creates new UIImagePickerController
    imagePickerVC.delegate = self;//delegates
    imagePickerVC.allowsEditing = YES;//allows editing
    imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:imagePickerVC animated:YES completion:nil];
    
}

- (IBAction)didTapPostContent:(id)sender {
    [Post postUserImage:self.selectedPhotoImageView.image withCaption:self.createCaptionTextField.text withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
        NSLog(@"success");
        [self dismissViewControllerAnimated:true completion:nil];
    }];//creates a Post with specific user image and caption
        
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {

    // Get the image captured by the UIImagePickerController
    UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
//    UIImage *editedImage = info[UIImagePickerControllerEditedImage];

    // Do something with the images (based on your use case)
    originalImage = [self resizeImage:originalImage withSize:CGSizeMake(580, 580)];
    
    
    [self.selectedPhotoImageView setImage:originalImage];
//    self.imgForPost = originalImage;
    
    // Dismiss UIImagePickerController to go back to your original view controller
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UIImage *)resizeImage:(UIImage *)image withSize:(CGSize)size {
    UIImageView *resizeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    
    resizeImageView.contentMode = UIViewContentModeScaleAspectFill;
    resizeImageView.image = image;
    
    UIGraphicsBeginImageContext(size);
    [resizeImageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}


@end
