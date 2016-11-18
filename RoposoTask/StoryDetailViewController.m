//
//  StoryDetailViewController.m
//  RoposoTask
//
//  Created by Apple on 17/11/16.
//  Copyright © 2016 V group Inc. All rights reserved.
//

#import "StoryDetailViewController.h"

@interface StoryDetailViewController ()

@end

@implementation StoryDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.descriptionView scrollRangeToVisible:NSMakeRange(0, 0)];
    [self configureData];
    [self setImage];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)configureData
{
    self.title = [_storyData valueForKey:@"title"];
    self.descriptionView.text = [_storyData valueForKey:@"description"];
    
    NSString *label = @"Follow";
    
    if ([[self.storyData valueForKey:@"like_flag"] boolValue]) {
        label = @"Following";
    }
    label = [label stringByAppendingString:[NSString stringWithFormat:@" %@",self.user]];
    
    [self.followAuthor setTitle:label forState:UIControlStateNormal];
}

-(void)setImage
{
    NSString *imageURL = [_storyData valueForKey:@"si"];
    self.imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageURL]]];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)followAuthorAction:(id)sender {
    
    NSMutableDictionary *dict = [NSMutableDictionary new];
    [dict setValue:[_storyData valueForKey:@"db"] forKey:@"id"];
    
    NSString *title = @"";
    
    if (![[_storyData valueForKey:@"like_flag"] boolValue]) {
        
        [_storyData setValue:[NSNumber numberWithBool:YES] forKey:@"like_flag"];
            [dict setValue:@"true" forKey:@"Follow"];
            title = @"Following";
        
        }else
        {
            [_storyData setValue:[NSNumber numberWithBool:NO] forKey:@"like_flag"];
            [dict setValue:@"false" forKey:@"Follow"];
            title = @"Follow";
        }
    
     title = [title stringByAppendingString:[NSString stringWithFormat:@" %@",self.user]];
    
    [self.followAuthor setTitle:title forState:UIControlStateNormal];
    
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"updateJson"
     object:dict];
    
    
    
}
@end
