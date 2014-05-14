//
//  MeterListViewController.m
//  MeterMan
//
//  Created by Zsolt Kiss on 2014.05.14..
//  Copyright (c) 2014 Zsolt Kiss. All rights reserved.
//

#import "MeterListViewController.h"
#import "MeterDetails.h"
#import "MeterManUtil.h"
#import "MeterScanningsViewController.h"

static const NSInteger TAG_FOR_IMAGE_VIEW_HOLDER_ON_CELL = 101;
static const NSInteger TAG_FOR_LABEL_ON_CELL = 102;

@interface MeterListViewController () {
    NSArray *_metersForCurrentType;
}

@end

@implementation MeterListViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.navigationController.navigationBar.hidden = NO;
    
    self.navigationItem.rightBarButtonItem.target = self;
    self.navigationItem.rightBarButtonItem.action = @selector(addMeter:);
    
    switch (self.type) {
        case UtilityTypeWater:
            _metersForCurrentType = [self metersForWaterSupply];
            break;
            
        case UtilityTypeGas:
            _metersForCurrentType = [self metersForGasSupply];
            break;
            
        case UtilityTypeElectricity:
            _metersForCurrentType = [self metersForElectricitySupply];
            break;
            
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_metersForCurrentType count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MeterDetailsCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

    // Configure the cell...
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Display recipe in the table cell
    MeterDetails *details = [_metersForCurrentType objectAtIndex:indexPath.row];
    UIView *holderView = (UIView *)[cell viewWithTag:TAG_FOR_IMAGE_VIEW_HOLDER_ON_CELL];
    holderView.backgroundColor = [MeterManUtil bgColorForUtilityType:details.type];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[details typeImage]];
//    imageView.backgroundColor = [MeterManUtil bgColorForUtilityType:details.type];
    
    CGFloat x = (CGRectGetWidth(holderView.frame) - CGRectGetWidth(imageView.frame)) / 2;
    CGFloat y = (CGRectGetHeight(holderView.frame) - CGRectGetHeight(imageView.frame)) / 2;
    
    CGRect rect = imageView.frame;
    rect.origin.x = x;
    rect.origin.y = y;
    imageView.frame = rect;
    
    [holderView addSubview:imageView];
//    imageView.center = holderView.center;
    
    UILabel *lbAlias = (UILabel *)[cell viewWithTag:TAG_FOR_LABEL_ON_CELL];
    lbAlias.text = details.alias;
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */



#pragma mark - Private methods
/// Test data only.
- (NSArray *)metersForGasSupply {
    
    MeterDetails *details = [[MeterDetails alloc] initWithType:UtilityTypeGas];
    details.alias = @"Gáz, Horány";
    details.ownerName = @"Zsolt Kiss";
    details.meterId = @"4000839657";
    details.installationAddress = @"2165/15 Fenyo ter, Szigetmonostor, Hungary 2015";
    
    [details addPropertyWithKey:@"LastFourDigitsIdentifier" andValue:@"8182"];
    
    return [NSArray arrayWithObject:details];
    
}


/// Test data only.
- (NSArray *)metersForWaterSupply {
    
    
    MeterDetails *meter1 = [[MeterDetails alloc] initWithType:UtilityTypeWater];
    meter1.alias = @"Melegvíz, Dunakeszi";
    meter1.ownerName = @"Agnes Meszaros";
    meter1.meterId = @"1111252059874566";
    meter1.installationAddress = @"2120 Dunakeszi, Iskola u. 11, X/43";
    
    [meter1 addPropertyWithKey:@"Last value read" andValue:@"76 m3"];
    [meter1 addPropertyWithKey:@"Hot water" andValue:@"YES"];
    
    
    MeterDetails *meter2 = [[MeterDetails alloc] initWithType:UtilityTypeWater];
    meter2.alias = @"Hidegvíz, Dunakeszi";
    meter2.ownerName = @"Agnes Meszaros";
    meter2.meterId = @"7899985216512";
    meter2.installationAddress = @"2120 Dunakeszi, Iskola u. 11, X/43";
    
    [meter2 addPropertyWithKey:@"Last value read" andValue:@"117 m3"];
    [meter2 addPropertyWithKey:@"Hot water" andValue:@"NO"];
    
    return [NSArray arrayWithObjects:meter1, meter2, nil];
    
}


/// Test data only.
- (NSArray *)metersForElectricitySupply {
    
    
    MeterDetails *meter1 = [[MeterDetails alloc] initWithType:UtilityTypeElectricity];
    meter1.alias = @"Villany, Dunakeszi";
    meter1.ownerName = @"Agnes Meszaros";
    meter1.meterId = @"589663665214";
    meter1.installationAddress = @"2120 Dunakeszi, Iskola u. 11, X/43";
    
    [meter1 addPropertyWithKey:@"Last value read" andValue:@"6227 kWh"];
    
    MeterDetails *meter2 = [[MeterDetails alloc] initWithType:UtilityTypeElectricity];
    meter2.alias = @"Villany, Horány";
    meter2.ownerName = @"Zsolt Kiss";
    meter2.meterId = @"28871126651";
    meter2.installationAddress = @"2165/15 Fenyo ter, Szigetmonostor, Hungary 2015";
    
    [meter2 addPropertyWithKey:@"Last value read" andValue:@"6233 kWh"];
    
    return [NSArray arrayWithObjects:meter1, meter2, nil];
    
}

- (void)addMeter:(id)sender {
//    NSLog(@"%@ called...", NSStringFromSelector(_cmd));
    
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Not implemented yet" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [av show];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    NSIndexPath *ip = [self.tableView indexPathForSelectedRow];
    
    MeterDetails *selectedMeter = nil;
    if (ip && ip.row >= 0) {
        selectedMeter = [_metersForCurrentType objectAtIndex:ip.row];
    }
    
    if (selectedMeter) {
        MeterScanningsViewController *nextVC = (MeterScanningsViewController *)segue.destinationViewController;
        nextVC.meterDetails = selectedMeter;
    }
    
}


@end
