//
//  GBZViewController.m
//  FireBase_Test
//
//  Created by Federico Guardabrazo Vallejo on 16/07/14.
//  Copyright (c) 2014 guardabrazo. All rights reserved.
//

#import "GBZViewController.h"

@interface GBZViewController ()

@property (weak, nonatomic) IBOutlet UILabel *numberOfPlayersLabel;

@end

@implementation GBZViewController

-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    [self.fireBaseManager addObserver:self forKeyPath:@"numberOfPlayers" options:NSKeyValueObservingOptionNew context:NULL];
    
    [self performSelector:@selector(updateLabel) withObject:self
               afterDelay:3];
}

- (void) observeValueForKeyPath:(NSString*)keyPath ofObject:(id)object change:(NSDictionary*)change context:(void*)context {
    if ([keyPath isEqual:@"numberOfPlayers"]) {
        [self updateLabel];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}


-(void)updateLabel{
    
      self.numberOfPlayersLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)self.fireBaseManager.numberOfPlayers];
}


@end
