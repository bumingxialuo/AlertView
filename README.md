# AlertView

![Image text](https://github.com/bumingxialuo/AlertView/blob/master/alertView.gif)

## OverView

Assemble different cells based on your incoming array <br>

#### The alertView include three parts

##### headView 
  Fixed height is 45 <br>
  option：if title's lenth is equel to 0, hidden it <br>
————————————————————————————————————————————————————————
  
##### bodyView

contain diffrent cell to display something you want to show <br>
    2.1、AlertShowcasingTableViewCell <br>
    two label. One of them can be a title,another can be a value </br>
    2.2、AlertLabelAndTextFieldTableViewCell <br>
    one label and one textFeild. It's a good choice in Login </br>
    2.3、AlertLabelTFAndBtnTableViewCell <br>
    label、textFeild and button. it can receive and enter the verification code </br>
    2.4、AlertTextViewTableViewCell  <br>
    textFeild. You can type a lot of text.And it restricted input range  </br>
    2.5、AlertIMGAndTFTableViewCell <br>
    imageView,label. list some imformation </br>
——————————————————————————————————————————————————————————
##### footView <br>
  Fixed height is 45 <br>
  ————————————————————————————————————————————————————————
### How to show diffrent cell
It's coming in AlertListModel , and handle it
```oc
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
```
create 4 section in tableView, and unique cell in each section
```oc
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

```
some variable attribute<br>
```oc
@property(nonatomic, strong) UIColor *mainColor;
@property(nonatomic, strong) UIColor *bodyTableViewBGColor;
@property(nonatomic, strong) UIColor *titleColor;
@property(nonatomic, strong) UIColor *cancelBtnColor;
@property(nonatomic, strong) UIColor *sureBtnColor;
@property(nonatomic, strong) UIColor *textLColor;
@property(nonatomic, strong) UIColor *textRColor;
@property(nonatomic, strong) UIColor *buttonBGColor;
@property(nonatomic, strong) UIColor *buttonTextColor;
@property(nonatomic, strong) UIColor *footLineColor;
@property(nonatomic, strong) UIColor *cellBtnLineColor;
@property(nonatomic, strong) UIFont *HeadFootViewFont;
@property(nonatomic, strong) UIFont *BodyViewFont;
@property(nonatomic, strong) UIFont *bodyBtnFont;
@property(nonatomic, assign) NSTextAlignment alignmentL;
@property(nonatomic, assign) NSTextAlignment alignmentR;
```
### alertView provides some initialization function
you can find it in ```RDListAlertView.h``` <br>
```oc
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
```
### Some user interactions
```oc
@property (nonatomic, copy) dispatch_block_t dismissBlock;
@property (nonatomic, copy) dispatch_block_t sureBtnBlock;
@property (nonatomic, copy) dispatch_block_t cellBtnBlock;
```
You can do something in block.But only AlertIMGAndTFTableViewCell can using <br>
```oc
- (void)RDListAlertTableViewImageLabelCellSelectedWithIndexPath:(NSIndexPath *)indexPath;
```
### AlertCreateDataSouce
```oc
/**
 将数据转换为特定的model

 @param showcasingArr 展示样式 cell格式
 @param labelAndTFArr 展示+输入框 cell格式
 @param labelTFAndBtnArr 展示+输入框+按钮 cell格式
 @param textViewArr textView cell格式
 @return 标准的listViewModel
 */
- (AlertListModel *)AlertCreateDadaWithShowcasingArr: (NSArray<NSDictionary *> *)showcasingArr
                                       labelAndTFArr: (NSArray<NSDictionary *> *)labelAndTFArr
                                       labelTFAndBtnArr: (NSArray<NSDictionary *> *)labelTFAndBtnArr
                                         textViewArr: (NSArray *)textViewArr;

/**
 创建alertIMGTF的listModel

 @param IMGTFArr 带转换的字典数组
 @return 目标listModel
 */
- (NSArray<AlertIMGAndTFModel *> *)createIMGTFArr:(NSArray<NSDictionary *> *)IMGTFArr;
```
### How to use
```oc
- (void)createData {
    _arr1 = @[@{@"title":@"费用1",@"value":@"200.00元"},@{@"title":@"费用2",@"value":@"220.00元"}];
    _arr2 = @[@{@"title":@"用户名",@"valueTF":@"请输入用户名",@"isPassword":@"NO"},@{@"title":@"密码",@"valueTF":@"请输入密码",@"isPassword":@"YES"}];
    _arr3 = @[@{@"title":@"验证码",@"Textplaceholder":@"请输入验证码",@"btnStr":@"发送验证码"}];
    _arr4 = @[@{@"title":@"评价",@"placeholderStr":@"请输入评论内容"}];
}

- (void)showAlertView {
    AlertListModel *listModel = [[AlertCreateDataSouce alloc] AlertCreateDadaWithShowcasingArr: _arr1
                                                                 labelAndTFArr:nil
                                                              labelTFAndBtnArr:nil
                                                                   textViewArr:nil];
    RDListAlertView *alertView = [[RDListAlertView alloc] initWithTitle:@"费用详情" inputTextDictionary:listModel cancelButtonTitle:@"我知道啦"];
    alertView.mainColor = [UIColor orangeColor];
    [alertView show];
}
```
