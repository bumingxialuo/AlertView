//
//  AlertCreateDataSouce.h
//  alerView
//
//  Created by xia on 2017/11/24.
//  Copyright © 2017年 xia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AlertModel.h"

@interface AlertCreateDataSouce : NSObject

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
@end
