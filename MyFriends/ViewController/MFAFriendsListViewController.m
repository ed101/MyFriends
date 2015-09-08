//
//  MFAFriendsListViewController.m
//  MyFriends
//
//  Created by vladislav on 06.09.15.
//  Copyright (c) 2015 vladislav. All rights reserved.
//

#import "MFAFriendsListViewController.h"
#import "MFAConstants.h"
#import <AFNetworking/AFNetworking.h>
#import "MFAFriendsListTableViewCell.h"

@interface MFAFriendsListViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableFriends;
@property (nonatomic, strong) NSArray *arrayOfFriends;

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
        [weakSelf.tableFriends reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

#pragma mark - TableView delegates

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return self.arrayOfFriends.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    MFAFriendsListTableViewCell *cell = [self.tableFriends dequeueReusableCellWithIdentifier:kMFAFriendsListTableViewCell forIndexPath:indexPath];
    
    [cell configureCellWithDictionary:self.arrayOfFriends[indexPath.row]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return kMFAFriendsListTableViewCellHeight;
}

#pragma mark - IBAction

- (IBAction)actionToAddFriends:(id)sender {
    [self performSegueWithIdentifier:toFriendsAddVC sender:self];
}
@end
