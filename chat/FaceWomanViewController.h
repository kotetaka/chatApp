//
//  FaceViewController.h
//  chat
//
//  Created by 小寺 貴士 on 2012/10/13.
//  Copyright (c) 2012年 小寺 貴士. All rights reserved.
//

#define WOMAN  13
#define FACE12   14
#define FACE13   15
#define FACE14   16
#define FACE15  17
#define FACE16   18
#define FACE17   19
#define FACE18   20
#define FACE19   21
#define FACE20   22
#define FACE21   23
#define FACE22  24
#define FACE23  25
#import <UIKit/UIKit.h>
@protocol ImageSelectDelegate;

@interface FaceWomanViewController : UIViewController<UIScrollViewDelegate>{
    //id<ImageSelectDelegate> ImageSelectdelegate_;
    UIButton *Face0;
    UIButton *Face1;
    UIButton *Face2;
    UIButton *Face3;
    
    // IBOutlet UIScrollView *Scroll;
    // IBOutlet UIPageControl *FaceControll;
}


@property (nonatomic, assign) id<ImageSelectDelegate> ImageSelectdelegate_;



@property (nonatomic, retain) IBOutlet UIButton *face0;
@property (nonatomic, retain) IBOutlet UIButton *face1;
@property (nonatomic, retain) IBOutlet UIButton *face2;
@property (nonatomic, retain) IBOutlet UIButton *face3;
@property (nonatomic, retain) IBOutlet UIButton *face4;
@property (nonatomic, retain) IBOutlet UIButton *face5;
@property (nonatomic, retain) IBOutlet UIButton *face6;
@property (nonatomic, retain) IBOutlet UIButton *face7;
@property (nonatomic, retain) IBOutlet UIButton *face8;
@property (nonatomic, retain) IBOutlet UIButton *face9;
@property (nonatomic, retain) IBOutlet UIButton *face10;
@property (nonatomic, retain) IBOutlet UIButton *face11;





- (IBAction)modal:(id)sender;
+ (UIImage*)getImage:(int)num;
//- (IBAction)changePage:(id)sender;
-(IBAction)FaceSelectButton:(UIButton *)sender;

@end
