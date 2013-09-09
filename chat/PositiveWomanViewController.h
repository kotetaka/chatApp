//
//  FaceViewController.h
//  chat
//
//  Created by 小寺 貴士 on 2012/10/13.
//  Copyright (c) 2012年 小寺 貴士. All rights reserved.
//

#define WOMAN    7
#define FACE12   8
#define FACE13   9
#define FACE14   10
#define FACE15  11
#define FACE16   12
#define FACE17   13
#import <UIKit/UIKit.h>
@protocol ImageSelectDelegate;

@interface PositiveWomanViewController : UIViewController<UIScrollViewDelegate>{
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




- (IBAction)modal:(id)sender;
+ (UIImage*)getImage:(int)num;
//- (IBAction)changePage:(id)sender;
-(IBAction)FaceSelectButton:(UIButton *)sender;

@end
