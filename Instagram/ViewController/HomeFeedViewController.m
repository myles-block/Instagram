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
#import "DetailsViewController.h"
#import "ComposeViewController.h"
#import "FeedCell.h"
#import "Parse/Parse.h"

@interface HomeFeedViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *feedTableView;
@property (strong, nonatomic) NSArray *postArray;
@property (nonatomic, strong) UIRefreshControl *refreshControl;


@end

@implementation HomeFeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.feedTableView.dataSource = self;//this connects the file to datasource methods
    self.feedTableView.delegate = self;//this helps connect file
    
    
    self.refreshControl = [[UIRefreshControl alloc] init];//connects refreshcontrol to self
    [self.refreshControl addTarget:self action: @selector(refreshView) forControlEvents:UIControlEventValueChanged];//when beginning of refresh control is triggered it reruns refreshView
    self.feedTableView.refreshControl = self.refreshControl;//end of refreshControl
    
//    [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(refreshView) userInfo:nil repeats:true];//every 1 second it calls the refresh function
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [self refreshView];

}

- (IBAction)didTapLogout:(id)sender {
    
    SceneDelegate *mySceneDelegate = (SceneDelegate * )UIApplication.sharedApplication.connectedScenes.allObjects.firstObject.delegate;

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    mySceneDelegate.window.rootViewController = loginViewController;//^^all this code moves the storyboard back to the login screen
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error){}];//clears out the user's information & sets it to nil
}

- (void)refreshView {
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    [query orderByDescending:@"createdAt"];
//    [query whereKey:@"likesCount" greaterThan:@100];
    query.limit = 200;

    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        if (posts != nil) {
            // do something with the array of object returned by the call
            self.postArray = posts;
            [self.feedTableView reloadData];
            [self.refreshControl endRefreshing];
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    if([[segue identifier] isEqualToString:@"detailSegue"])
    {
        // Get the new view controller using [segue destinationViewController].
//        UINavigationController *navigationController = [segue destinationViewController];
        NSIndexPath *senderIndex = [self.feedTableView indexPathForCell: sender];
        Post *post = self.postArray[senderIndex.row];
        UINavigationController *navVC = [segue destinationViewController];
        DetailsViewController *detailViewController = (DetailsViewController*)navVC.topViewController;
        detailViewController.post = post;
        // Pass the selected object to the new view controller[WHAT YOU ARE SEGUING INTO]
        //ALSO WHEN YOU SEGUE ADD YOUR DELEGATIONS TO YOUR INTERFACE ie: <ComposeViewControllerDelegate> -> [WHAT YOU ARE SEGUING INTO]
        //CREATE YOUR DELEGATE INTO YOUR SEGUED VIEW HEADER FILE ie: @property (nonatomic, weak) id<ComposeViewControllerDelegate> delegate;
//        ComposeViewController *composeController = (ComposeViewController*)navigationController.topViewController;
//        composeController.delegate = self;
        
    }
    // Pass the selected object to the new view controller.
}



//MARK: Delegate Protocols
//TODO: Fix continous loading activity controller & repopulation of photos
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    FeedCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FeedCell"];
    PFObject *pulledObject = self.postArray[indexPath.row];
    cell.connectedFeedCaption.text = pulledObject[@"caption"];
    cell.connectedFeedImage.file = pulledObject[@"image"];
        [cell.connectedFeedImage loadInBackground];
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.postArray.count;
}


@end
