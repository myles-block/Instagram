//
//  ComposeViewController.m
//  Instagram
//
//  Created by Myles Block on 6/28/22.
//

#import "ComposeViewController.h"
#import "HomeFeedViewController.h"
#import "SceneDelegate.h"

@interface ComposeViewController ()

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (IBAction)didTapCancel:(id)sender {//sends back to HomeFeed
    
    SceneDelegate *mySceneDelegate = (SceneDelegate * )UIApplication.sharedApplication.connectedScenes.allObjects.firstObject.delegate;

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    HomeFeedViewController *HomeFeedViewController = [storyboard instantiateViewControllerWithIdentifier:@"HomeFeedViewController"];
    mySceneDelegate.window.rootViewController = HomeFeedViewController;//^^all this code moves the storyboard back to the login screen
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
