//
//  AlertCreateDataSouce.m
//  alerView
//
//  Created by xia on 2017/11/24.
//  Copyright © 2017年 xia. All rights reserved.
//

#import "AlertCreateDataSouce.h"

@interface AlertCreateDataSouce()
@end

@implementation AlertCreateDataSouce

- (AlertListModel *)AlertCreateDadaWithShowcasingArr:(NSArray<NSDictionary *> *)showcasingArr
                                       labelAndTFArr:(NSArray<NSDictionary *> *)labelAndTFArr
                                    labelTFAndBtnArr:(NSArray<NSDictionary *> *)labelTFAndBtnArr
                                         textViewArr:(NSArray<NSDictionary *> *)textViewArr
{
    if (showcasingArr == nil) {
        showcasingArr = @[];
    }
    if (labelAndTFArr == nil) {
        labelAndTFArr = @[];
    }
    if (labelTFAndBtnArr == nil) {
        labelTFAndBtnArr = @[];
    }
    if (textViewArr == nil) {
        textViewArr = @[];
    }
    AlertListModel *list = [AlertListModel new];
    list.showcasingList = [self createShowcasingArr:showcasingArr];
    list.labelTFList = [self createLabelAndTFArr:labelAndTFArr];
    list.labelTFBtnList = [self createLabelTFAndBtnArr:labelTFAndBtnArr];
    list.TVList = [self createTextViewArr:textViewArr];
    return list;
}

- (NSArray<AlertShowcasingModel *> *)createShowcasingArr:(NSArray<NSDictionary *> *)showcasingArr {
    NSMutableArray *tempArr = [[NSMutableArray alloc] initWithCapacity:0];
    for (NSDictionary *dic in showcasingArr) {
        AlertShowcasingModel *model = [AlertShowcasingModel new];
        model.title = [dic objectForKey:@"title"];
        model.value = [dic objectForKey:@"value"];
        [tempArr addObject:model];
    }
    return tempArr;
}
- (NSArray<AlertLabelAndTFModel *> *)createLabelAndTFArr:(NSArray<NSDictionary *> *)labelAndTFArr {
    NSMutableArray *tempArr = [[NSMutableArray alloc] initWithCapacity:0];
    for (NSDictionary *dic in labelAndTFArr) {
        AlertLabelAndTFModel *model = [AlertLabelAndTFModel new];
        model.title = [dic objectForKey:@"title"];
        model.valueTF = [dic objectForKey:@"valueTF"];
        model.isPassword = [[dic objectForKey:@"isPassword"] isEqualToString:@"YES"];
        [tempArr addObject:model];
    }
    return tempArr;
}
- (NSArray<AlertLabelTFAndBtnModel *> *)createLabelTFAndBtnArr:(NSArray<NSDictionary *> *)labelTFAndBtnArr {
    NSMutableArray *tempArr = [[NSMutableArray alloc] initWithCapacity:0];
    for (NSDictionary *dic in labelTFAndBtnArr) {
        AlertLabelTFAndBtnModel *model = [AlertLabelTFAndBtnModel new];
        model.title = [dic objectForKey:@"title"];
        model.btnStr = [dic objectForKey:@"btnStr"];
        model.Textplaceholder = [dic objectForKey:@"Textplaceholder"];
        [tempArr addObject:model];
    }
    return tempArr;
}

- (NSArray<AlertTextViewModel *> *)createTextViewArr:(NSArray<NSDictionary *> *)textViewArr {
    NSMutableArray *tempArr = [[NSMutableArray alloc] initWithCapacity:0];
    for (NSDictionary *dic in textViewArr) {
        AlertTextViewModel *model = [AlertTextViewModel new];
        model.title = [dic objectForKey:@"title"];
        model.placeholderStr = [dic objectForKey:@"placeholderStr"];
        [tempArr addObject:model];
    }
    return tempArr;
}

- (NSArray<AlertIMGAndTFModel *> *)createIMGTFArr:(NSArray<NSDictionary *> *)IMGTFArr {
    NSMutableArray *tempArr = [[NSMutableArray alloc] initWithCapacity:0];
    for (NSDictionary *dic in IMGTFArr) {
        AlertIMGAndTFModel *model = [AlertIMGAndTFModel new];
        model.IMGStr = [dic objectForKey:@"IMGStr"];
        model.valueTF = [dic objectForKey:@"valueTF"];
        [tempArr addObject:model];
    }
    return tempArr;
}

@end
