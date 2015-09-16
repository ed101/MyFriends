//
//  MFAFriendsDetailFieldTableViewCell.m
//  MyFriends
//
//  Created by VLADISLAV KIRIN on 9/15/15.
//  Copyright (c) 2015 vladislav. All rights reserved.
//

#import "MFAFriendsDetailFieldTableViewCell.h"
#import "Friend+Extensions.h"

@interface MFAFriendsDetailFieldTableViewCell ()

@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation MFAFriendsDetailFieldTableViewCell

- (void)prepareForReuse {
    [super prepareForReuse];
    self.textField.text = @"";
}

- (void)configureCellWithFriend:(Friend *)friend indexPath:(NSIndexPath *)indexPath;
{
    switch (indexPath.row) {
        case MFAFriendsDetailItemTypeFirstname:
            self.textField.text = friend.firstName;
            break;
        case MFAFriendsDetailItemTypeLastname:
            self.textField.text = friend.lastName;
            break;
        case MFAFriendsDetailItemTypeEmail:
            self.textField.text = friend.email;
            break;
        case MFAFriendsDetailItemTypePhonenumber:
            self.textField.text = friend.phoneNumber;
            break;
        default:
            NSLog(@"Wrong index path");
            break;
    }
}
@end
