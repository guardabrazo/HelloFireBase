//
//  GBZFireBaseManager.h
//  FireBaseTest
//
//  Created by Federico Guardabrazo Vallejo on 16/07/14.
//  Copyright (c) 2014 guardabrazo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GBZFireBaseManager : NSObject

@property (nonatomic) NSUInteger numberOfPlayers;

- (instancetype)initWithFireBaseRefAndPlayerID;

- (void)addPlayer;

- (void)startMonitoringChanges;

@end
