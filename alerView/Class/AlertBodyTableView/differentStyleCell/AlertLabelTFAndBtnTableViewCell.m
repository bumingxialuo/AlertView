//
//  AlertLabelTFAndBtnTableViewCell.m
//  alerView
//
//  Created by xia on 2017/11/23.
//  Copyright © 2017年 xia. All rights reserved.
//

#import "AlertLabelTFAndBtnTableViewCell.h"
#import <RDCountDownButton.h>

#define TableViewReloadData @"TableViewReloadData"

@interface AlertLabelTFAndBtnTableViewCell()<UITextFieldDelegate>
@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) UITextField *valueTF;
@property(nonatomic, strong) RDCountDownButton *sendVerificationBtn;
@property(nonatomic, strong) UIView *line;
@end

@implementation AlertLabelTFAndBtnTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createCellSubView];
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

- (void)createCellSubView {
    _titleLabel = [[UILabel alloc] init];
    _valueTF = [[UITextField alloc] init];
    _valueTF.delegate = self;
    [_valueTF addTarget:self action:@selector(valueTFChanged:) forControlEvents:UIControlEventEditingChanged];
    _sendVerificationBtn = [RDCountDownButton buttonWithType:UIButtonTypeCustom];;
    _sendVerificationBtn.titleLabel.font = [UIFont systemFontOfSize:10];
    [_sendVerificationBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [_sendVerificationBtn setBackgroundColor:[UIColor clearColor]];
    [_sendVerificationBtn addTarget:self action:@selector(sendVerificationBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    _line = [[UIView alloc] init];
    _line.backgroundColor = [UIColor grayColor];
    CGFloat width = CGRectGetWidth(self.frame);
    CGFloat widthTitle = (width-20)*0.27 ;
    [self addSubview:_titleLabel];
    [self addSubview:_valueTF];
    [self addSubview:_sendVerificationBtn];
    [self addSubview:_line];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(10);
        make.top.bottom.mas_equalTo(self);
        make.width.mas_equalTo(widthTitle);
    }];
    [_sendVerificationBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self).offset(-10);
        make.centerY.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(80, 25));
    }];
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_sendVerificationBtn.mas_left).offset(0);
        make.centerY.mas_equalTo(self);
        make.width.mas_equalTo(1);
        make.height.mas_equalTo(25);
    }];
    [_valueTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_titleLabel.mas_right).offset(18);
        make.right.mas_equalTo(_line.mas_left).offset(-8);
        make.top.bottom.mas_equalTo(self);
    }];
}

- (void)updateWithTitleStr: (NSString *)titleStr ValuePlaceholderStr:(NSString *) placeholderStr BtnTitleStr: (NSString *)btnTitleStr {
    _titleLabel.text = titleStr;
    _valueTF.placeholder = placeholderStr;
    [_sendVerificationBtn setTitle:btnTitleStr forState:UIControlStateNormal];
}

- (NSString *)AlertLabelTFAndBtnTableViewReturnText {
    return _valueTF.text;
}

- (void)sendVerificationBtnClick: (UIButton *)sender {
    if (_cellDelegete && [_cellDelegete respondsToSelector:@selector(alertLabelTFAndBtnCellSendVerification)]) {
        [_cellDelegete alertLabelTFAndBtnCellSendVerification];
    }
}

- (void)updateLeftLabelColor:(UIColor *)colorL
             rightLabelColor:(UIColor *)colorR
            buttonTitleColor:(UIColor *)buttonTitleColor
               buttonBGColor:(UIColor *)buttonBGColor
                   lineColor:(UIColor *)lineColor
              textAlignmentL:(NSTextAlignment)alignmentL
                   labelFont:(UIFont *)font
                  buttonFont:(UIFont *)btnFont
{
    _titleLabel.textColor = colorL;
    _valueTF.textColor = colorR;
    [_sendVerificationBtn setTitleColor:buttonTitleColor forState:UIControlStateNormal];
    _line.backgroundColor = lineColor;
    
    _titleLabel.textAlignment = alignmentL;
    
    _titleLabel.font = font;
    _valueTF.font = font;
    _sendVerificationBtn.titleLabel.font = btnFont;
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    return YES;
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [[NSNotificationCenter defaultCenter] postNotificationName:TableViewReloadData object:nil];
}

- (void)valueTFChanged:(UITextField *)sender {
    if (sender.text.length >= 4) {
        sender.text = [sender.text substringToIndex:4];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
