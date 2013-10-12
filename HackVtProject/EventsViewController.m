//
//  EventsViewController.m
//  HackVtProject
//
//  Created by Jordan Rouille on 10/10/13.
//  Copyright (c) 2013 CSScrew. All rights reserved.
//

#import "EventsViewController.h"
#import "ContainerController.h"
#import "EventCell.h"
#import "EventsDetailViewController.h"
#import "FSNConnection.h"

#define BASEURL @"http://192.168.8.246/hackvt/HackVtProject/api/"

@interface EventsViewController ()

@end

@implementation EventsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.allEvents = [[NSMutableArray alloc] init];
        self.suggestedEvents = [[NSMutableArray alloc] init];
        self.scannedEvents = [[NSMutableArray alloc] init];
        
        [self getFakeEvents];
        //[self getEventsFromServer];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.segmentBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
    [self.segmentBackgroundView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"segementBackgroundGradient.png"]]];
    [self.view addSubview:self.segmentBackgroundView];
    
    self.eventsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.eventsSegment = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"All Events", @"Suggested", @"Scanned", nil]];
    [self.eventsSegment setFrame:CGRectMake(10, 5, self.view.frame.size.width - 70, 30)];
    self.eventsSegment.segmentedControlStyle = UISegmentedControlStyleBar;
    self.eventsSegment.selectedSegmentIndex = 0;
    [self.eventsSegment addTarget:self action:@selector(eventSegmentChanged) forControlEvents:UIControlEventValueChanged];
    [self.segmentBackgroundView addSubview:self.eventsSegment];
    
    self.QRScanButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.QRScanButton setFrame:CGRectMake(self.view.frame.size.width - 55, 5, 50, 30)];
    [self.QRScanButton setTitle:@"QR" forState:UIControlStateNormal];
    [self.QRScanButton setBackgroundColor:[UIColor blackColor]];
    [self.QRScanButton addTarget:self action:@selector(scanButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.QRScanButton setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:self.QRScanButton];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.segmentBackgroundView setFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
}

#pragma mark - Networking Controller

-(void)getFakeEvents
{    
    for(int i = 0; i < 20; i++)
    {
        EventObject *newEvent1 = [[EventObject alloc] initWithFakeData];
        EventObject *newEvent2 = [[EventObject alloc] initWithFakeData];
        EventObject *newEvent3 = [[EventObject alloc] initWithFakeData];

        [self.allEvents addObject:newEvent1];
        [self.suggestedEvents addObject:newEvent2];
        [self.scannedEvents addObject:newEvent3];
    }
    [self.eventsTableView reloadData];
}

-(void)getEventsFromServer
{
    FSNConnection *connection =
    [FSNConnection withUrl:[NSURL URLWithString:[NSString stringWithFormat:@"%@events.php", BASEURL]]
                    method:FSNRequestMethodGET
                   headers:nil
                parameters:nil
                parseBlock:^id(FSNConnection *c, NSError **error)
     {
        FSNParseBlock parseBlock = c.parseBlock;
         
        //Add new points
        NSArray *allEventDictionaries = [c.responseData arrayFromJSONWithError:error];
        NSMutableArray *newEventObjects = [[NSMutableArray alloc] init];
        for(NSDictionary *eventDictionary in allEventDictionaries)
        {
            EventObject *newEvent = [[EventObject alloc] initWithJSONObject:eventDictionary];
            [newEventObjects addObject:newEvent];
        }
        
        return newEventObjects;
     }
           completionBlock:^(FSNConnection *c)
     {
         NSMutableArray *newEvents = c.parseResult;
         if(newEvents.count > 0)
         {
             [self.allEvents removeAllObjects];
             self.allEvents = newEvents;
         }
     }
             progressBlock:^(FSNConnection *c)
     {
         //NSLog(@"progress: %@: %.2f/%.2f", c, c.uploadProgress, c.downloadProgress);
     }];
    
    [connection start];
}

#pragma mark - TABLE VIEW DATA SOURCE
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(self.eventsSegment.selectedSegmentIndex == 0)
    {
        return self.allEvents.count;
    }
    else if(self.eventsSegment.selectedSegmentIndex == 1)
    {
        return self.suggestedEvents.count;
    }
    else
    {
        return self.scannedEvents.count;
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cellID";
    
    EventCell *cell = [self.eventsTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell != nil)
    {
        for(UIView *subview in cell.contentView.subviews)
        {
            [subview removeFromSuperview];
        }
    }
    
    
    if(self.eventsSegment.selectedSegmentIndex == 0)
    {
        cell = [[EventCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier andEventObject:[self.allEvents objectAtIndex:indexPath.row]];
    }
    else if(self.eventsSegment.selectedSegmentIndex == 1)
    {
        cell = [[EventCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier andEventObject:[self.suggestedEvents objectAtIndex:indexPath.row]];
    }
    else
    {
        cell = [[EventCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier andEventObject:[self.scannedEvents objectAtIndex:indexPath.row]];
    }

    return cell;
}
/*
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 
 }
 
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 
 }
 
 #pragma - TABLE VIEW DELEGATE
 
 - (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
 {
 
 }
 
 - (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
 {
 
 }*/

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 105;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    EventObject *event = nil;

    if(self.eventsSegment.selectedSegmentIndex == 0)
    {
        event = [self.allEvents objectAtIndex:indexPath.row];
    }
    else if(self.eventsSegment.selectedSegmentIndex == 1)
    {
        event = [self.suggestedEvents objectAtIndex:indexPath.row];
    }
    else
    {
        event = [self.scannedEvents objectAtIndex:indexPath.row];
    }
    
    EventsDetailViewController *detailEventView = [[EventsDetailViewController alloc] initWithEventObject:event];
    [self presentViewController:detailEventView animated:TRUE completion:nil];

}

 /*
 - (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath
 {
 
 }
*/

#pragma mark - Events Segment Method
-(void)eventSegmentChanged
{
    [self.eventsTableView reloadData];
}

#pragma mark - QR Scanning
-(IBAction)scanButtonPressed:(id)sender
{
    // ADD: present a barcode reader that scans from the camera feed
    //if(self.reader == nil)
    //{
        self.reader = [ZBarReaderViewController new];
        self.reader.readerDelegate = self;
        self.reader.readerView.zoom = 1.0;
        self.reader.supportedOrientationsMask = ZBarOrientationMaskAll;
        
        ZBarImageScanner *scanner = self.reader.scanner;
        // TODO: (optional) additional reader configuration here
        
        // EXAMPLE: disable rarely used I2/5 to improve performance
        [scanner setSymbology: ZBAR_I25
                       config: ZBAR_CFG_ENABLE
                           to: 0];
    //}

    
    // present and release the controller
    [self presentViewController:self.reader animated:TRUE completion:nil];

}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    NSLog(@"CLOSED PICKER");
    [self.reader dismissViewControllerAnimated:TRUE completion:nil];
}

- (void)imagePickerController: (UIImagePickerController*) reader didFinishPickingMediaWithInfo: (NSDictionary*) info
{
    // ADD: get the decode results
    id<NSFastEnumeration> results =
    [info objectForKey: ZBarReaderControllerResults];
    
    ZBarSymbol *symbol = nil;
    for(symbol in results)
        break;
    
    [self.reader dismissViewControllerAnimated:FALSE completion:nil];
    
    EventObject *foundEvent = [self.allEvents objectAtIndex:(arc4random() % 20)];
    EventsDetailViewController *detail = [[EventsDetailViewController alloc] initWithEventObject:foundEvent];
    
    [self presentViewController:detail animated:TRUE completion:nil];
    
}

#pragma mark - Other

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
