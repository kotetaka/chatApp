//
//  FaceViewController.m
//  chat
//
//  Created by 小寺 貴士 on 2012/10/13.
//  Copyright (c) 2012年 小寺 貴士. All rights reserved.
//

#import "FaceWomanViewController.h"
#import "FaceViewController.h"
#import "rootViewController.h"
#import "chatTableCell.h"

@interface FaceWomanViewController ()

@end

@implementation FaceWomanViewController
//@synthesize Scroll;
@synthesize face0;
@synthesize face1;
@synthesize face2;
@synthesize face3;
@synthesize face4;
@synthesize face5;
@synthesize face6;
@synthesize face7;
@synthesize face8;
@synthesize face9;
@synthesize face10;
@synthesize face11;

@synthesize ImageSelectdelegate_;
UIImage* womanImage;
UIButton* kaomoji;
//✖ボタン
-(IBAction)modal:(id)sender {
}

//顔選択ボタン
-(IBAction)FaceSelectButton:(UIButton *)sender{
    [ImageSelectdelegate_ selectImage:sender.tag];
    
}

+ (UIImage*)getImage:(int)num {
    if(num<WOMAN){
        return [FaceViewController getImage:num];
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
            womanImage = [UIImage imageNamed:@"kyouhu.png"];
	        break;
            
        case FACE18:
            womanImage = [UIImage imageNamed:@"odoroki.png"];
            break;
            
        case FACE19:
            womanImage = [UIImage imageNamed:@"huyukai.png"];
            break;
            
        case FACE20:
            womanImage = [UIImage imageNamed:@"ikari.png"];
	        break;
        case FACE21:
            womanImage = [UIImage imageNamed:@"zaiakukan.png"];
            break;
            
        case FACE22:
            womanImage = [UIImage imageNamed:@"yuutu.png"];
            break;
            
        case FACE23:
            womanImage = [UIImage imageNamed:@"kanasimi.png"];
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
    face6 = nil;
    face7 = nil;
    face8 = nil;
    face9 = nil;
    face10 = nil;
    face11 = nil;
    
    self.ImageSelectdelegate_ = nil;
    
    //ナビゲーションバーを隠す
    
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}





@end
