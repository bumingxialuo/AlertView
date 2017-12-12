//
//  AlertModel.h
//  alerView
//
//  Created by xia on 2017/11/23.
//  Copyright © 2017年 xia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AlertShowcasingModel: NSObject
@property(nonatomic, copy) NSString *title;
@property(nonatomic, copy) NSString *value;
@end

@interface AlertLabelAndTFModel: NSObject
@property(nonatomic, copy) NSString *title;
@property(nonatomic, copy) NSString *valueTF;
@property(nonatomic, assign) BOOL isPassword;
@end

@interface AlertLabelTFAndBtnModel: NSObject
@property(nonatomic, copy) NSString *title;
@property(nonatomic, copy) NSString *Textplaceholder;
@property(nonatomic, copy) NSString *btnStr;
@end

@interface AlertTextViewModel: NSObject
@property(nonatomic, copy) NSString *title;
@property(nonatomic, copy) NSString *placeholderStr;
@end

@interface AlertIMGAndTFModel: NSObject
@property(nonatomic, copy) NSString *IMGStr;
@property(nonatomic, copy) NSString *valueTF;
@end

@interface AlertListModel : NSObject
@property(nonatomic, strong) NSArray<AlertShowcasingModel *> *showcasingList;
@property(nonatomic, strong) NSArray<AlertLabelAndTFModel *> *labelTFList;
@property(nonatomic, strong) NSArray<AlertLabelTFAndBtnModel *> *labelTFBtnList;
@property(nonatomic, strong) NSArray<AlertTextViewModel *> *TVList;
@property(nonatomic, strong) NSArray<AlertIMGAndTFModel *> *IMGTFList;
@end
