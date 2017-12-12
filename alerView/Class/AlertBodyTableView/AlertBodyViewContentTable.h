//
//  AlertBodyViewContentTable.h
//  alerView
//
//  Created by xia on 2017/11/22.
//  Copyright © 2017年 xia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AlertModel.h"

typedef NS_ENUM(NSInteger, AlertCellType){
    /**
     * label展示
     */
    AlertCellTypeShowcasing = 0,
    /**
     * label+textField
     */
    AlertCellTypeLabelAndTF = 2,
    /**
     * label+textField+Button
     */
    AlertCellTypeLabelTFAndBtn = 3,
    /**
     * textView
     */
    AlertCellTypeTextView = 4,
    /**
     * 自定义
     */
    AlertCellTypeCustom = 11
    
};

@protocol AlertBodyViewContentTableDelegete<NSObject>
- (void)AlertBodyViewContentTableGetVerification;
- (void)imageAndLabelCellIndexClickWithIndexPath: (NSIndexPath *)indexPath;
@end

@interface AlertBodyViewContentTable : UITableView
@property(nonatomic, weak) id<AlertBodyViewContentTableDelegete> tableViewDelegete;
@property(nonatomic, assign) CGFloat rowHeight;
@property(nonatomic, assign) CGFloat textViewCellHeight;
@property(nonatomic, strong) NSArray<AlertIMGAndTFModel *> *IMGTFArr;

- (void)updateWithAlertListModel: (AlertListModel *)listModel;
- (NSDictionary *)getCellContentTextString;
- (void)updateWithParam: (NSDictionary *)param;
@end
