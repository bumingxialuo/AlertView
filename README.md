# AlertView
![Image text](https://github.com/bumingxialuo/AlertView/blob/master/alertView.gif)
## OverView
#### the alertView are three parts
  ###### 1、headView
  option：if title's lenth is equel to 0, hidden it<br>
  ###### 2、bodyView(contain diffrent cell to display something you want to show)
    2.1、<br>
    2.2、<br>
    2.3、<br>
    2.4、<br>
  ###### 3、footView
  
some variable attribute<br>
```oc
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
```
