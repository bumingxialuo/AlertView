//
//  RDListAlertView.h
//  alerView
//
//  Created by xia on 2017/11/22.
//  Copyright © 2017年 xia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AlertModel.h"

@protocol RDListAlertViewDelegate<NSObject>
@optional
- (void)RDListAlertTableViewImageLabelCellSelectedWithIndexPath:(NSIndexPath *)indexPath;
@end

@interface RDListAlertView : UIView

@property (nonatomic, copy) dispatch_block_t dismissBlock;
@property (nonatomic, copy) dispatch_block_t sureBtnBlock;
@property (nonatomic, copy) dispatch_block_t cellBtnBlock;

@property (nonatomic, weak) id<RDListAlertViewDelegate> alertDelegate;

/**
 弹框主色
 */
@property(nonatomic, strong) UIColor *mainColor;

/**
 弹框中间的颜色
 */
@property(nonatomic, strong) UIColor *bodyTableViewBGColor;

/**
 头部文字颜色
 */
@property(nonatomic, strong) UIColor *titleColor;

/**
 foot 关闭按钮文字颜色
 */
@property(nonatomic, strong) UIColor *cancelBtnColor;

/**
 foot 确定按钮文字颜色
 */
@property(nonatomic, strong) UIColor *sureBtnColor;

/**
 cell 左边文案字体颜色
 */
@property(nonatomic, strong) UIColor *textLColor;

/**
 cell 右边文案字体颜色
 */
@property(nonatomic, strong) UIColor *textRColor;

/**
 cell button背景色
 */
@property(nonatomic, strong) UIColor *buttonBGColor;

/**
 cell button字体色
 */
@property(nonatomic, strong) UIColor *buttonTextColor;

/**
 footView 两个button的分割色
 */
@property(nonatomic, strong) UIColor *footLineColor;

/**
 cell 中分割线的颜色
 */
@property(nonatomic, strong) UIColor *cellBtnLineColor;

/**
 弹框 头部底部文字大小
 */
@property(nonatomic, strong) UIFont *HeadFootViewFont;

/**
 弹框 body内容字体大小
 */
@property(nonatomic, strong) UIFont *BodyViewFont;

/**
 弹框 body cell 按钮字体大小
 */
@property(nonatomic, strong) UIFont *bodyBtnFont;

/**
 cell 左边文字对其方式
 */
@property(nonatomic, assign) NSTextAlignment alignmentL;

/**
 cell 右边文字对其方式（输入框除外）
 */
@property(nonatomic, assign) NSTextAlignment alignmentR;


/**
  弹框：标题+内容+单个按钮;

 @param title 标题
 @param listModel 模型数据，根据数据组装相应的cell
 @param cancelTitle 确定按钮标题
 @return id
 */
- (id)initWithTitle:(NSString *)title
inputTextDictionary:(AlertListModel *)listModel
  cancelButtonTitle:(NSString *)cancelTitle;


/**
 弹框：标题+内容+按钮(确定+取消)

 @param title 标题
 @param listModel 模型数据，根据数据组装相应的cell
 @param sureTitle 确定按钮标题
 @param cancelTiltle 取消按钮标题
 @return id
 */
- (id)initWithTitle:(NSString *)title
inputTextDictionary:(AlertListModel *)listModel
    sureButtonTitle:(NSString *)sureTitle
  cancelButtonTitle:(NSString *)cancelTiltle;

/**
 展示视图，可点击（head带有关闭按钮）

 @param title 标题
 @param imgTFArr 照片和文字字典数组
 @param cancelTitle 关闭button
 @return id
 */
- (id)initWithTitle:(NSString *)title
    IMGTFDictionary:(NSArray<AlertIMGAndTFModel *> *)imgTFArr
  cancelButtonTitle:(NSString *)cancelTitle;

- (void)show;
- (void)dismissAlert;

/**
 返回弹出框 cell textField返回的数据

 @return cell @{labelSre:TFValue}
 */
- (NSDictionary *)alertTableViewCellContentStringWithCellLabelKey;

@end
