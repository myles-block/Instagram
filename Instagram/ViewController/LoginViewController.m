//
//  ViewController.m
//  Instagram
//
//  Created by Myles Block on 6/27/22.
//

#import "LoginViewController.h"
#import <Parse/Parse.h>

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)registerUser:(id)sender {//checks if fields are inserted and triggers alert if needed
    if([self.usernameField.text isEqual:@""] || [self.passwordField.text isEqual:@""])
    {
        [self triggerAlert];
    }
    else {
        
    PFUser *newUser = [PFUser user];//creates new Parse User
        
        // set user properties
        newUser.username = self.usernameField.text;//sets insterted username to username property of new Parse User
        newUser.password = self.passwordField.text;//sets insterted password to passworrd property of new Parse User
        
        // call sign up function on the object
        [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {//pushes to the background block
            if (error != nil) {
                NSLog(@"Error: %@", error.localizedDescription);
            } else {
                NSLog(@"User registered successfully");
                [self performSegueWithIdentifier:@"loginSegue" sender:nil];
                // manually segue to logged in view
            }
        }];
    }//end of else
}

- (IBAction)loginUser:(id)sender {
    if([self.usernameField.text isEqual:@""] || [self.passwordField.text isEqual:@""])//checks if fields are inserted and triggers alert if needed
    {
        [self triggerAlert];
    }
    else {
        
    NSString *username = self.usernameField.text;//logs inserterted username as a string property
        NSString *password = self.passwordField.text;//logs inserted password as a string property
        
        [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * user, NSError *  error) {//reaches from background and pulls account using logged username & password
            if (error != nil) {
                NSLog(@"User log in failed: %@", error.localizedDescription);
                [self incorrectPasswordAlert];
            } else {
                NSLog(@"User logged in successfully");
                [self performSegueWithIdentifier:@"loginSegue" sender:nil];
                // display view controller that needs to shown after successful login
            }
        }];
    }
}


- (void)triggerAlert {//function for alert controller
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Missing Fields"
                                                                               message:@"Make sure the correct fields are non empty"
                                                                        preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Ok"
                                                        style:UIAlertActionStyleCancel
                                                      handler:^(UIAlertAction * _Nonnull action) {
                                                             // handle cancel response here. Doing nothing will dismiss the view.
                                                      }];
    
    [alert addAction:cancelAction];//puts all of it together
    [self presentViewController:alert animated:YES completion:^{
        // optional code for what happens after the alert controller has finished presenting
    }];
    
}

- (void)incorrectPasswordAlert {//function for incorrect password alert controller
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Incorrect Fields"
                                                                               message:@"The username & password entered is incorrect and/or not registered"
                                                                        preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Ok"
                                                        style:UIAlertActionStyleCancel
                                                      handler:^(UIAlertAction * _Nonnull action) {
                                                             // handle cancel response here. Doing nothing will dismiss the view.
                                                      }];
    
    [alert addAction:cancelAction];//puts all of it together
    [self presentViewController:alert animated:YES completion:^{
        // optional code for what happens after the alert controller has finished presenting
    }];
    
}

@end
