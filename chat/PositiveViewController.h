//
//  FaceViewController.h
//  chat
//
//  Created by 小寺 貴士 on 2012/10/13.
//  Copyright (c) 2012年 小寺 貴士. All rights reserved.
//
#define NORMAL  0
#define FACE0   1
#define FACE1   2
#define FACE2   3
#define FACE3   4
#define FACE4   5
#define FACE5   6

#import <UIKit/UIKit.h>
@protocol ImageSelectDelegate;

@interface PositiveViewController : UIViewController<UIScrollViewDelegate>{
    //id<ImageSelectDelegate> ImageSelectdelegate_;
    
    // IBOutlet UIScrollView *Scroll;
    // IBOutlet UIPageControl *FaceControll;
}

//@property (strong, nonatomic) IBOutlet UIScrollView *Scroll;
//@property (strong, nonatomic) IBOutlet UIPageControl *FaceControll;
//@property (nonatomic, retain) UIButton *Buttons;

@property (nonatomic, assign) id<ImageSelectDelegate> ImageSelectdelegate_;
@property (nonatomic, retain) IBOutlet UIButton *face0;
@property (nonatomic, retain) IBOutlet UIButton *face1;
@property (nonatomic, retain) IBOutlet UIButton *face2;
@property (nonatomic, retain) IBOutlet UIButton *face3;
@property (nonatomic, retain) IBOutlet UIButton *face4;
@property (nonatomic, retain) IBOutlet UIButton *face5;






- (IBAction)modal:(id)sender;
+ (UIImage*)getImage:(int)num;
//- (IBAction)changePage:(id)sender;
-(IBAction)FaceSelectButton:(UIButton *)sender;

@end
