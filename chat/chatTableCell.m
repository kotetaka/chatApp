//
//  manTableCell.m
//  chat
//
//  Created by 小寺 貴士 on 2012/10/01.
//  Copyright (c) 2012年 小寺 貴士. All rights reserved.
//

#import "chatTableCell.h"
#import "rootViewController.h"

@implementation chatTableCell

@synthesize womanImage;
@synthesize womanLabel;
@synthesize huki;
@synthesize huki2;



- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


@end
