//
//  MFAFriendsDetailFieldTableViewCell.h
//  MyFriends
//
//  Created by VLADISLAV KIRIN on 9/15/15.
//  Copyright (c) 2015 vladislav. All rights reserved.
//

#import <UIKit/UIKit.h>


@class Friend;

typedef NS_ENUM(NSUInteger, MFAFriendsDetailItemType) {
    MFAFriendsDetailItemTypeFirstname = 0,
    MFAFriendsDetailItemTypeLastname,
    MFAFriendsDetailItemTypeEmail,
    MFAFriendsDetailItemTypePhonenumber
};
static NSUInteger const kMFAFriendsDetailItemTypeCount = 4;

static NSString * const kMFAFriendsDetailFieldTableViewCell = @"MFAFriendsDetailFieldTableViewCell";
static CGFloat const kMFAFriendsDetailFieldTableViewCellHeight = 45.0f;

@interface MFAFriendsDetailFieldTableViewCell : UITableViewCell

- (void)configureCellWithFriend:(Friend *)friend indexPath:(NSIndexPath *)indexPath;

@end
