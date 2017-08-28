//
//  ChatViewController.m
//  iOSTest
//
//  Created by App Partner on 9/6/16.
//  Copyright © 2016 AppPartner. All rights reserved.
//

#import "ChatViewController.h"
#import "MenuViewController.h"
#import "ChatTableViewCell.h"
#import "ChatClient.h"
#import "Message.h"
#import "AppDelegate.h"

#define jsonQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
#define TABLE_CELL_HEIGHT 62.0f

@interface ChatViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *chatTable;
@property (nonatomic, strong) ChatClient *client;
@property (nonatomic, strong) NSMutableArray *messages;

@end

@implementation ChatViewController

/**
 * =========================================================================================
 * INSTRUCTIONS
 * =========================================================================================
 * 1) Make the UI look like it does in the mock-up.
 *
 * 2) Using the following endpoint, fetch chat data
 *    URL: http://dev3.apppartner.com/AppPartnerDeveloperTest/scripts/chat_log.php
 *
 * 3) Parse the chat data using 'Message' model
 *
 **/


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.messages = [[NSMutableArray alloc] init];
    [self parseChatData];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self configureTable:self.chatTable];
    self.title = @"Chat";
    [self.chatTable reloadData];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self animateTable];
}


#pragma mark - parseChatData

- (void)parseChatData
{
    dispatch_async(jsonQueue, ^{
        
        NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfig delegate:nil delegateQueue:nil];
        
        NSString *urlString = [NSString stringWithFormat: @"http://dev3.apppartner.com/AppPartnerDeveloperTest/scripts/chat_log.php"];
        NSURL *url = [NSURL URLWithString: urlString];
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        request.HTTPMethod = @"GET";
        
        
        NSURLSessionDataTask* task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            
            if (error == nil) {
                
                NSDictionary *responseBody = [NSJSONSerialization JSONObjectWithData: data options: 0 error: nil];
                [self.messages removeAllObjects];
                
                if ([responseBody isKindOfClass:[NSDictionary class]])
                {
                    NSDictionary *jsonDict = (NSDictionary *)responseBody;
                    NSArray *loadedArray = [jsonDict objectForKey:@"data"];
                    
                    if ([loadedArray isKindOfClass:[NSArray class]])
                    {
                        for (NSDictionary *responseBody in loadedArray)
                        {
                            Message *chatData = [[Message alloc] init];
                            id MessageObjectAllocation = [chatData initWithDictionary:responseBody];
                            [self.messages addObject:chatData];
                            dispatch_async(dispatch_get_main_queue(), ^{
                                [self.chatTable reloadData];
                            });
                        }
                    }
                };
                
            } else {
                NSLog(@"URL Session Task Failed: %@", [error localizedDescription]);
            }
        }];
        
        [task resume];
        
    });
}


#pragma mark - ConfigureTable

- (void)configureTable:(UITableView *)tableView
{
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView registerNib:[UINib nibWithNibName:@"ChatTableViewCell" bundle:nil] forCellReuseIdentifier:@"ChatTableViewCell"];
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}


#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChatTableViewCell *cell = nil;
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ChatTableViewCell" owner:self options:nil];
        cell = (ChatTableViewCell *)[nib objectAtIndex:0];
    }
    [cell setCellData:self.messages[indexPath.row]];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.messages.count;
}


#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Message *chatData = [self.messages objectAtIndex:[indexPath row]];
    NSString *textMessage = chatData.text;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    
    CGRect textMsgRect = [textMessage boundingRectWithSize:CGSizeMake(self.chatTable.frame.size.width-94.0f, 1000.0f)
                                                   options:NSStringDrawingUsesLineFragmentOrigin
                                                attributes:@{NSParagraphStyleAttributeName: paragraphStyle.copy}
                                                   context:nil];
    
    return TABLE_CELL_HEIGHT+textMsgRect.size.height;
}


#pragma mark - IBAction

- (IBAction)backAction:(id)sender
{
    MenuViewController *mainMenuViewController = [[MenuViewController alloc] init];
    [self.navigationController pushViewController:mainMenuViewController animated:YES];
}

#pragma mark - Table Animation

- (void)animateTable
{
    [self.chatTable reloadData];
    NSArray *cells = [self.chatTable visibleCells];
    int tableViewHeight = self.chatTable.bounds.size.height;
    
    for (UITableViewCell *cell in cells) {
        cell.transform = CGAffineTransformMakeTranslation(0, tableViewHeight);
    }
    
    double delayCounter = 0;
    for (UITableViewCell *cell in cells) {
        [UIView animateWithDuration:1.00
        delay:delayCounter
        usingSpringWithDamping:0.8
        initialSpringVelocity:0
        options: UIViewAnimationOptionCurveEaseInOut
        animations:^{
            cell.transform = CGAffineTransformIdentity;
        }
        completion:nil];

        delayCounter += 0.5;
    }
}

@end
