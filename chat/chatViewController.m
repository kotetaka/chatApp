//
//  chatViewController.m
//  chat
//
//  Created by 小寺 貴士 on 2012/09/09.
//  Copyright (c) 2012年 小寺 貴士. All rights reserved.
//

#import "chatViewController.h"

@interface chatViewController ()

@end

@implementation chatViewController
@synthesize mylabel;
@synthesize man;
@synthesize woman;
@synthesize manButton;
@synthesize womanButton;


- (void)viewDidLoad
{
    
      [super viewDidLoad];
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    mylabel.text= @"性別を選んでください";
    mylabel.textAlignment=NSTextAlignmentCenter;
    UIImage *bgvImage = [UIImage imageNamed:@"underPageBackground.png"];
    self.view.backgroundColor = [UIColor colorWithPatternImage: bgvImage];
       //button.frame = CGRectMake(10.0f, 180.0f, 180.0f, 40.0f);
    //[button setTitle:[NSString stringWithUTF8String:"111 番のボタン"] forState:UIControlStateNormal]
    // Do any additional setup after loading the view, typically from a nib.
   }

- (void)viewDidUnload
{
    [self setMan:nil];
    [self setWoman:nil];
    [self setMylabel:nil];
    [self setManButton:nil];
    [self setWomanButton:nil];
   
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
