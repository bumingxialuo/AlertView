//
//  RDListAlertView.m
//  alerView
//
//  Created by xia on 2017/11/22.
//  Copyright © 2017年 xia. All rights reserved.
//

#import "RDListAlertView.h"
#import "AlertBodyViewContentTable.h"
#import <Masonry.h>
#import <UIColor+Palette.h>

#define HEIGHTOFSCREEN [[UIScreen mainScreen] bounds].size.height
#define MAXHEIGHTOFSCREEN 0.4* HEIGHTOFSCREEN
#define WIDTHOFSCREEN [[UIScreen mainScreen] bounds].size.width
#define WIDTHRADIUS (WIDTHOFSCREEN/375.0)
#define kAlertWidth WIDTHRADIUS*260.5f
#define kTitleHeight 45.0f
#define cellHeight 55
#define textViewHeight 150

@interface RDListAlertView()<AlertBodyViewContentTableDelegete>

@property(nonatomic, strong) UIView *headView;
@property(nonatomic, strong) UIView *bodyView;
@property(nonatomic, strong) AlertBodyViewContentTable *tableView;
@property(nonatomic, strong) UIView *footView;

@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) UIButton *sureButton;
@property(nonatomic, strong) UIButton *cancleButton;
@property(nonatomic, strong) UIButton *closeButton;

@property(assign, nonatomic) CGFloat keyboardHeight;

@property(nonatomic, strong) UIColor *alertMainColor;

@property(nonatomic, strong) UIView *bgView;
@end

@implementation RDListAlertView

- (id)initWithTitle:(NSString *)title inputTextDictionary:(AlertListModel *)listModel cancelButtonTitle:(NSString *)cancelTitle {
    self = [super init];
    if (self) {
        self.layer.cornerRadius = 5.0;
        self.layer.masksToBounds = YES;
        if (title.length > 0) {
            if (listModel.TVList.count > 0) {
                [self createAlertHeadViewWithCloseButton:YES];
            } else {
                [self createAlertHeadViewWithCloseButton:NO];
            }
        }
        [self createBodyViewWithListModel:listModel withIMGTFArr:nil];
        if (cancelTitle.length == 0) {
            cancelTitle = @"确定";
        }
        [self createAlertFootViewWithCancelStr:cancelTitle sureStr:nil];
        _titleLabel.text = title;
    }
    return self;
}

- (id)initWithTitle:(NSString *)title inputTextDictionary:(AlertListModel *)listModel sureButtonTitle:(NSString *)sureTitle cancelButtonTitle:(NSString *)cancelTiltle {
    self = [super init];
    if (self) {
        self.layer.cornerRadius = 5.0;
        self.layer.masksToBounds = YES;
        if (title.length > 0) {
            [self createAlertHeadViewWithCloseButton:NO];
        }
        if (sureTitle.length == 0) {
            sureTitle = @"确定";
        }
        if (cancelTiltle.length == 0) {
            cancelTiltle = @"取消";
        }
        [self createBodyViewWithListModel:listModel withIMGTFArr:nil];
        [self createAlertFootViewWithCancelStr:cancelTiltle sureStr:sureTitle];
        _titleLabel.text = title;
        
        [_sureButton setTitle:sureTitle forState:UIControlStateNormal];
        [_cancleButton setTitle:cancelTiltle forState:UIControlStateNormal];
    }
    return self;
}

- (id)initWithTitle:(NSString *)title
    IMGTFDictionary:(NSArray<AlertIMGAndTFModel *> *)imgTFArr
  cancelButtonTitle:(NSString *)cancelTitle {
    self = [super init];
    if (self) {
        self.layer.cornerRadius = 5.0;
        self.layer.masksToBounds = YES;
        [self createAlertHeadViewWithCloseButton:YES];
        [self createBodyViewWithListModel:nil withIMGTFArr:imgTFArr];
        if (cancelTitle) {
            [self createAlertFootViewWithCancelStr:cancelTitle sureStr:nil];
        }
    }
    return self;
}

#pragma mark - 弹框头视图
- (void)createAlertHeadViewWithCloseButton: (BOOL)isShowCloseBtn {
    _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kAlertWidth, kTitleHeight)];
    _headView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_headView];
    [_headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self);
        make.height.mas_equalTo(kTitleHeight);
    }];
    
    [self createAlertHeadTitleView];
    if (isShowCloseBtn) {
        [self createAlertHeadCloseButton];
    }
}

- (void)createAlertHeadTitleView {
    _titleLabel = [[UILabel alloc] initWithFrame:_headView.frame];
    [_headView addSubview:_titleLabel];
    _titleLabel.textAlignment =NSTextAlignmentCenter;
    _titleLabel.textColor = [UIColor colorWithWhite:0.8 alpha:1];
}

- (void)createAlertHeadCloseButton {
    _closeButton = [[UIButton alloc] init];
    [_headView addSubview:_closeButton];
    [_closeButton setImage: [UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    [_closeButton addTarget:self action:@selector(headViewCloseButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [_closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(32, 32));
        make.centerY.mas_equalTo(_headView);
        make.right.mas_equalTo(_headView).offset(-10);
    }];
}

#pragma mark - 弹框内容视图
- (void)createBodyViewWithListModel:(AlertListModel *)listModel withIMGTFArr:(NSArray<AlertIMGAndTFModel *> *)IMGTFArr {
    CGFloat bodyHeight = 0;
    if (listModel) {
        bodyHeight = ([self getHeightOfAlert:listModel] > MAXHEIGHTOFSCREEN) ? MAXHEIGHTOFSCREEN : [self getHeightOfAlert:listModel];
    } else {
        bodyHeight = MAXHEIGHTOFSCREEN;
    }
    
    if (_headView) {
        _bodyView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_headView.frame), kAlertWidth, bodyHeight)];
    } else {
        _bodyView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kAlertWidth, bodyHeight)];
    }
    
    _bodyView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_bodyView];
    if (_headView) {
        [_bodyView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self);
            make.top.mas_equalTo(_headView.mas_bottom);
            make.height.mas_equalTo(bodyHeight);
        }];
    } else {
        [_bodyView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self);
            make.top.mas_equalTo(self);
            make.height.mas_equalTo(bodyHeight);
        }];
    }
    
    _tableView = [[AlertBodyViewContentTable alloc] initWithFrame: CGRectMake(0, 0, kAlertWidth, CGRectGetHeight(_bodyView.bounds)) style:UITableViewStyleGrouped];
    _tableView.tableViewDelegete = self;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.showsHorizontalScrollIndicator = NO;
    if (CGRectGetHeight(_bodyView.bounds) < MAXHEIGHTOFSCREEN) {
        _tableView.scrollEnabled = NO;
    } else {
        _tableView.scrollEnabled = YES;
    }
    _tableView.rowHeight = cellHeight;
    _tableView.textViewCellHeight = textViewHeight;
    if (listModel) {
        [_tableView updateWithAlertListModel:listModel];
    }
    if (IMGTFArr) {
        _tableView.IMGTFArr = IMGTFArr;
        [_tableView reloadData];
    }
    [_bodyView addSubview: _tableView];
}

- (CGFloat)getHeightOfAlert: (AlertListModel *)listModel {
    CGFloat height = 0;
    NSArray<AlertShowcasingModel *> *model1 = listModel.showcasingList;
    NSArray<AlertLabelAndTFModel *> *model2 = listModel.labelTFList;
    NSArray<AlertLabelTFAndBtnModel *> *model3 = listModel.labelTFBtnList;
    NSArray<AlertTextViewModel *> *model4 = listModel.TVList;
    if (model1) {
        height = height + model1.count * cellHeight;
    }
    if (model2) {
        height = height + model2.count * cellHeight;
    }
    if (model3) {
        height = height + model3.count * cellHeight;
    }
    if (model4) {
        height = height + model4.count * textViewHeight;
    }
    return height;
}

#pragma mark - 创建弹框脚视图
- (void)createAlertFootViewWithCancelStr: (NSString *)cancelStr sureStr: (NSString *)sureStr {
    _footView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_bodyView.frame), kAlertWidth, kTitleHeight)];
    _footView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_footView];
    [_footView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.top.mas_equalTo(_bodyView.mas_bottom);
        make.height.mas_equalTo(kTitleHeight);
    }];
    
    _cancleButton = [[UIButton alloc] initWithFrame:_footView.frame];
    [_footView addSubview:_cancleButton];
    [_cancleButton setTitleColor: [UIColor colorWithWhite:0.8 alpha:1] forState:UIControlStateNormal];
    [_cancleButton addTarget:self action:@selector(cancleButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [_cancleButton setTitle:cancelStr forState:UIControlStateNormal];
    
    _sureButton = [[UIButton alloc] initWithFrame:_footView.frame];
    [_footView addSubview:_sureButton];
    [_sureButton setTitleColor: [UIColor colorWithWhite:0.8 alpha:1] forState:UIControlStateNormal];
    [_sureButton addTarget:self action:@selector(sureButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [_sureButton setTitle:sureStr forState:UIControlStateNormal];
    
    CGFloat width = CGRectGetWidth(_footView.frame) * 0.5 - 0.5;
    
    if (sureStr.length == 0) {
        [_cancleButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(_footView);
        }];
        [_sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.bottom.mas_equalTo(_footView);
            make.width.mas_equalTo(0);
        }];
    } else {
        [_cancleButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.mas_equalTo(_footView);
            make.width.mas_equalTo(width);
        }];
        [_sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.bottom.mas_equalTo(_footView);
            make.width.mas_equalTo(width);
        }];
    }
    if (cancelStr.length == 0 && sureStr.length == 0) {
        [_footView removeFromSuperview];
    }
}

#pragma mark - 弹框进入视图
- (void)show {
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    UIViewController *topVC = [self appRootViewController];
    self.frame = CGRectMake((CGRectGetWidth(topVC.view.bounds) - kAlertWidth) * 0.5, (HEIGHTOFSCREEN - [self getAlertHeight])*0.5-20, kAlertWidth,[self getAlertHeight]);
    [self exChangeOut:self dur:0.4f];
    [self addObservers];
    [self addTapGesture];
    [self updateColors];
    _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTHOFSCREEN, HEIGHTOFSCREEN)];
    _bgView.backgroundColor = [UIColor colorWithWhite:0.4 alpha:0.4];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeFromSuperviews)];
    [_bgView addGestureRecognizer:tap];
    [[UIApplication sharedApplication].keyWindow addSubview:_bgView];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}

- (void)addTapGesture {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endEditInput)];
    [self addGestureRecognizer:tap];
}

- (void)endEditInput {
    [self endEditing:YES];
}

- (CGFloat)getAlertHeight {
    return CGRectGetHeight(_headView.bounds)+CGRectGetHeight(_bodyView.bounds)+CGRectGetHeight(_footView.bounds);
}

- (UIViewController *)appRootViewController
{
    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *topVC = appRootVC;
    while (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    return topVC;
}

#pragma mark - headView footView按钮点击事件

- (void)headViewCloseButtonClick {
    [self removeFromSuperviews];
    [self removeObservers];
}

- (void)cancleButtonClick {
    [self endEditing:YES];
    [self dismissAlert];
}

- (void)sureButtonClick {
    [self enSureDodoSomeThing];
}

- (void)dismissAlert {
    [self removeFromSuperviews];
    [self removeObservers];
    if (self.dismissBlock) {
        self.dismissBlock();
    }
}

- (void)enSureDodoSomeThing {
    //确定按钮点击
    if (self.sureBtnBlock) {
        self.sureBtnBlock();
    }
}

- (void)AlertBodyViewContentTableGetVerification {
    if (self.cellBtnBlock) {
        self.cellBtnBlock();
    }
}
- (void)imageAndLabelCellIndexClickWithIndexPath:(NSIndexPath *)indexPath {
    if (_alertDelegate && [_alertDelegate respondsToSelector:@selector(RDListAlertTableViewImageLabelCellSelectedWithIndexPath:)]) {
        [_alertDelegate RDListAlertTableViewImageLabelCellSelectedWithIndexPath:indexPath];
    }
}

- (NSDictionary *)alertTableViewCellContentStringWithCellLabelKey {
    return [_tableView getCellContentTextString];
}

- (void)removeFromSuperviews {
//    [self removeFromSuperview];
    [_bgView removeFromSuperview];
    UIViewController *topVC = [self appRootViewController];
    CGRect afterFrame = CGRectMake((CGRectGetWidth(topVC.view.bounds) - kAlertWidth) * 0.5, CGRectGetHeight(topVC.view.bounds), kAlertWidth, CGRectGetHeight(self.bounds));
    
    [UIView animateWithDuration:0 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.frame = afterFrame;
        //        if (_leftLeave) {
        //            self.transform = CGAffineTransformMakeRotation(-M_1_PI / 1.5);
        //        }else {
        self.transform = CGAffineTransformMakeRotation(M_1_PI / 1.5);
        //        }
    } completion:^(BOOL finished) {
        //注释原因：DXAlertView弹框切后台会在这crash
        [self removeFromSuperview];
    }];
}

#pragma mark - 弹框出现动画
-(void)exChangeOut:(UIView *)changeOutView dur:(CFTimeInterval)dur{
    CAKeyframeAnimation * animation;
    animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    
    animation.duration = dur;
    
    //animation.delegate = self;
    
    animation.removedOnCompletion = NO;
    
    animation.fillMode = kCAFillModeForwards;
    
    NSMutableArray *values = [NSMutableArray array];
    
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.8, 0.8, 1.0)]];
    
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.08, 1.08, 1.0)]];
    
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 0.9)]];
    
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    
    animation.values = values;
    
    animation.timingFunction = [CAMediaTimingFunction functionWithName: @"easeInEaseOut"];
    
    [changeOutView.layer addAnimation:animation forKey:nil];
    
}

#pragma mark - addObserver, removeObserver
- (void)addObservers
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardVisibleChanged:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardVisibleHiddenChanged:) name:UIKeyboardWillHideNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardFrameChanged:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)removeObservers
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
}

#pragma mark - Keyboard notifications

- (void)keyboardVisibleChanged:(NSNotification *)notification
{
    if (self) {
        [self updateFramSizeToAdaptionKeyboardWithShow:YES];
    }
}

- (void)keyboardFrameChanged:(NSNotification *)notification
{
    NSLog(@"%@", notification);
    NSDictionary *userInfo = [notification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    int height = keyboardRect.size.height;
    _keyboardHeight = height;
}

- (void)keyboardVisibleHiddenChanged:(NSNotification *)notification {
    if (self) {
        [self updateFramSizeToAdaptionKeyboardWithShow:NO];
    }
}

- (void)updateFramSizeToAdaptionKeyboardWithShow: (BOOL) isShow {
    UIViewController *topVC = [self appRootViewController];
    CGFloat height = CGRectGetHeight(self.frame);
    CGFloat alertToBotton = HEIGHTOFSCREEN - CGRectGetMaxY(self.frame);
    if (isShow) {
        if (alertToBotton < _keyboardHeight) {
            [self mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(kAlertWidth, height));
                make.centerX.mas_equalTo(topVC.view);
                make.bottom.mas_equalTo(topVC.view).offset(-(_keyboardHeight+20));
            }];
        }
    } else {
        [self mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(kAlertWidth, height));
            make.centerX.mas_equalTo(topVC.view);
            make.top.mas_equalTo(topVC.view).offset((HEIGHTOFSCREEN - [self getAlertHeight])*0.5-20);
        }];
    }
}

#pragma mark - 设置颜色及属性
- (void)updateColors {
    
    
    _headView.backgroundColor = _mainColor ? _mainColor : [UIColor colorFromHexString:@"ffffff"];
    _titleLabel.textColor = _titleColor ? _titleColor : [UIColor colorFromHexString:@"#333333"];
    _titleLabel.font = _HeadFootViewFont ? _HeadFootViewFont : [UIFont systemFontOfSize:18];
    if (_cancleButton) {
        [_cancleButton setBackgroundColor:_mainColor ? _mainColor : [UIColor colorFromHexString:@"ffffff"]];
        [_cancleButton setTitleColor:_cancelBtnColor ? _cancelBtnColor : [UIColor colorFromHexString:@"333333"] forState:UIControlStateNormal];
        _cancleButton.titleLabel.font = _HeadFootViewFont ? _HeadFootViewFont : [UIFont systemFontOfSize:16];
    }
    if (_sureButton) {
        [_sureButton setBackgroundColor:_mainColor ? _mainColor : [UIColor colorFromHexString:@"ffffff"]];
        [_sureButton setTitleColor:_sureBtnColor ? _sureBtnColor : [UIColor colorFromHexString:@"333333"] forState:UIControlStateNormal];
        _sureButton.titleLabel.font = _HeadFootViewFont ? _HeadFootViewFont : [UIFont systemFontOfSize:16];
    }
    _bodyView.backgroundColor = _mainColor ? _mainColor : [UIColor colorFromHexString:@"ffffff"];
    [_tableView updateWithParam:[self updateTableViewColorAndFont]];
    _tableView.backgroundColor = _bodyTableViewBGColor ? _bodyTableViewBGColor : [UIColor colorFromHexString:@"dedede"];
    
    _footView.backgroundColor = _footLineColor ? _footLineColor : [UIColor colorFromHexString:@"#ffffff"];
}

- (NSDictionary *)updateTableViewColorAndFont {
    NSTextAlignment left = _alignmentL ? _alignmentL : NSTextAlignmentLeft;
    NSTextAlignment right = _alignmentR ? _alignmentR : NSTextAlignmentLeft;
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:0];
    [dic setObject:_textLColor ? _textLColor : [UIColor colorFromHexString:@"#333333"] forKey:@"textLColor"];
    [dic setObject:_textRColor ? _textRColor : [UIColor colorFromHexString:@"#666666"] forKey:@"textRColor"];
    [dic setObject:_buttonBGColor ? _buttonBGColor : [UIColor clearColor] forKey:@"buttonBGColor"];
    [dic setObject:_buttonTextColor ? _buttonTextColor : [UIColor colorFromHexString:@"#666666"] forKey:@"buttonTextColor"];
    [dic setObject:[NSString stringWithFormat:@"%d",left] forKey:@"alignmentL"];
    [dic setObject:[NSString stringWithFormat:@"%d",right] forKey:@"alignmentR"];
    [dic setObject:_BodyViewFont ? _BodyViewFont : [UIFont systemFontOfSize:16] forKey:@"BodyViewFont"];
    [dic setObject:_bodyBtnFont ? _bodyBtnFont : [UIFont systemFontOfSize:12] forKey:@"bodyBtnFont"];
    [dic setObject:_cellBtnLineColor ? _cellBtnLineColor : [UIColor colorFromHexString:@"#999999"] forKey:@"lineColor"];
    return dic;
}


@end
