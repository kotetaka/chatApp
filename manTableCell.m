//
//  manTableCell.m
//  chat
//
//  Created by 小寺 貴士 on 2012/10/01.
//  Copyright (c) 2012年 小寺 貴士. All rights reserved.
//

#import "manTableCell.h"
#import "manViewController.h"

@implementation manTableCell

@synthesize manImage;
@synthesize parLabel;
@synthesize ManLabel;
@synthesize enter;
@synthesize retire;
@synthesize yuza;


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
