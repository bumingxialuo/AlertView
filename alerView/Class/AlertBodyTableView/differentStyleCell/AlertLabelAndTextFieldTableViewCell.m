//
//  AlertLabelAndTextFieldTableViewCell.m
//  alerView
//
//  Created by xia on 2017/11/23.
//  Copyright © 2017年 xia. All rights reserved.
//

#import "AlertLabelAndTextFieldTableViewCell.h"
#import <Masonry.h>

#define TableViewReloadData @"TableViewReloadData"

@interface AlertLabelAndTextFieldTableViewCell()<UITextFieldDelegate>
@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) UITextField *valueTF;
@end

@implementation AlertLabelAndTextFieldTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createSubviews];
        [self addTapGesture];
    }
    return self;
}

- (void)addTapGesture {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endEditInput)];
    [self addGestureRecognizer:tap];
}

- (void)endEditInput {
    [self endEditing:YES];
}

- (void)createSubviews {
    CGFloat widthTitle = (CGRectGetWidth(self.frame)-20)*0.27 ;
    _titleLabel = [[UILabel alloc] init];
    _valueTF = [[UITextField alloc] init];
    _valueTF.secureTextEntry = NO;
    [self addSubview:_titleLabel];
    [self addSubview:_valueTF];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(10);
        make.top.bottom.mas_equalTo(self);
        make.width.mas_equalTo(widthTitle);
    }];
    [_valueTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_titleLabel.mas_right).offset(18);
        make.top.bottom.mas_equalTo(self);
        make.right.mas_equalTo(self).offset(-10);
    }];
    
    _valueTF.delegate = self;
    [_valueTF addTarget:self action:@selector(textFieldValueChanged:) forControlEvents:UIControlEventEditingChanged];
    _valueTF.clearButtonMode = UITextFieldViewModeWhileEditing ;
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    _valueTF.textAlignment = NSTextAlignmentLeft;
}

- (void)textFieldValueChanged: (UITextField *)textFeild {
    if (textFeild.text.length >= 24) {
        textFeild.text = [textFeild.text substringToIndex:24];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [[NSNotificationCenter defaultCenter] postNotificationName:TableViewReloadData object:nil];
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)updateLeftLabelColor:(UIColor *)colorL
             rightLabelColor: (UIColor *)colorR
              textAlignmentL:(NSTextAlignment)alignmentL
                   labelFont:(UIFont *)font
{
    _titleLabel.textColor = colorL;
    _valueTF.textColor = colorR;
    
    _titleLabel.textAlignment = alignmentL;
    
    _titleLabel.font = font;
    _valueTF.font = font;
}

- (void)updateWithLabelContentWithTitleStr: (NSString *)titleString
                                  ValueStr:(NSString *)valueString
                           secureTextEntry: (BOOL) isPassword
{
    _titleLabel.text = titleString;
    _valueTF.placeholder = valueString;
    _valueTF.secureTextEntry = isPassword;
}

- (NSString *)AlertLabelAndTextFieldTableCellReturnString {
    return _valueTF.text;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
