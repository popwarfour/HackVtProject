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
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.eventsSegment = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"All Events", @"Suggested", @"Scanned", nil]];
    [self.eventsSegment setFrame:CGRectMake(10, 5, self.view.frame.size.width - 70, 30)];
    self.eventsSegment.segmentedControlStyle = UISegmentedControlStyleBar;
    self.eventsSegment.selectedSegmentIndex = 1;
    [self.eventsSegment addTarget:self action:@selector(eventSegmentChanged) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.eventsSegment];
    
    self.QRScanButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.QRScanButton setFrame:CGRectMake(self.view.frame.size.width - 55, 5, 50, 30)];
    [self.QRScanButton setTitle:@"QR" forState:UIControlStateNormal];
    [self.QRScanButton setBackgroundColor:[UIColor blackColor]];
    [self.QRScanButton addTarget:self action:@selector(scanButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.QRScanButton];
}

#pragma mark - Networking Controller

-(void)getEventsFromServer
{
    [self.eventsTableView reloadData];
    
    [self.allEvents removeAllObjects];
    for(NSDictionary *event in returnEvents)
    {
        EventObject *newEvent = [[EventObject alloc] initWithJSONObject:event];
        [self.allEvents addObject:newEvent];
    }
}

#pragma mark - TABLE VIEW DATA SOURCE
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //REPLACE THE RETURN WITH THE NUMBER OF EVENTS IN THE ARRAY!
    return 10;
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
    
    
    //Work from here down.
    
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
    return 50;
}
 - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
 {
 
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
    
    
    [self parseQRSymbols:results];
    
    /*
    ZBarSymbol *symbol = nil;
    for(symbol in results)
        // EXAMPLE: just grab the first barcode
        break;
    
    // EXAMPLE: do something useful with the barcode data
    NSLog(@"RESULTS: %@",symbol.data);
    */
    /*
     // EXAMPLE: do something useful with the barcode image
     resultImage.image =
     [info objectForKey: UIImagePickerControllerOriginalImage];
     */
    
    [self.reader dismissViewControllerAnimated:TRUE completion:nil];
    
}

-(void)parseQRSymbols:(id<NSFastEnumeration>)symbols
{
    for(ZBarSymbol *symbol in symbols)
    {
        
    }
}

#pragma mark - Other

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
