//
//  ScannerViewController.m
//  HackVtProject
//
//  Created by Jordan Rouille on 10/10/13.
//  Copyright (c) 2013 CSScrew. All rights reserved.
//

#import "ScannerViewController.h"
#import "ContainerController.h"

@interface ScannerViewController ()
@end

@implementation ScannerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        //Title To Appear On TabBar
        self.title = @"Scan QR Poster";
        
        
        //QR Stuff
        // Turn off all symbols first.  Then enable them explicitly.
        /*
        // http://zbar.sourceforge.net/iphone/sdkdoc/optimizing.html
        [self.scanner setSymbology: 0            config: ZBAR_CFG_ENABLE to: 0];
        [self.scanner setSymbology: ZBAR_UPCA    config: ZBAR_CFG_ENABLE to: 1];
        [self.scanner setSymbology: ZBAR_UPCE    config: ZBAR_CFG_ENABLE to: 1];
        [self.scanner setSymbology: ZBAR_EAN2    config: ZBAR_CFG_ENABLE to: 1];
        [self.scanner setSymbology: ZBAR_EAN5    config: ZBAR_CFG_ENABLE to: 1];
        [self.scanner setSymbology: ZBAR_EAN8    config: ZBAR_CFG_ENABLE to: 1];
        [self.scanner setSymbology: ZBAR_EAN13   config: ZBAR_CFG_ENABLE to: 1];
        [self.scanner setSymbology: ZBAR_ISBN10  config: ZBAR_CFG_ENABLE to: 1];
        [self.scanner setSymbology: ZBAR_ISBN13  config: ZBAR_CFG_ENABLE to: 1];
        [self.scanner setSymbology: ZBAR_QRCODE  config: ZBAR_CFG_ENABLE to: 1];
        */
        [self.scanner setSymbology: ZBAR_I25
                       config: ZBAR_CFG_ENABLE
                           to: 0];
        
        self.readerDelegate            = self;
        self.supportedOrientationsMask = ZBarOrientationMaskAll;
        self.showsZBarControls         = NO;  // Hide ZBar toolbar (Close / Help)
        self.tracksSymbols             = YES;//NO;  // Show greenbox for UPC??
        self.readerView.torchMode      = NO;  // No flash
        self.wantsFullScreenLayout     = YES;  //NO; Stops ZBar from messing with StatusBar
        self.readerView.zoom           = 1.0; // Don't zoom camera (default is 1.25)

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

#pragma mark - Core Location

- (void)startStandardUpdates
{
    // Create the location manager if this object does not
    // already have one.
    if (nil == self.locationManager)
        self.locationManager = [[CLLocationManager alloc] init];
    
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
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
        //Do something with new GPS coordinate
    }
}

#pragma mark - Image Picker

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    NSLog(@"CLOSED PICKER");
}

- (void)imagePickerController: (UIImagePickerController*) reader didFinishPickingMediaWithInfo: (NSDictionary*) info
{
    // ADD: get the decode results
    id<NSFastEnumeration> results =
    [info objectForKey: ZBarReaderControllerResults];
    ZBarSymbol *symbol = nil;
    for(symbol in results)
        // EXAMPLE: just grab the first barcode
        break;
    
    // EXAMPLE: do something useful with the barcode data
    NSLog(@"RESULTS: %@",symbol.data);
    
    /*
    // EXAMPLE: do something useful with the barcode image
    resultImage.image =
    [info objectForKey: UIImagePickerControllerOriginalImage];
    */
    
    [[ContainerController sharedContainer] setSelectedViewController:[[[ContainerController sharedContainer] viewControllers] objectAtIndex:1]];
}


#pragma mark - Other

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
