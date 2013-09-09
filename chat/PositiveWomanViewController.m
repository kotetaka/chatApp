//
//  PositiveViewController.m
//  chat
//
//  Created by 小寺 貴士 on 2012/10/13.
//  Copyright (c) 2012年 小寺 貴士. All rights reserved.
//
#import "PositiveWomanViewController.h"
#import "WomanViewController.h"
#import "manTableCell.h"
#import "PositiveViewController.h"

@interface PositiveWomanViewController ()

@end

@implementation PositiveWomanViewController
//@synthesize Scroll;
@synthesize face0;
@synthesize face1;
@synthesize face2;
@synthesize face3;
@synthesize face4;
@synthesize face5;


@synthesize ImageSelectdelegate_;
UIImage* womanImage;
UIButton* kaomoji;
//✖ボタン
-(IBAction)modal:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}

//顔選択ボタン
-(IBAction)FaceSelectButton:(UIButton *)sender{
    [ImageSelectdelegate_ selectImage:sender.tag];
    [self dismissModalViewControllerAnimated:YES];
    
}

+ (UIImage*)getImage:(int)num {
    if(num<WOMAN){
        return [PositiveViewController getImage:num];
    }
    else{
        switch(num){
            case WOMAN:
                womanImage = [UIImage imageNamed:@"woman.png"];
                break;
                
            case FACE12:
                womanImage = [UIImage imageNamed:@"happywoman.png"];
                break;
                
            case FACE13:
                womanImage = [UIImage imageNamed:@"ansin.png"];
                break;
                
            case FACE14:
                womanImage = [UIImage imageNamed:@"manzoku.png"];
                break;
                
            case FACE15:
                womanImage = [UIImage imageNamed:@"rirakkusu.png"];
                break;
                
            case FACE16:
                womanImage = [UIImage imageNamed:@"kouhun.png"];
                break;
                
                
            case FACE17:
                womanImage = [UIImage imageNamed:@"odoroki.png"];
                break;
    
        }
        return womanImage;
    }
    
}

- (void)loadView {
    [super loadView];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
}

- (void)viewDidUnload
{
    //FaceControll = nil;
    //Scroll = nil;
    //[self setScroll:nil];
    //[self setFaceControll:nil];
    
    [super viewDidUnload];
    face0 = nil;
    face1 = nil;
    face2 = nil;
    face3 = nil;
    face4 = nil;
    face5 = nil;

    
    self.ImageSelectdelegate_ = nil;
    
    //ナビゲーションバーを隠す
    
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}





@end
