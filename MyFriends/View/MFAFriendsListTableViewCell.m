//
//  MFAFriendsListTableViewCell.m
//  MyFriends
//
//  Created by vladislav on 06.09.15.
//  Copyright (c) 2015 vladislav. All rights reserved.
//

#import "MFAFriendsListTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface MFAFriendsListTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageAvatar;
@property (weak, nonatomic) IBOutlet UILabel *labelName;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintAvatarImageSideOffset;

@end

@implementation MFAFriendsListTableViewCell

- (void)prepareForReuse {
    [super prepareForReuse];
    self.labelName.text = @"";
    self.imageAvatar.image = nil;
}

- (void)configureCellWithDictionary:(NSDictionary *)dictionary;
{
    [self layoutSubviews];
    self.imageAvatar.layer.cornerRadius = (kMFAFriendsListTableViewCellHeight - self.constraintAvatarImageSideOffset.constant *2) / 2;
    self.imageAvatar.layer.masksToBounds = YES;
    
    NSString *lastName = dictionary[@"lastName"];
    NSString *firstName = dictionary[@"firstName"];
    self.labelName.text = [NSString stringWithFormat:@"%@ %@",firstName, lastName];
    NSString *avatar = dictionary[@"avatar"];
    
    [self.imageAvatar sd_setImageWithURL:[NSURL URLWithString:avatar]];
}

@end
