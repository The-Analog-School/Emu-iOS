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
#import <SVProgressHUD.h>

#import <AFNetworking/UIImageView+AFNetworking.h>
#import <AFNetworking/AFNetworking.h>

@interface FeedViewController ()

@property (nonatomic, strong) NSArray *unscheduledEvents;
@property (nonatomic, strong) UIRefreshControl *refreshControl;

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
	
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(refreshControlDidRefresh:)
             forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:self.refreshControl];
    
    [SVProgressHUD showWithStatus:@"Requesting events..."];
    [self requestUnscheduledEvents];
}

- (void)requestUnscheduledEvents
{
    
    [[EmuUtilities sharedUtilities] requestUnscheduledEventsWithOptions:nil
                                                             completion:^(BOOL success, NSError *__autoreleasing *error, NSArray *events) {
                                                                 self.unscheduledEvents = events;
                                                                 [self.tableView reloadData];
                                                                 
                                                                 if ([self.refreshControl isRefreshing]) {
                                                                     [self.refreshControl endRefreshing];
                                                                 }
                                                                 [SVProgressHUD dismiss];
                                                             }];
}

#pragma mark - Table View

- (void)refreshControlDidRefresh:(UIRefreshControl *)refreshControl
{
    [self.refreshControl endRefreshing];
    [self requestUnscheduledEvents];
}

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
    UnscheduledEventCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EventCell"];
    id<EmuEvent> event = [self.unscheduledEvents objectAtIndex:indexPath.row];
    
    cell.delegate = self;
    
    [cell.eventImage setImageWithURL:event.venue.photoUrl];
    cell.eventImage.backgroundColor = [UIColor redColor];
    cell.eventImage.layer.cornerRadius = 3.0;
    cell.eventImage.clipsToBounds = YES;
    
    cell.eventTitleLabel.text = event.venue.name;
    cell.eventCreatedUserLabel.text = event.createdUser.fullName;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateStyle = NSDateFormatterMediumStyle;
    dateFormatter.timeStyle = NSDateFormatterShortStyle;
    cell.eventDateLabel.text = [dateFormatter stringFromDate:event.eventStartDate];
    
    cell.eventDescriptionLabel.text = event.eventDescription;
    
    /**
    NSString *urlString = [NSString stringWithFormat:@""];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // Apple Old Way
    [NSURLConnection connectionWithRequest:request delegate:self];
    
    // Apple New Way
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                               
                           }];
    
    // AFNetworking Way
    AFHTTPRequestOperation *requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    [requestOperation start];
    
    // Mobiquity Way
    MobMSNetworkCallJSON *jsonCall = [[MobMSNetworkCallJSON alloc] init];
    [jsonCall setRequestURL:url];
    [jsonCall executeAsyncWithSuccessBlock:^{
        JSON = jsonCall.responseJSON;
    }];
    */
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - UnscheduledEventCellDelegate

- (void)unscheduledEventCellVoteButtonWasPressed:(UnscheduledEventCell *)cell
{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    id<EmuEvent> event = [self.unscheduledEvents objectAtIndex:indexPath.row];
    
    [[EmuUtilities sharedUtilities] addVoteToEvent:event
                                        completion:^(BOOL success, NSError *__autoreleasing *error) {
                                           // TODO: Update UI
                                        }];
}

@end
