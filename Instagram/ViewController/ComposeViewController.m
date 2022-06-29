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
    [self dismissViewControllerAnimated:true completion:nil];//only works when connecting view from button, if configured manually use scene delegation code
    
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
