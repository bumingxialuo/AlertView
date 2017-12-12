//
//  AlertBodyViewContentTable.m
//  alerView
//
//  Created by xia on 2017/11/22.
//  Copyright © 2017年 xia. All rights reserved.
//

#import "AlertBodyViewContentTable.h"
#import "AlertShowcasingTableViewCell.h"
#import "AlertLabelAndTextFieldTableViewCell.h"
#import "AlertLabelTFAndBtnTableViewCell.h"
#import "AlertTextViewTableViewCell.h"

#define TableViewReloadData @"TableViewReloadData"

#define AlertShowcasingTableViewCellID @"AlertShowcasingTableViewCellID"
#define AlertLabelAndTextFieldTableViewCellID @"AlertLabelAndTextFieldTableViewCellID"
#define AlertLabelTFAndBtnTableViewCellID @"AlertLabelTFAndBtnTableViewCellID"
#define AlertTextViewTableViewCellID @"AlertTextViewTableViewCellID"
#define AlertIMGAndTFTableViewCell @"AlertIMGAndTFTableViewCell"

@interface AlertBodyViewContentTable()<UITableViewDelegate, UITableViewDataSource, AlertLabelTFAndBtnTableViewCellDelegete>
{
}
@property(nonatomic, strong) NSArray<AlertShowcasingModel *> *model1;
@property(nonatomic, strong) NSArray<AlertLabelAndTFModel *> *model2;
@property(nonatomic, strong) NSArray<AlertLabelTFAndBtnModel *> *model3;
@property(nonatomic, strong) NSArray<AlertTextViewModel *> *model4;

@property(nonatomic, strong) NSMutableArray *modelArr;
@property(nonatomic, strong) NSMutableDictionary *cellContentDic;


@property(nonatomic, strong) UIColor *textLColor;
@property(nonatomic, strong) UIColor *textRColor;
@property(nonatomic, strong) UIColor *buttonBGColor;
@property(nonatomic, strong) UIColor *buttonTextColor;
@property(nonatomic, strong) UIColor *lineColor;

@property(nonatomic, assign) NSTextAlignment alignmentL;
@property(nonatomic, assign) NSTextAlignment alignmentR;

@property(nonatomic, strong) UIFont *BodyViewFont;
@property(nonatomic, strong) UIFont *bodyBtnFont;
@end

@implementation AlertBodyViewContentTable

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self registerCellClass];
        _cellContentDic = [[NSMutableDictionary alloc] initWithCapacity:0];
        [self addNotification];
        self.delegate = self;
        self.dataSource = self;
        self.separatorColor = [UIColor clearColor];
    }
    return self;
}

- (void)addNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadData) name:TableViewReloadData object:nil];
}

- (void)handleListModelData:(AlertListModel *)listModel {
    if (!_modelArr) {
        _modelArr = [[NSMutableArray alloc] initWithCapacity:0];
    }
    _model1 = listModel.showcasingList;
    _model2 = listModel.labelTFList;
    _model3 = listModel.labelTFBtnList;
    _model4 = listModel.TVList;
    [_modelArr addObject:_model1];
    [_modelArr addObject:_model2];
    [_modelArr addObject:_model3];
    [_modelArr addObject:_model4];
}
- (void)updateWithAlertListModel: (AlertListModel *)listModel {
    [self handleListModelData:listModel];
    [self reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 3) {
        return self.textViewCellHeight;
    }
    return self.rowHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 0.01)];
    return view;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 0.01)];
    return view;
}
- (void)registerCellClass {
    [self registerClass:[AlertShowcasingTableViewCell class] forCellReuseIdentifier:AlertShowcasingTableViewCellID];
    [self registerClass:[AlertLabelAndTextFieldTableViewCell class] forCellReuseIdentifier:AlertLabelAndTextFieldTableViewCellID];
    [self registerClass:[AlertLabelTFAndBtnTableViewCell class] forCellReuseIdentifier:AlertLabelTFAndBtnTableViewCellID];
    [self registerClass:[AlertTextViewTableViewCell class] forCellReuseIdentifier:AlertTextViewTableViewCellID];
    [self registerClass:[UITableViewCell class] forCellReuseIdentifier:AlertIMGAndTFTableViewCell];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_IMGTFArr) {
        return _IMGTFArr.count;
    } else {
        switch (section) {
            case 0:
                return _model1 ? _model1.count : 0;
                break;
            case 1:
                return _model2 ? _model2.count : 0;
                break;
            case 2:
                return _model3 ? _model3.count : 0;
                break;
            case 3:
                return _model4 ? _model4.count : 0;
                break;
            default:
                return 0;
                break;
        }
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (_IMGTFArr) {
        return 1;
    } else {
        return _modelArr.count;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_IMGTFArr) {
        if (_tableViewDelegete && [_tableViewDelegete respondsToSelector:@selector(imageAndLabelCellIndexClickWithIndexPath:)]) {
            [_tableViewDelegete imageAndLabelCellIndexClickWithIndexPath:indexPath];
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_IMGTFArr) {
        return [self createIMGAndTFWithTableView:tableView IndexPath:indexPath];
    } else {
        switch (indexPath.section) {
            case 0:
                return [self createShowingCasingCellWithtableView:tableView IndexPath:indexPath];
                break;
            case 1:
                return [self createLabelAndTextFieldCellWithtableView:tableView IndexPath:indexPath];
                break;
            case 2:
                return [self createLabelTFAndBtnCellWithtableView:tableView IndexPath:indexPath];
                break;
            case 3:
                return [self createTextViewCellWithtableView:tableView IndexPath:indexPath];
                break;
            default:
                return [self createShowingCasingCellWithtableView:tableView IndexPath:indexPath];
                break;
        }
    }
}

- (UITableViewCell *)createShowingCasingCellWithtableView:(UITableView *)tableView IndexPath:(NSIndexPath *)indexPath {
    AlertShowcasingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:AlertShowcasingTableViewCellID forIndexPath:indexPath];
    [cell updateWithLabelContentWithTitleStr:_model1[indexPath.row].title ValueStr:_model1[indexPath.row].value];
    [cell updateLeftLabelColor:_textLColor rightLabelColor:_textRColor textAlignmentL:_alignmentL textAlignmentR:_alignmentR labelFont:_BodyViewFont];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell ;
}

- (UITableViewCell *)createLabelAndTextFieldCellWithtableView:(UITableView *)tableView IndexPath:(NSIndexPath *)indexPath {
    AlertLabelAndTextFieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:AlertLabelAndTextFieldTableViewCellID];
    [cell updateWithLabelContentWithTitleStr:_model2[indexPath.row].title ValueStr:_model2[indexPath.row].valueTF secureTextEntry:_model2[indexPath.row].isPassword];
    [cell updateLeftLabelColor:_textLColor rightLabelColor:_textRColor textAlignmentL:_alignmentL labelFont:_BodyViewFont];
    [_cellContentDic setObject:[cell AlertLabelAndTextFieldTableCellReturnString] forKey:_model2[indexPath.row].title];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell ;
}

- (UITableViewCell *)createLabelTFAndBtnCellWithtableView:(UITableView *)tableView IndexPath:(NSIndexPath *)indexPath {
    AlertLabelTFAndBtnTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:AlertLabelTFAndBtnTableViewCellID];
    cell.cellDelegete = self;
    [cell updateWithTitleStr:_model3[indexPath.row].title ValuePlaceholderStr:_model3[indexPath.row].Textplaceholder BtnTitleStr:_model3[indexPath.row].btnStr];
    [cell updateLeftLabelColor:_textLColor rightLabelColor:_textRColor buttonTitleColor:_buttonTextColor buttonBGColor:_buttonBGColor lineColor:_lineColor textAlignmentL:_alignmentL labelFont:_BodyViewFont buttonFont:_bodyBtnFont];
    [_cellContentDic setObject:[cell AlertLabelTFAndBtnTableViewReturnText] forKey:_model3[indexPath.row].btnStr];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell ;
}

- (UITableViewCell *)createTextViewCellWithtableView:(UITableView *)tableView IndexPath:(NSIndexPath *)indexPath {
    AlertTextViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:AlertTextViewTableViewCellID];
    [cell fillInTextViewString: _model4[indexPath.row].placeholderStr];
    [cell updateTextViewColor:_textRColor textFont:_BodyViewFont];
    [_cellContentDic setObject:[cell getTextViewString] forKey:_model4[indexPath.row].title];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell ;
}

- (UITableViewCell *)createIMGAndTFWithTableView:(UITableView *)tableView IndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:AlertIMGAndTFTableViewCell];
    cell.imageView.image = [UIImage imageNamed:_IMGTFArr[indexPath.row].IMGStr];
    cell.textLabel.text = _IMGTFArr[indexPath.row].valueTF;
    cell.textLabel.textColor = _textRColor;
    return cell;
}

- (void)alertLabelTFAndBtnCellSendVerification {
    if (_IMGTFArr) {
        return;
    }
    if (_tableViewDelegete && [_tableViewDelegete respondsToSelector:@selector(AlertBodyViewContentTableGetVerification)]) {
        [_tableViewDelegete AlertBodyViewContentTableGetVerification];
    }
}

- (NSDictionary *)getCellContentTextString {
    [self reloadData];
     return _cellContentDic;
}

- (void)updateWithParam: (NSDictionary *)param {
    _textLColor = param[@"textLColor"];
    _textRColor = param[@"textRColor"];
    _buttonBGColor = param[@"buttonBGColor"];
    _buttonTextColor = param[@"buttonTextColor"];
    _lineColor = param[@"lineColor"];
    _alignmentL = [param[@"alignmentL"] integerValue];
    _alignmentR = [param[@"alignmentR"] integerValue];
    _BodyViewFont = param[@"BodyViewFont"];
    _bodyBtnFont = param[@"bodyBtnFont"];
    [self reloadData];
}
@end
