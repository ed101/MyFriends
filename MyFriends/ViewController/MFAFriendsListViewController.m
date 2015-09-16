//
//  MFAFriendsListViewController.m
//  MyFriends
//
//  Created by vladislav on 06.09.15.
//  Copyright (c) 2015 vladislav. All rights reserved.
//

#import "MFAFriendsListViewController.h"
#import "MFAFriendsListTableViewCell.h"
#import "MFAFriendsDetailViewController.h"

#import <AFNetworking/AFNetworking.h>
#import <MagicalRecord/MagicalRecord.h>

#import "Friend+Extensions.h"
#import "MFAConstants.h"

@interface MFAFriendsListViewController () <UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableFriends;
@property (nonatomic, strong) NSArray *arrayOfFriends;
@property (nonatomic, strong) NSFetchedResultsController *frcFriends;
@property (nonatomic, strong) Friend *friend;

- (IBAction)actionToAddFriends:(id)sender;

@end

@implementation MFAFriendsListViewController

#pragma mark - LifeCycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableFriends.separatorColor = [UIColor clearColor];
    self.navigationItem.title = @"My Friends";
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.requestSerializer setValue:MFAParseApplicationId forHTTPHeaderField:@"X-Parse-Application-Id"];
    [manager.requestSerializer setValue:MFAParseRESTAPIKey forHTTPHeaderField:@"X-Parse-REST-API-Key"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    __weak typeof(self) weakSelf = self;
    [manager GET:@"https://api.parse.com/1/classes/Friend" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        NSDictionary *dict = (NSDictionary *)responseObject;
        weakSelf.arrayOfFriends = dict[@"results"];
        
        [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
            for (NSDictionary *dict in weakSelf.arrayOfFriends){
                NSString *friendId = dict[@"objectId"];
                Friend *friend = [Friend MR_findFirstByAttribute:@"friendId" withValue:friendId inContext:localContext];
                if (!friend){
                    friend = [Friend MR_createEntityInContext:localContext];
                    friend.friendId = friendId;
                }
                friend.avatar      = dict[@"avatar"];
                friend.email       = dict[@"email"];
                friend.firstName   = dict[@"firstName"];
                friend.lastName    = dict[@"lastName"];
                friend.phoneNumber = dict[@"phoneNumber"];
            }
        } completion:^(BOOL contextDidSave, NSError *error) {
            
        }];
        
        [weakSelf.tableFriends reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
    self.frcFriends = [Friend frcFriends];
    self.frcFriends.delegate = self;
    [self.frcFriends performFetch:nil];
}

#pragma mark - TableView delegates

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return self.frcFriends.fetchedObjects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    MFAFriendsListTableViewCell *cell = [self.tableFriends dequeueReusableCellWithIdentifier:kMFAFriendsListTableViewCell forIndexPath:indexPath];
    
    [cell configureCellWithFriend:self.frcFriends.fetchedObjects[indexPath.row]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return kMFAFriendsListTableViewCellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    self.friend = self.frcFriends.fetchedObjects[indexPath.row];
    
    [self performSegueWithIdentifier:toFriendsDetailVC sender:self];
}

#pragma mark - Fetch Result Controller

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableFriends beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath
{
    UITableView *tableView = self.tableFriends;
    
    switch(type)
    {
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
        {
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        }
            
        case NSFetchedResultsChangeUpdate:
            [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableFriends endUpdates];
}

#pragma mark - IBAction

- (IBAction)actionToAddFriends:(id)sender {
    [self performSegueWithIdentifier:toFriendsAddVC sender:self];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:toFriendsDetailVC]){
        MFAFriendsDetailViewController *vc = (MFAFriendsDetailViewController *)segue.destinationViewController;
        vc.friend = self.friend;
    }
}

#pragma mark -

@end
