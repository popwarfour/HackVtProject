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

#define BASEURL @"http://www.uvm.edu/~mftoth/hackvt/api/"

typedef void (^VoidBlock)(void);


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
        
        //[self getFakeEvents];
        [self getEventsFromServer];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 568)];
    //[backgroundView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"tableViewBackground.png"]]];
    [backgroundView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:backgroundView];
    [self.view bringSubviewToFront:self.eventsTableView];
    [self.eventsTableView setBackgroundColor:[UIColor clearColor]];
    [self.eventsTableView setHidden:FALSE];
    
    self.segmentBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
    [self.segmentBackgroundView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"segmentBackground.png"]]];
    [self.view addSubview:self.segmentBackgroundView];
    
    /*
    self.sortEventSegment = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"Date", @"Genre", @"Venue", @"City", nil]];
    [self.sortEventSegment setFrame:CGRectMake(100, 45, self.segmentBackgroundView.frame.size.width - 105, 40)];
    [self.sortEventSegment addTarget:self action:@selector(eventSortSegmentChanged) forControlEvents:UIControlEventTouchUpInside];
    [self.segmentBackgroundView addSubview:self.sortEventSegment];
*/
    
    self.eventsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.eventsSegment = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"All Events", @"Suggested", @"Scanned", nil]];
    [self.eventsSegment setFrame:CGRectMake(10, 5, self.view.frame.size.width - 105, 30)];
    self.eventsSegment.segmentedControlStyle = UISegmentedControlStyleBar;
    self.eventsSegment.selectedSegmentIndex = 0;
    [self.eventsSegment addTarget:self action:@selector(eventSegmentChanged) forControlEvents:UIControlEventValueChanged];
    [self.segmentBackgroundView addSubview:self.eventsSegment];
    
    self.QRScanButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.QRScanButton setBackgroundImage:[UIImage imageNamed:@"button.png"] forState:UIControlStateNormal];
    [self.QRScanButton setFrame:CGRectMake(self.view.frame.size.width - 90, 5, 90, 30)];
    [self.QRScanButton setTitle:@"Scan QR" forState:UIControlStateNormal];
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
    self.fadeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 568)];
    [self.fadeView setBackgroundColor:[UIColor blackColor]];
    [self.fadeView setAlpha:0];
    [self.view addSubview:self.fadeView];
    
    MapPinSelectorView *spinner = [[MapPinSelectorView alloc] initWithDuration:1 andFrame:CGRectMake((self.view.frame.size.width / 2) - 50, (self.view.frame.size.height / 2) - 50, 100, 100)];
    [self.fadeView addSubview:spinner];
    
    VoidBlock animate = ^
    {
        [self.fadeView setAlpha:.8];
    };
    [UIView animateWithDuration:.3 animations:animate];

    
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
         [self.allEvents removeAllObjects];
        for(NSDictionary *eventDictionary in allEventDictionaries)
        {
            EventObject *newEvent = [[EventObject alloc] initWithJSONObject:eventDictionary];
            [newEventObjects addObject:newEvent];
            [self.allEvents addObject:newEvent];
        }
        
        [self.eventsTableView reloadData];
        
         return newEventObjects;
     }
           completionBlock:^(FSNConnection *c)
     {
         NSArray *suggestionIndexes = [NSArray arrayWithObjects:@"Night Vision", @"DJ Stavros", @"Bonjour-Hi", @"Jam Man Entertainment", nil];
         for(NSString *title in suggestionIndexes)
         {
             for(EventObject *event in self.allEvents)
             {
                 NSLog(@"%@ - %@", title, event.title);
                 if([event.title isEqualToString:title])
                 {
                     [self.suggestedEvents addObject:event];
                 }
             }
             
         }
         
         NSLog(@"suggested count: %d", self.suggestedEvents.count);

     }
             progressBlock:^(FSNConnection *c)
     {
         
         
         
     }];
    
    [connection start];
}

-(void)removeFadeView
{
    [self.fadeView removeFromSuperview];
    self.fadeView = nil;
}

#pragma mark - TABLE VIEW DATA SOURCE
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(self.eventsSegment.selectedSegmentIndex == 0)
    {
        NSLog(@"counter : %d", self.allEvents.count);
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
    
    [cell.contentView setBackgroundColor:[UIColor clearColor]];

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

-(void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([indexPath row] == ((NSIndexPath*)[[tableView indexPathsForVisibleRows] lastObject]).row)
    {
         NSLog(@"COMPLETED!");
         VoidBlock animate = ^
         {
         [self.fadeView setAlpha:0];
         };
         [UIView animateWithDuration:.3 animations:animate];
         [self performSelector:@selector(removeFadeView) withObject:nil afterDelay:.3];
    }
}

 /*
 - (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath
 {
 
 }
*/

#pragma mark - Events Segment Method
-(void)eventSegmentChanged
{
    if(self.eventsSegment.selectedSegmentIndex == 0)
    {
        [self getEventsFromServer];
    }
    else
        [self.eventsTableView reloadData];
}

/*
-(void)eventSortSegmentChanged
{
    if(self.sortEventSegment.selectedSegmentIndex == 0)
    {
        NSArray *sortedArray;
        sortedArray = [self.allEvents sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
            NSString *first = [(EventObject *)a eventDate];
            NSString *second = [(EventObject *)b eventDate];
            return [first compare:second];
        }];
        self.allEvents = [NSMutableArray arrayWithArray:sortedArray];
    }
    else if(self.sortEventSegment.selectedSegmentIndex == 1)
    {
        NSArray *sortedArray;
        sortedArray = [self.allEvents sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
            NSString *first = [(EventObject *)a genre];
            NSString *second = [(EventObject *)b genre];
            return [first compare:second];
        }];
        self.allEvents = [NSMutableArray arrayWithArray:sortedArray];
    }
    else if(self.sortEventSegment.selectedSegmentIndex == 2)
    {
        NSArray *newSortedArray = [self.allEvents sortedArrayUsingDescriptors:[NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"venue" ascending:TRUE]]];
        self.allEvents = [NSMutableArray arrayWithArray:newSortedArray];
    }
    else if(self.sortEventSegment.selectedSegmentIndex == 3)
    {
        NSArray *newSortedArray = [self.allEvents sortedArrayUsingDescriptors:[NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"city" ascending:TRUE]]];
        self.allEvents = [NSMutableArray arrayWithArray:newSortedArray];
    }
    [self.eventsTableView reloadData];
}
*/

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
    
    int index = -1;
    int count = 0;
    for(EventObject *event in self.allEvents)
    {
        if(event.eventID == symbol.data.integerValue)
        {
            index = count;
        }
        count++;
    }
    if(index == -1)
    {
        index = arc4random() % (self.allEvents.count - 1);
    }
    
    EventObject *scannedEvent = [self.allEvents objectAtIndex:index];
    //self.scannedEventID = scannedEvent.eventID;
    self.scannedEventID = 1;

    
    EventObject *foundEvent = [self.allEvents objectAtIndex:index];
    EventsDetailViewController *detail = [[EventsDetailViewController alloc] initWithEventObject:foundEvent];
    
    BOOL found = FALSE;
    for(EventObject *event in self.scannedEvents)
    {
        if(event.eventID == foundEvent.eventID)
        {
            found = TRUE;
        }
    }
    if(!found)
        [self.scannedEvents addObject:foundEvent];
    
    [self.eventsSegment setSelectedSegmentIndex:2];
    [self.eventsTableView reloadData];
    
    //Start GPS Updates
    [self startStandardUpdates];
    
    [self presentViewController:detail animated:TRUE completion:nil];
    
}

#pragma mark - GPS Methods

- (void)startStandardUpdates
{
    // Create the location manager if this object does not
    // already have one.
    if (nil == self.locationManager)
        self.locationManager = [[CLLocationManager alloc] init];
    
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    
    // Set a movement threshold for new events.
    self.locationManager.distanceFilter = 500;
    
    [self.locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    // If it's a relatively recent event, turn off updates to save power
    CLLocation* location = [locations lastObject];
    NSDate* eventDate = location.timestamp;
    NSTimeInterval howRecent = [eventDate timeIntervalSinceNow];
    if (abs(howRecent) < 1.0)
    {
        [self updateServerWithPosterLocation:(CLLocation *)location];
        
        [self.locationManager stopUpdatingLocation];
        [self.locationManager stopUpdatingHeading];
    }
}

-(void)updateServerWithPosterLocation:(CLLocation *)location
{
    NSArray *keys = [NSArray arrayWithObjects:@"eventid", @"lat", @"lng", nil];
    NSArray *objects = [NSArray arrayWithObjects:[NSNumber numberWithInt:self.scannedEventID], [NSNumber numberWithDouble:location.coordinate.latitude], [NSNumber numberWithDouble:location.coordinate.longitude], nil];
    NSDictionary *parameters = [NSDictionary dictionaryWithObjects:objects forKeys:keys];

    NSLog(@"UPDATING WITH SERVER!| %@", [NSString stringWithFormat:@"%@poster.php", BASEURL]);
    FSNConnection *connection =
    [FSNConnection withUrl:[NSURL URLWithString:[NSString stringWithFormat:@"%@poster.php", BASEURL]]
                    method:FSNRequestMethodPOST
                   headers:nil
                parameters:parameters
                parseBlock:^id(FSNConnection *c, NSError **error)
     {
         NSLog(@"PARSE BLOCK");
         return nil;
     }
           completionBlock:^(FSNConnection *c)
     {
         NSLog(@"COMPLETION");
     }
             progressBlock:^(FSNConnection *c)
     {
         NSLog(@"PREGRESS");
     }];
    
    [connection start];
}

#pragma mark - UISearchField Delegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if([searchText isEqualToString:@""])
    {
        //REMOVE FILTERED SEARCH
        [self getEventsFromServer];
        [self.eventsTableView reloadData];
    }
    else
    {
        //FILTERED SEARCH
        NSPredicate* predicate = [NSPredicate predicateWithFormat:@"title CONTAINS[cd] %@", searchText];
        NSArray *filteredTermData = [self.allEvents filteredArrayUsingPredicate:predicate];
        
        self.allEvents = [NSMutableArray arrayWithArray:filteredTermData];
        [self.eventsTableView reloadData];
    }
}

/*
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    [self generateData];
    
    //Keyboard
    CGRect currentFrame = self.glossaryTableView.frame;
    currentFrame.size.height -= 167;
    [self.glossaryTableView setFrame:currentFrame];
    
    CGRect currentFrame2 = self.detailScrollView.frame;
    currentFrame2.size.height -= 167;
    [self.detailScrollView setFrame:currentFrame2];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    //Keyboard
    CGRect currentFrame = self.glossaryTableView.frame;
    currentFrame.size.height += 167;
    [self.glossaryTableView setFrame:currentFrame];
    
    CGRect currentFrame2 = self.detailScrollView.frame;
    currentFrame2.size.height += 167;
    [self.detailScrollView setFrame:currentFrame2];
}
 */

#pragma mark - Other

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
