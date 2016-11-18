//
//  StroyViewController.m
//  RoposoTask
//
//  Created by Apple on 17/11/16.
//  Copyright © 2016 V group Inc. All rights reserved.
//

#import "StroyViewController.h"
#import "StoryDetailViewController.h"
#import "AppDelegate.h"


@interface StroyViewController ()

@property(nonatomic,strong)NSMutableArray *stories;

@property (nonatomic, strong) NSMutableArray *users;

@end

@implementation StroyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Story";
    [self.tableView registerClass:[UITableViewCell
                                    class]forCellReuseIdentifier:@"StoryCell" ];
    // Do any additional setup after loading the view.
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"iOS%2FAndroidData" ofType:@"json"];
    NSData *content = [[NSData alloc] initWithContentsOfFile:filePath];
    NSArray* jsonData = [NSJSONSerialization JSONObjectWithData:content options:kNilOptions error:nil];
    
    self.users = [[jsonData objectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, 2)]] mutableCopy];
    
    self.stories = [[jsonData objectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(2, jsonData.count-2)]]mutableCopy];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveNotification:)
                                                 name:@"updateJson"
                                               object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) receiveNotification:(NSNotification *) notification
{
    // [notification name] should always be @"TestNotification"
    // unless you use this method for observation of other notifications
    // as well.
    NSDictionary *updatedDta = notification.object;
    NSString *follo  = [updatedDta valueForKey:@"Follow"];
    NSString *userId = [updatedDta valueForKey:@"id"];
    
    NSInteger count = self.stories.count;
    
    for (int i = 0; i < count; i++) {
            NSMutableDictionary *dict = [[self.stories objectAtIndex:i] mutableCopy];
            if ([userId isEqualToString:[dict valueForKey:@"db"]]) {
                if ([follo isEqualToString:@"true"]) {
                    [dict setValue:[NSNumber numberWithBool:YES] forKey:@"like_flag"];
                }else{
                    [dict setValue:[NSNumber numberWithBool:NO] forKey:@"like_flag"];
                }
                [self.stories replaceObjectAtIndex:i withObject:dict];
            }
        }

    }
    


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.stories.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"StoryCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    NSDictionary *dict = [self.stories objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [dict valueForKey:@"title"];
    
    return  cell;

   
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dict = [self.stories objectAtIndex:indexPath.row];
    
    NSString *uID = [dict valueForKey:@"db"];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"id == %@",uID];
    NSArray *obj = [self.users filteredArrayUsingPredicate:predicate];
    NSDictionary *info = [obj firstObject];
    
    StoryDetailViewController *controller = [[StoryDetailViewController alloc] initWithNibName:@"StoryDetailViewController" bundle:nil];
    controller.storyData = [[self.stories objectAtIndex:indexPath.row] mutableCopy];
    controller.user = [info valueForKey:@"username"];
    
    [self.navigationController pushViewController:controller animated:YES];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
