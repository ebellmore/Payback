//
//  CustomTableViewCell.m
//  Payback
//
//  Created by Evan Backup on 11/3/14.
//  Copyright (c) 2014 Evan Bellmore. All rights reserved.
//

#import "CustomTableViewCell.h"

@interface CustomTableViewCell ()

@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UILabel *amountLabel;

@end


@implementation CustomTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self commonInit];
    }
    return self;
}

-(void) commonInit
{
    CGRect nameValueRect = CGRectMake(80, 5, 200, 15);
    _nameLabel = [[UILabel alloc] initWithFrame:
                  nameValueRect];
    [self.contentView addSubview:_nameLabel];
    
    CGRect colorValueRect = CGRectMake(80, 25, 200, 15);
    _amountLabel = [[UILabel alloc] initWithFrame:
                    colorValueRect];
    _amountLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_amountLabel];
}

-(void) layoutSubviews
{
    [super layoutSubviews];
    _nameLabel.frame = CGRectMake(0, 0, self.contentView.frame.size.width - 140, self.contentView.frame.size.height);
    _amountLabel.frame = CGRectMake(self.contentView.frame.size.width - 120, 0, 100, self.contentView.frame.size.height);
}

- (void)setName:(NSString *)n
{
    if (![n isEqualToString:_name]) {
        _name = [n copy];
        self.nameLabel.text = _name;
    }
}

-(void) setAmount:(double)amount
{
    _amount = amount;
    self.amountLabel.text = [NSString stringWithFormat:@"$%.2f", _amount];
}


@end
