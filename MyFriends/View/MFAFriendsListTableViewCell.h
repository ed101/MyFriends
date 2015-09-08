//
//  MFAFriendsListTableViewCell.h
//  MyFriends
//
//  Created by vladislav on 06.09.15.
//  Copyright (c) 2015 vladislav. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Friend;

static NSString * const kMFAFriendsListTableViewCell = @"MFAFriendsListTableViewCell";
static CGFloat const kMFAFriendsListTableViewCellHeight = 90.0;

@interface MFAFriendsListTableViewCell : UITableViewCell

- (void)configureCellWithFriend:(Friend *)friend;

@end
