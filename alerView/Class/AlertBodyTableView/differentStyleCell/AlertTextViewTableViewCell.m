//
//  AlertTextViewTableViewCell.m
//  alerView
//
//  Created by xia on 2017/11/23.
//  Copyright © 2017年 xia. All rights reserved.
//

#import "AlertTextViewTableViewCell.h"
#import <Masonry.h>
#import <objc/runtime.h>

#define TableViewReloadData @"TableViewReloadData"

@interface AlertTextViewTableViewCell()<UITextViewDelegate>
@property(nonatomic, strong) UITextView *textView;
@end

@implementation AlertTextViewTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createCellSubview];
    }
    return self;
}

- (void)createCellSubview {
    _textView = [[UITextView alloc] init];
    _textView.delegate = self;
    [self addSubview:_textView];
    [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(self).offset(10);
        make.bottom.right.mas_equalTo(self).offset(-10);
    }];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endEditTextView)];
    [self addGestureRecognizer:tap];
}

- (void)fillInTextViewString: (NSString *)placeholderStr {
    [self setupTextViewWithString:placeholderStr];
}

- (void)addTextViewPlaceHolderLabel {
    // 通过运行时，发现UITextView有一个叫做“_placeHolderLabel”的私有变量
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList([UITextView class], &count);
    
    for (int i = 0; i < count; i++) {
        Ivar ivar = ivars[i];
        const char *name = ivar_getName(ivar);
        NSString *objcName = [NSString stringWithUTF8String:name];
        NSLog(@"%d : %@",i,objcName);
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    [[NSNotificationCenter defaultCenter] postNotificationName:TableViewReloadData object:nil];
}

- (void)endEditTextView {
    [self endEditing:YES];
}

- (void)setupTextViewWithString: (NSString *)str {
    
    [self addTextViewPlaceHolderLabel];
    
    // _placeholderLabel
    UILabel *placeHolderLabel = [[UILabel alloc] init];
    placeHolderLabel.text = str;
    placeHolderLabel.numberOfLines = 0;
    placeHolderLabel.textColor = [UIColor lightGrayColor];
    [placeHolderLabel sizeToFit];
    [_textView addSubview:placeHolderLabel];
    
    // same font
    _textView.font = [UIFont systemFontOfSize:13.f];
    placeHolderLabel.font = [UIFont systemFontOfSize:13.f];
    
    [_textView setValue:placeHolderLabel forKey:@"_placeholderLabel"];
}

- (void)updateTextViewColor:(UIColor *)textColor
                   textFont:(UIFont *)textFont
{
    _textView.textColor = textColor;
    _textView.font = textFont;
}

- (NSString *)getTextViewString {
    return _textView.text;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
