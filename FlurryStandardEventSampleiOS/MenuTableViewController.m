//
//  MenuTableViewController.m
//  FlurryStandardEventSampleiOS
//
//  Created by Hantao Yang on 7/28/21.
//

#import "MenuTableViewController.h"
#import "StandardEventTableViewController.h"

@interface MenuTableViewController () <UIPickerViewDelegate, UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *standardEventTypeLabel;
@property (weak, nonatomic) IBOutlet UIPickerView *standardEventPicker;

@property (nonatomic, assign) NSUInteger pickerIndex;
@property (nonatomic, strong) NSMutableArray<NSString *> *pickerData;
@property (nonatomic, assign) BOOL isPickerHidden;


@end

@implementation MenuTableViewController

#pragma mark - UIPickerDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.pickerData.count;
}

#pragma mark - UIPickerDelegate

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component API_UNAVAILABLE(tvos){
    return self.pickerData[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component API_UNAVAILABLE(tvos){
    [self.standardEventTypeLabel setText:self.pickerData[row]];
    self.pickerIndex = row;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.isPickerHidden = YES;
    self.standardEventPicker.delegate = self;
    self.standardEventPicker.dataSource = self;
    
    [self.standardEventPicker setHidden:self.isPickerHidden];
    self.standardEventTypeLabel.text = self.pickerData[0];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section == 0){
        return 2;
    }
    else{
        return 1;
    }
    
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return NO;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(indexPath.section == 0 && indexPath.row == 0){
        BOOL shouldHide = !self.standardEventPicker.isHidden;
        [self.tableView beginUpdates];
        [self.standardEventPicker setHidden:shouldHide];
        [self.tableView endUpdates];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && indexPath.row == 1) {
        return self.standardEventPicker.isHidden ? 0 : 100;
    }
    return UITableViewAutomaticDimension;
}

- (NSMutableArray *)pickerData{
    if(!_pickerData){
        _pickerData = [NSMutableArray new];
        [_pickerData addObject:@"AdClick"];
        [_pickerData addObject:@"AdImpression"];
        [_pickerData addObject:@"AdRewarded"];
        [_pickerData addObject:@"AdSkipped"];
        [_pickerData addObject:@"CreditsSpent"];
        [_pickerData addObject:@"CreditsPurchased"];
        [_pickerData addObject:@"CreditsEarned"];
        [_pickerData addObject:@"AchievementUnlocked"];
        [_pickerData addObject:@"LevelCompleted"];
        [_pickerData addObject:@"LevelFailed"];
        [_pickerData addObject:@"LevelUp"];
        [_pickerData addObject:@"LevelStarted"];
        [_pickerData addObject:@"LevelSkip"];
        [_pickerData addObject:@"ScorePosted"];
        [_pickerData addObject:@"ContentRated"];
        [_pickerData addObject:@"ContentViewed"];
        [_pickerData addObject:@"ContentSaved"];
        [_pickerData addObject:@"ProductCustomized"];
        [_pickerData addObject:@"AppActivated"];
        [_pickerData addObject:@"ApplicationSubmitted"];
        [_pickerData addObject:@"AddItemToCart"];
        [_pickerData addObject:@"AddItemToWishList"];
        [_pickerData addObject:@"CompletedCheckout"];
        [_pickerData addObject:@"PaymentInfoAdded"];
        [_pickerData addObject:@"ItemViewed"];
        [_pickerData addObject:@"ItemListViewed"];
        [_pickerData addObject:@"Purchased"];
        [_pickerData addObject:@"PurchaseRefunded"];
        [_pickerData addObject:@"RemoveItemFromCart"];
        [_pickerData addObject:@"CheckoutInitiated"];
        [_pickerData addObject:@"FundsDonated"];
        [_pickerData addObject:@"UserScheduled"];
        [_pickerData addObject:@"OfferPresented"];
        [_pickerData addObject:@"SubscriptionStarted"];
        [_pickerData addObject:@"SubscriptionEnded"];
        [_pickerData addObject:@"GroupJoined"];
        [_pickerData addObject:@"GroupLeft"];
        [_pickerData addObject:@"TutorialStarted"];
        [_pickerData addObject:@"TutorialCompleted"];
        [_pickerData addObject:@"TutorialStepCompleted"];
        [_pickerData addObject:@"TutorialSkipped"];
        [_pickerData addObject:@"Login"];
        [_pickerData addObject:@"Logout"];
        [_pickerData addObject:@"UserRegistered"];
        [_pickerData addObject:@"SearchResultViewed"];
        [_pickerData addObject:@"KeywordSearched"];
        [_pickerData addObject:@"LocationSearched"];
        [_pickerData addObject:@"Invite"];
        [_pickerData addObject:@"Share"];
        [_pickerData addObject:@"Like"];
        [_pickerData addObject:@"Comment"];
        [_pickerData addObject:@"MediaCaptured"];
        [_pickerData addObject:@"MediaStarted"];
        [_pickerData addObject:@"MediaStopped"];
        [_pickerData addObject:@"MediaPaused"];
        [_pickerData addObject:@"PrivacyPromptDisplayed"];
        [_pickerData addObject:@"PrivacyOptIn"];
        [_pickerData addObject:@"PrivacyOptOut"];

    }
    return _pickerData;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([segue.identifier isEqualToString:@"standardEventVC"]){
        StandardEventTableViewController *vc = (StandardEventTableViewController *)segue.destinationViewController;
        vc.eventEnum = self.pickerIndex;
    }
}


@end
