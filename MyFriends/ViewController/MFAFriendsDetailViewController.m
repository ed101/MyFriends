//
//  MFAFriendsDetailViewController.m
//  MyFriends
//
//  Created by vladislav on 06.09.15.
//  Copyright (c) 2015 vladislav. All rights reserved.
//

#import "MFAFriendsDetailViewController.h"
#import "MFAFriendsDetailAvatarTableViewCell.h"
#import "MFAFriendsDetailFieldTableViewCell.h"

#import "Friend+Extensions.h"

typedef NS_ENUM(NSUInteger, MFAFriendsDetailSection){
    MFAFriendsDetailSectionTypeAvatar = 0,
    MFAFriendsDetailSectionTypeItems
};

@interface MFAFriendsDetailViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation MFAFriendsDetailViewController

#pragma mark - LifeCycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

#pragma mark - TableView delegates

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    switch (section) {
        case MFAFriendsDetailSectionTypeAvatar:
            return 1;
        case MFAFriendsDetailSectionTypeItems:
            return kMFAFriendsDetailItemTypeCount;
        default:
            return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    switch (indexPath.section) {
        case MFAFriendsDetailSectionTypeAvatar:
        {
            MFAFriendsDetailAvatarTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:kMFAFriendsDetailAvatarTableViewCell forIndexPath:indexPath];
            
            
            
            return cell;
        }
        case MFAFriendsDetailSectionTypeItems:
        {
            MFAFriendsDetailFieldTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:kMFAFriendsDetailFieldTableViewCell forIndexPath:indexPath];
            
            [cell configureCellWithFriend:self.friend indexPath:indexPath];
            
            return cell;
        }
        default:
            return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    switch (indexPath.section) {
        case MFAFriendsDetailSectionTypeAvatar:
            return kMFAFriendsDetailAvatarTableViewCellHeight;
        case MFAFriendsDetailSectionTypeItems:
            return kMFAFriendsDetailFieldTableViewCellHeight;
        default:
            return 0;
    }
}


#pragma - mark

@end
