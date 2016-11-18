//
//  StoryDetailViewController.h
//  RoposoTask
//
//  Created by Apple on 17/11/16.
//  Copyright © 2016 V group Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StoryDetailViewController : UIViewController

@property (strong, nonatomic) NSString *user;

@property (weak, nonatomic) IBOutlet UITextView *descriptionView;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UIButton *followAuthor;


- (IBAction)followAuthorAction:(id)sender;

@property(strong,nonatomic)NSMutableDictionary *storyData;


@end
