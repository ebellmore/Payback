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
        // Initialization code
//        CGRect nameLabelRect = CGRectMake(0, 5, 70, 15);
//        UILabel *nameMarker = [[UILabel alloc] initWithFrame:nameLabelRect];
//        nameMarker.textAlignment = NSTextAlignmentRight;
//        nameMarker.text = @"Name:";
//        nameMarker.font = [UIFont boldSystemFontOfSize:12];
//        [self.contentView addSubview:nameMarker];
//        
//        CGRect colorLabelRect = CGRectMake(0, 26, 70, 15);
//        UILabel *colorMarker = [[UILabel alloc] initWithFrame:colorLabelRect];
//        colorMarker.textAlignment = NSTextAlignmentRight;
//        colorMarker.text = @"Color:";
//        colorMarker.font = [UIFont boldSystemFontOfSize:12];
//        [self.contentView addSubview:colorMarker];
        
        CGRect nameValueRect = CGRectMake(80, 5, 200, 15);
        _nameLabel = [[UILabel alloc] initWithFrame:
                      nameValueRect];
        [self.contentView addSubview:_nameLabel];
        
        CGRect colorValueRect = CGRectMake(80, 25, 200, 15);
        _amountLabel = [[UILabel alloc] initWithFrame:
                       colorValueRect];
        [self.contentView addSubview:_amountLabel];
    }
    return self;
}


- (void)setName:(NSString *)n
{
    if (![n isEqualToString:_name]) {
        _name = [n copy];
        self.nameLabel.text = _name;
    } }
- (void)setColor:(NSString *)c
{
    if (![c isEqualToString:_amount]) {
        _amount = [c copy];
        self.amountLabel.text = _amount;
    } }


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
