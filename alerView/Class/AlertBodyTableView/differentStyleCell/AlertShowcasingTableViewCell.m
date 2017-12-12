//
//  AlertShowcasingTableViewCell.m
//  alerView
//
//  Created by xia on 2017/11/23.
//  Copyright © 2017年 xia. All rights reserved.
//

#import "AlertShowcasingTableViewCell.h"
#import <Masonry.h>

@interface AlertShowcasingTableViewCell()
@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) UILabel *valueLabel;
@end

@implementation AlertShowcasingTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createSubViews];
    }
    return self;
}

- (void)createSubViews {
    CGFloat widthTitle = (CGRectGetWidth(self.frame)-28)*0.4;
    _titleLabel = [[UILabel alloc] init];
    _valueLabel = [[UILabel alloc] init];
    [self addSubview:_titleLabel];
    [self addSubview:_valueLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(10);
        make.top.bottom.mas_equalTo(self);
        make.width.mas_equalTo(widthTitle);
    }];
    [_valueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_titleLabel.mas_right).offset(8);
        make.top.bottom.mas_equalTo(self);
        make.right.mas_equalTo(self).offset(-10);
    }];
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    _valueLabel.textAlignment = NSTextAlignmentLeft;
}

- (void)updateLeftLabelColor:(UIColor *)colorL
             rightLabelColor: (UIColor *)colorR
              textAlignmentL:(NSTextAlignment)alignmentL
              textAlignmentR:(NSTextAlignment)alignmentR
                   labelFont:(UIFont *)font
{
    _titleLabel.font = font;
    _valueLabel.font = font;
    
    _titleLabel.textAlignment = alignmentL;
    _valueLabel.textAlignment = alignmentR;
    
    _titleLabel.textColor = colorL;
    _valueLabel.textColor = colorR;
}

- (void)updateWithLabelContentWithTitleStr: (NSString *)titleString ValueStr:(NSString *)valueString {
    _titleLabel.text = titleString;
    _valueLabel.text = valueString;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
