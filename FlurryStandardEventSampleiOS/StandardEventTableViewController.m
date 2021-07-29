//
//  StandardEventTableViewController.m
//  FlurryStandardEventSampleiOS
//
//  Created by Hantao Yang on 7/28/21.
//

#import "StandardEventTableViewController.h"
@import Flurry_iOS_SDK;

@interface UIViewController (Alerts)

- (void)displayAlertWithTitle:(NSString *)title
                      message:(NSString *)message
                 dismissAfter:(double)seconds;

@end

static int maxCount = 10;

@interface StandardEventTableViewController ()

@property (weak, nonatomic) IBOutlet UITextField *textFieldAddParamKey;
@property (weak, nonatomic) IBOutlet UITextField *textFieldAddParamValue;
@property (weak, nonatomic) IBOutlet UITextField *textFieldDeleteParamKey;

@property (weak, nonatomic) IBOutlet UILabel *eventBuilderLabel;

@property (nonatomic, nonatomic) FlurryParamBuilder *builder;

@property (nonatomic, strong) NSDictionary *suggestedFlurryParameter;

@property (nonatomic, strong) NSArray *suggestedParams;

@end

@implementation StandardEventTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.builder = [[FlurryParamBuilder alloc] init];
    
    _suggestedFlurryParameter = @{
        @(FLURRY_EVENT_AD_CLICK)  : @[[FlurryParamBuilder adType]],
        @(FLURRY_EVENT_AD_IMPRESSION)  : @[[FlurryParamBuilder adType]],
        @(FLURRY_EVENT_AD_REWARDED)  : @[[FlurryParamBuilder adType]],
        @(FLURRY_EVENT_AD_SKIPPED)  : @[[FlurryParamBuilder adType]],
        @(FLURRY_EVENT_CREDITS_SPENT)  : @[[FlurryParamBuilder levelNumber], [FlurryParamBuilder totalAmount], [FlurryParamBuilder isCurrencySoft], [FlurryParamBuilder creditType], [FlurryParamBuilder creditId], [FlurryParamBuilder creditName], [FlurryParamBuilder currencyType]],
        @(FLURRY_EVENT_CREDITS_PURCHASED)  : @[[FlurryParamBuilder levelNumber], [FlurryParamBuilder totalAmount], [FlurryParamBuilder isCurrencySoft], [FlurryParamBuilder creditType], [FlurryParamBuilder creditId], [FlurryParamBuilder creditName], [FlurryParamBuilder currencyType]],
        @(FLURRY_EVENT_CREDITS_EARNED)  : @[[FlurryParamBuilder levelNumber], [FlurryParamBuilder totalAmount], [FlurryParamBuilder isCurrencySoft], [FlurryParamBuilder creditType], [FlurryParamBuilder creditId], [FlurryParamBuilder creditName], [FlurryParamBuilder currencyType]],
        @(FLURRY_EVENT_ACHIEVEMENT_UNLOCKED)  : @[[FlurryParamBuilder achievementId]],
        @(FLURRY_EVENT_LEVEL_COMPLETED)  : @[[FlurryParamBuilder levelNumber], [FlurryParamBuilder levelName]],
        @(FLURRY_EVENT_LEVEL_FAILED)  : @[[FlurryParamBuilder levelNumber], [FlurryParamBuilder levelName]],
        @(FLURRY_EVENT_LEVEL_UP) : @[[FlurryParamBuilder levelNumber], [FlurryParamBuilder levelName]],
        @(FLURRY_EVENT_LEVEL_STARTED) : @[[FlurryParamBuilder levelNumber], [FlurryParamBuilder levelName]],
        @(FLURRY_EVENT_LEVEL_SKIP) : @[[FlurryParamBuilder levelNumber], [FlurryParamBuilder levelName]],
        @(FLURRY_EVENT_SCORE_POSTED) : @[[FlurryParamBuilder levelNumber], [FlurryParamBuilder score]],
        @(FLURRY_EVENT_CONTENT_RATED) : @[[FlurryParamBuilder contentType], [FlurryParamBuilder contentName], [FlurryParamBuilder contentId], [FlurryParamBuilder rating]],
        @(FLURRY_EVENT_CONTENT_VIEWED) : @[[FlurryParamBuilder contentType], [FlurryParamBuilder contentName], [FlurryParamBuilder contentId]],
        @(FLURRY_EVENT_CONTENT_SAVED) : @[[FlurryParamBuilder contentType], [FlurryParamBuilder contentName], [FlurryParamBuilder contentId]],
        @(FLURRY_EVENT_PRODUCT_CUSTOMIZED) : @[],
        @(FLURRY_EVENT_APP_ACTIVATED) : @[],
        @(FLURRY_EVENT_APPLICATION_SUBMITTED) : @[],
        @(FLURRY_EVENT_ADD_ITEM_TO_CART) : @[[FlurryParamBuilder itemCount], [FlurryParamBuilder price], [FlurryParamBuilder itemId], [FlurryParamBuilder itemName], [FlurryParamBuilder itemType]],
        @(FLURRY_EVENT_ADD_ITEM_TO_WISH_LIST) : @[[FlurryParamBuilder itemCount], [FlurryParamBuilder price], [FlurryParamBuilder itemId], [FlurryParamBuilder itemName], [FlurryParamBuilder itemType]],
        @(FLURRY_EVENT_COMPLETED_CHECKOUT) : @[[FlurryParamBuilder itemCount], [FlurryParamBuilder totalAmount], [FlurryParamBuilder currencyType], [FlurryParamBuilder transactionId]],
        @(FLURRY_EVENT_PAYMENT_INFO_ADDED) : @[[FlurryParamBuilder success], [FlurryParamBuilder paymentType]],
        @(FLURRY_EVENT_ITEM_VIEWED) : @[[FlurryParamBuilder itemId], [FlurryParamBuilder itemName], [FlurryParamBuilder itemType], [FlurryParamBuilder price]],
        @(FLURRY_EVENT_ITEM_LIST_VIEWED) : @[[FlurryParamBuilder itemListType]],
        @(FLURRY_EVENT_PURCHASED) : @[[FlurryParamBuilder itemCount], [FlurryParamBuilder totalAmount], [FlurryParamBuilder itemId], [FlurryParamBuilder success], [FlurryParamBuilder itemName], [FlurryParamBuilder itemType], [FlurryParamBuilder currencyType], [FlurryParamBuilder transactionId]],
        @(FLURRY_EVENT_PURCHASE_REFUNDED) : @[[FlurryParamBuilder price], [FlurryParamBuilder currencyType]],
        @(FLURRY_EVENT_REMOVE_ITEM_FROM_CART) : @[[FlurryParamBuilder itemId], [FlurryParamBuilder price], [FlurryParamBuilder itemName], [FlurryParamBuilder itemType]],
        @(FLURRY_EVENT_CHECKOUT_INITIATED) : @[[FlurryParamBuilder itemCount], [FlurryParamBuilder totalAmount]],
        @(FLURRY_EVENT_FUNDS_DONATED) : @[[FlurryParamBuilder price], [FlurryParamBuilder currencyType]],
        @(FLURRY_EVENT_USER_SCHEDULED) : @[],
        @(FLURRY_EVENT_OFFER_PRESENTED) : @[[FlurryParamBuilder itemId], [FlurryParamBuilder itemName], [FlurryParamBuilder itemCategory], [FlurryParamBuilder price]],
        @(FLURRY_EVENT_SUBSCRIPTION_STARTED) : @[[FlurryParamBuilder price], [FlurryParamBuilder isAnnualSubscription], [FlurryParamBuilder trialDays], [FlurryParamBuilder predictedLTV], [FlurryParamBuilder currencyType], [FlurryParamBuilder subscriptionCountry]],
        @(FLURRY_EVENT_SUBSCRIPTION_ENDED) : @[[FlurryParamBuilder isAnnualSubscription], [FlurryParamBuilder currencyType], [FlurryParamBuilder subscriptionCountry]],
        @(FLURRY_EVENT_GROUP_JOINED) : @[[FlurryParamBuilder groupName]],
        @(FLURRY_EVENT_GROUP_LEFT) : @[[FlurryParamBuilder groupName]],
        @(FLURRY_EVENT_TUTORIAL_STARTED) : @[[FlurryParamBuilder tutorialName]],
        @(FLURRY_EVENT_TUTORIAL_COMPLETED) : @[[FlurryParamBuilder tutorialName]],
        @(FLURRY_EVENT_TUTORIAL_STEP_COMPLETED) : @[[FlurryParamBuilder stepNumber], [FlurryParamBuilder tutorialName]],
        @(FLURRY_EVENT_TUTORIAL_SKIPPED) : @[[FlurryParamBuilder stepNumber], [FlurryParamBuilder tutorialName]],
        @(FLURRY_EVENT_LOGIN) : @[[FlurryParamBuilder userId], [FlurryParamBuilder method]],
        @(FLURRY_EVENT_LOGOUT) : @[[FlurryParamBuilder userId], [FlurryParamBuilder method]],
        @(FLURRY_EVENT_USER_REGISTERED) : @[[FlurryParamBuilder userId], [FlurryParamBuilder method]],
        @(FLURRY_EVENT_SEARCH_RESULT_VIEWED) : @[[FlurryParamBuilder query], [FlurryParamBuilder searchType]],
        @(FLURRY_EVENT_KEYWORD_SEARCHED) : @[[FlurryParamBuilder query], [FlurryParamBuilder searchType]],
        @(FLURRY_EVENT_LOCATION_SEARCHED) : @[[FlurryParamBuilder query]],
        @(FLURRY_EVENT_INVITE) : @[[FlurryParamBuilder userId], [FlurryParamBuilder method]],
        @(FLURRY_EVENT_SHARE) : @[[FlurryParamBuilder socialContentId], [FlurryParamBuilder socialContentName], [FlurryParamBuilder method]],
        @(FLURRY_EVENT_LIKE) : @[[FlurryParamBuilder socialContentId], [FlurryParamBuilder socialContentName], [FlurryParamBuilder likeType]],
        @(FLURRY_EVENT_COMMENT) : @[[FlurryParamBuilder socialContentId], [FlurryParamBuilder socialContentName]],
        @(FLURRY_EVENT_MEDIA_CAPTURED) : @[[FlurryParamBuilder mediaId], [FlurryParamBuilder mediaName], [FlurryParamBuilder mediaType]],
        @(FLURRY_EVENT_MEDIA_STARTED) : @[[FlurryParamBuilder mediaId], [FlurryParamBuilder mediaName], [FlurryParamBuilder mediaType]],
        @(FLURRY_EVENT_MEDIA_STOPPED) : @[[FlurryParamBuilder mediaId], [FlurryParamBuilder duration], [FlurryParamBuilder mediaName], [FlurryParamBuilder mediaType]],
        @(FLURRY_EVENT_MEDIA_PAUSED) : @[[FlurryParamBuilder mediaId], [FlurryParamBuilder duration], [FlurryParamBuilder mediaName], [FlurryParamBuilder mediaType]],
        @(FLURRY_EVENT_PRIVACY_PROMPT_DISPLAYED) : @[],
        @(FLURRY_EVENT_PRIVACY_OPT_IN) : @[],
        @(FLURRY_EVENT_PRIVACY_OPT_OUT) : @[]
    };
    
    _suggestedParams = _suggestedFlurryParameter[@(self.eventEnum)];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section == 0){
        return 4;
    }
    if(section == 1){
        return 3;
    }
    if(section == 2){
        return 2;
    }
    return 0;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    // common operation
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self resignActive];

    
    if(indexPath.section == 0 && indexPath.row == 2){
        // if add parameter
        if(self.textFieldAddParamKey.text != nil && self.textFieldAddParamKey.text.length > 0 && self.textFieldAddParamValue.text != nil && self.textFieldAddParamValue.text.length > 0){
            NSString *key = self.textFieldAddParamKey.text;
            NSString *val = self.textFieldAddParamValue.text;
            if(!self.builder.parameters[key] && self.builder.parameters.count == maxCount){
                [self displayAlertWithTitle:@"Max event parameter count logged"message:nil dismissAfter:0.8];
                return;
            }
            [self.builder setString:val forKey:key];
            self.textFieldAddParamKey.text = @"";
            self.textFieldAddParamValue.text = @"";
            
            NSString *str = [self getParameterString];
            self.eventBuilderLabel.text = str;
            [self displayAlertWithTitle:@"Parameter Added"message:nil dismissAfter:0.8];
            
        }else{
            [self displayAlertWithTitle:@"Please enter a valid key-value pair"message:nil dismissAfter:0.8];
        }
    }
    else if (indexPath.section == 0 && indexPath.row == 3){
        // if add all recommended parameters
        for(FlurryParam *key in _suggestedParams){
            if([key isKindOfClass:[FlurryStringParam class]]){
                [self.builder setString:@"DEMO STRING" forParam:(FlurryStringParam *)key];
            }
            else if([key isKindOfClass:[FlurryIntegerParam class]]){
                [self.builder setInteger:1 forParam:(FlurryIntegerParam *)key];
            }
            else if([key isKindOfClass:[FlurryDoubleParam class]]){
                [self.builder setDouble:1.23 forParam:(FlurryDoubleParam *)key];
            }
            else if([key isKindOfClass:[FlurryBooleanParam class]]){
                [self.builder setBoolean:YES forParam:(FlurryBooleanParam *)key];
            }
            else if([key isKindOfClass:[FlurryLongParam class]]){
                [self.builder setLong:1 forParam:(FlurryLongParam *)key];
            }
        }
        NSString *str = [self getParameterString];
        self.eventBuilderLabel.text = str;
        [self displayAlertWithTitle:@"Parameter Added"message:nil dismissAfter:0.8];
    }
    else if(indexPath.section == 1 && indexPath.row == 1){
        // if delete parameter
        if(self.textFieldDeleteParamKey.text != nil && self.textFieldDeleteParamKey.text.length > 0 ){
            NSString *key = self.textFieldDeleteParamKey.text;
            [self.builder removeObjectForKey:key];
            self.textFieldDeleteParamKey.text = @"";
            NSString *str = [self getParameterString];
            self.eventBuilderLabel.text = str;
            [self displayAlertWithTitle:@"Parameter deleted"message:nil dismissAfter:0.8];
        }else{
            [self displayAlertWithTitle:@"Please enter a valid key"message:nil dismissAfter:0.8];
        }
    }
    else if(indexPath.section == 1 && indexPath.row == 2){
        // if delete all recommended parameters
        for(FlurryParam *key in _suggestedParams){
            [self.builder removeObjectForKey:key];
        }
        NSString *str = [self getParameterString];
        self.eventBuilderLabel.text = str;
        [self displayAlertWithTitle:@"Parameter deleted"message:nil dismissAfter:0.8];
    }
    else if(indexPath.section == 2 && indexPath.row == 1){
        // if log event
        [Flurry logStandardEvent:((FlurryEvent)self.eventEnum) withParameters:self.builder];
        [self displayAlertWithTitle:@"Event logged"message:nil dismissAfter:0.8];
    }
}

- (void)resignActive{
    [self.textFieldAddParamKey resignFirstResponder];
    [self.textFieldAddParamValue resignFirstResponder];
    [self.textFieldDeleteParamKey resignFirstResponder];
}

#pragma mark - JSON - String formatter
- (NSString *)getParameterString{
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization
                        dataWithJSONObject:self.builder.parameters
                        options:NSJSONWritingPrettyPrinted
                        error:&error];

     if (!jsonData) {
        NSLog(@"%s: error: %@", __func__, error.localizedDescription);
         return @"{}";
     } else {
        return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
     }
}

@end

#pragma mark - Alert VC Helper

@implementation UIViewController (Alerts)

- (void)displayAlertWithTitle:(NSString *)title message:(NSString *)message dismissAfter:(double)seconds {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertControllerStyle style = self.traitCollection.userInterfaceIdiom == UIUserInterfaceIdiomPad
                ? UIAlertControllerStyleAlert
                : UIAlertControllerStyleActionSheet;
        UIAlertController *controller = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:style];
        if (seconds <= 0) {
            [controller addAction:[UIAlertAction actionWithTitle:@"Dismiss" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [controller dismissViewControllerAnimated:YES completion:nil];
            }]];
        }
        
        [self presentViewController:controller animated:YES completion:^{
            if (seconds > 0) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(seconds * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [controller dismissViewControllerAnimated:YES completion:nil];
                });
            }
        }];
    });
}

@end
