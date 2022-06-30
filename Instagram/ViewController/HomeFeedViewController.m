//
//  HomeFeedViewController.m
//  Instagram
//
//  Created by Myles Block on 6/28/22.
//

#import "HomeFeedViewController.h"
#import "AppDelegate.h"
#import "SceneDelegate.h"
#import "LoginViewController.h"
#import "ComposeViewController.h"

@interface HomeFeedViewController ()
@property (weak, nonatomic) IBOutlet UITableView *feedTableView;


@end

@implementation HomeFeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)didTapLogout:(id)sender {
    
    SceneDelegate *mySceneDelegate = (SceneDelegate * )UIApplication.sharedApplication.connectedScenes.allObjects.firstObject.delegate;

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    mySceneDelegate.window.rootViewController = loginViewController;//^^all this code moves the storyboard back to the login screen
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error){}];//clears out the user's information & sets it to nil
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    if([[segue identifier] isEqualToString:@"composeSegue"])
    {
        // Get the new view controller using [segue destinationViewController].
        UINavigationController *navigationController = [segue destinationViewController];
        // Pass the selected object to the new view controller[WHAT YOU ARE SEGUING INTO]
        //ALSO WHEN YOU SEGUE ADD YOUR DELEGATIONS TO YOUR INTERFACE ie: <ComposeViewControllerDelegate> -> [WHAT YOU ARE SEGUING INTO]
        //CREATE YOUR DELEGATE INTO YOUR SEGUED VIEW HEADER FILE ie: @property (nonatomic, weak) id<ComposeViewControllerDelegate> delegate;
        ComposeViewController *composeController = (ComposeViewController*)navigationController.topViewController;
        composeController.delegate = self;
        
    }
    // Pass the selected object to the new view controller.
}

*/
@end
