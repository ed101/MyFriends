//
//  MFAFriendsListTableViewCell.m
//  MyFriends
//
//  Created by vladislav on 06.09.15.
//  Copyright (c) 2015 vladislav. All rights reserved.
//

#import "MFAFriendsListTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "Friend+Extensions.h"

@interface MFAFriendsListTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageAvatar;
@property (weak, nonatomic) IBOutlet UILabel *labelName;

@end

@implementation MFAFriendsListTableViewCell

- (void)prepareForReuse {
    [super prepareForReuse];
    self.labelName.text = @"";
    self.imageAvatar.image = nil;
}

- (void)configureCellWithFriend:(Friend *)friend;
{
    self.imageAvatar.layer.masksToBounds = YES;
    
    NSString *lastName = friend.lastName;
    NSString *firstName = friend.firstName;
    self.labelName.text = [NSString stringWithFormat:@"%@ %@",firstName, lastName];
    NSString *avatar = friend.avatar;
    
    [self.imageAvatar sd_setImageWithURL:[NSURL URLWithString:avatar] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.imageAvatar.layer.cornerRadius = self.imageAvatar.layer.frame.size.width / 2;
    }];
}

@end
