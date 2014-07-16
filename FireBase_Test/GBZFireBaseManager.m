//
//  GBZFireBaseManager.m
//  FireBaseTest
//
//  Created by Federico Guardabrazo Vallejo on 16/07/14.
//  Copyright (c) 2014 guardabrazo. All rights reserved.
//

#define MECHANIMALS_FIREBASE_URL @"https://mechanimals.firebaseio.com/room/"
#define MEHCANIMALS_FIREBASE_CONNECTED_URL @"https://mechanimals.firebaseio.com/.info/connected"

#import "GBZFireBaseManager.h"
#import <Firebase/Firebase.h>

@interface GBZFireBaseManager ()

@property (strong, nonatomic) Firebase *fireBaseRef;
@property (strong, nonatomic) Firebase *connectedRef;

@property (copy, nonatomic) NSString *playerID;

@end

@implementation GBZFireBaseManager


- (instancetype)initWithFireBaseRefAndPlayerID{
    
    self = [super init];
    if (self) {
        _fireBaseRef = [[Firebase alloc] initWithUrl:MECHANIMALS_FIREBASE_URL];
        _connectedRef = [[Firebase alloc] initWithUrl:MEHCANIMALS_FIREBASE_CONNECTED_URL];
        _playerID = [self createPlayerID];
        
    }
    return self;
}

- (void)addPlayer{
    
    [[self.fireBaseRef childByAppendingPath:self.playerID] setValue:@{@"playerID": self.playerID}];
}

- (void)removePlayer{
    
    [[self.fireBaseRef childByAppendingPath:self.playerID]setValue:@{}];
}

- (void)startMonitoringChanges{
    
    [self.fireBaseRef observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        self.numberOfPlayers = snapshot.childrenCount;
    }];
}

- (void) handleConnectionStatus{
    
    [self.connectedRef observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
       
        if([snapshot.value boolValue]) {
            
            self.isConnected = YES;
            
            if ([[UIApplication sharedApplication] applicationState] == UIApplicationStateActive){
                [self addPlayer];
            }
            
        } else {
            
            self.isConnected = NO;
            [self removePlayer];
        }
    }];
}

#pragma mark - Helper methods

-(NSString*)createPlayerID{
    
    NSUUID *playerUUID = [[UIDevice currentDevice] identifierForVendor];
    NSString *playerID = [playerUUID UUIDString];
    
    return playerID;
}

@end
