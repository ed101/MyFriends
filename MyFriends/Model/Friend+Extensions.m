//
//  Friend+Extensions.m
//  MyFriends
//
//  Created by VLADISLAV KIRIN on 9/8/15.
//  Copyright (c) 2015 vladislav. All rights reserved.
//

#import "Friend+Extensions.h"
#import <MagicalRecord/MagicalRecord.h>

@implementation Friend (Extensions)

#pragma mark - public

+ (NSFetchedResultsController *)frcFriends;
{
    return [self frcFriendsWithPredicate:[self predicateFriends]];
}

#pragma mark - private

+ (NSPredicate *)predicateFriends;
{
    return nil;
}

+ (NSFetchedResultsController *)frcFriendsWithPredicate:(NSPredicate *)predicate
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:NSStringFromClass([Friend class])];
    fetchRequest.predicate = predicate;
    NSSortDescriptor *nameSortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"friendId" ascending:NO];
    fetchRequest.sortDescriptors = @[nameSortDescriptor];
    
    return [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                               managedObjectContext:[NSManagedObjectContext MR_defaultContext]
                                                 sectionNameKeyPath:nil
                                                          cacheName:nil];
}


@end
