//
//  FaceSelectViewController.m
//  chat
//
//  Created by 小寺 貴士 on 2012/10/22.
//  Copyright (c) 2012年 小寺 貴士. All rights reserved.
//

#import "FaceSelectViewController.h"
#import "FaceViewController.h"
#import "manViewController.h"

@interface FaceSelectViewController ()

@end

@implementation FaceSelectViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
