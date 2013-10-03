//
//  FeedViewController.m
//  Emu
//
//  Created by Christopher Constable on 10/3/13.
//  Copyright (c) 2013 Mobiquity. All rights reserved.
//

#import "FeedViewController.h"
#import "EmuUtilities.h"
#import "EmuEvent.h"

@interface FeedViewController ()
@property (nonatomic, strong) NSArray *unscheduledEvents;
@end

@implementation FeedViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    [[EmuUtilities sharedUtilities] requestUnscheduledEventsWithOptions:nil
                                                             completion:^(BOOL success, NSError *__autoreleasing *error, NSArray *events) {
                                                                 self.unscheduledEvents = events;
                                                                 [self.tableView reloadData];
                                                             }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.unscheduledEvents.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EventCell"];
    id<EmuEvent> event = [self.unscheduledEvents objectAtIndex:indexPath.row];
    
    cell.textLabel.text = event.venue.name;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
