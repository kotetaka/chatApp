//
//  chatViewController.h
//  chat
//
//  Created by 小寺 貴士 on 2012/09/09.
//  Copyright (c) 2012年 小寺 貴士. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface chatViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *mylabel;
@property (weak, nonatomic) IBOutlet UIImageView *man;
@property (weak, nonatomic) IBOutlet UIImageView *woman;
@property (weak, nonatomic) IBOutlet UIButton *manButton;
@property (weak, nonatomic) IBOutlet UIButton *womanButton;


@end
