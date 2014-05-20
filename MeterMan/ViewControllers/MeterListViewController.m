//
//  MeterListViewController.m
//  MeterMan
//
//  Created by Zsolt Kiss on 2014.05.14..
//  Copyright (c) 2014 Zsolt Kiss. All rights reserved.
//

#import "MeterListViewController.h"
#import "Meter.h"
#import "UtilityType.h"
#import "MeterManUtil.h"
#import "MeterDetailsViewController.h"
#import "AddMeterViewController.h"
#import "DBUtil.h"

static const NSInteger TAG_FOR_IMAGE_VIEW_HOLDER_ON_CELL = 101;
static const NSInteger TAG_FOR_LABEL_ON_CELL = 102;

@interface MeterListViewController () {
//    NSArray *_metersForCurrentType;
    NSArray *_meters;
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
    
    self.view.backgroundColor = [UIColor colorWithRed:189/255.0f green:190/255.0f blue:194/255.0f alpha:1.0f];
    
    self.navigationController.navigationBar.hidden = NO;
    
    self.navigationItem.rightBarButtonItem.target = self;
    self.navigationItem.rightBarButtonItem.action = @selector(rightBarButtonItemTapped:);
    
    
    [self refreshDatasource];
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (self.refreshNeeded) {
        [self refreshDatasource];
        [self.tableView reloadData];
        self.refreshNeeded = NO;
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
    return [_meters count];
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
    Meter *aMeter = [_meters objectAtIndex:indexPath.row];
    
    cell.textLabel.text = aMeter.alias;
    cell.detailTextLabel.text = aMeter.productNumber;
    cell.imageView.image = [MeterManUtil imageForPublicUtilityType:[aMeter.utilityType.typeId integerValue]];
    
    UIColor *bgColor = [MeterManUtil backgroundColorForPublicUtilityType:[aMeter.utilityType.typeId integerValue]];
    
    if (bgColor == nil) {
        bgColor = [UIColor colorWithRed:189/255.0f green:190/255.0f blue:194/255.0f alpha:1.0f];
    }
    
    cell.backgroundColor = bgColor;
    
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





#pragma mark - Private methods

- (void)refreshDatasource {
//    _metersForCurrentType = [DBUtil metersByPublicUtilityType:self.type];
    
    _meters = [DBUtil allMeters];
    
}


- (void)rightBarButtonItemTapped:(id)sender {
    [self performSegueWithIdentifier:@"AddMeter" sender:sender];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"AddMeter"]) {
        AddMeterViewController *nextVC = (AddMeterViewController *)segue.destinationViewController;
        nextVC.publicUtilityType = self.type;
        
    } else if ([segue.identifier isEqualToString:@"MeterDetails"]) {
        
        NSIndexPath *ip = [self.tableView indexPathForSelectedRow];
        
        Meter *selectedMeter = nil;
        if (ip && ip.row >= 0) {
            selectedMeter = [_meters objectAtIndex:ip.row];
        }
        
        if (selectedMeter) {
            MeterDetailsViewController *nextVC = (MeterDetailsViewController *)segue.destinationViewController;
            nextVC.selectedMeter = selectedMeter;
        }
    }
    
}


@end
