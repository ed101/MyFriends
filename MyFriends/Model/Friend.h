//
//  Friend.h
//  MyFriends
//
//  Created by vladislav on 06.09.15.
//  Copyright (c) 2015 vladislav. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Friend : NSManagedObject

@property (nonatomic, retain) NSString * avatar;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * friendId;
@property (nonatomic, retain) NSNumber * isFriend;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSString * phoneNumber;
@property (nonatomic, retain) NSString * firstName;

@end
