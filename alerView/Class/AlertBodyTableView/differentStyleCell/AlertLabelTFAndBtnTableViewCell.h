//
//  AlertLabelTFAndBtnTableViewCell.h
//  alerView
//
//  Created by xia on 2017/11/23.
//  Copyright © 2017年 xia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry.h>

@protocol AlertLabelTFAndBtnTableViewCellDelegete<NSObject>
- (void)alertLabelTFAndBtnCellSendVerification ;
@end

@interface AlertLabelTFAndBtnTableViewCell : UITableViewCell

@property(nonatomic, weak) id<AlertLabelTFAndBtnTableViewCellDelegete> cellDelegete;

- (void)updateWithTitleStr: (NSString *)titleStr ValuePlaceholderStr:(NSString *) placeholderStr BtnTitleStr: (NSString *)btnTitleStr ;
- (NSString *)AlertLabelTFAndBtnTableViewReturnText;

- (void)updateLeftLabelColor:(UIColor *)colorL
             rightLabelColor:(UIColor *)colorR
            buttonTitleColor:(UIColor *)buttonTitleColor
               buttonBGColor:(UIColor *)buttonBGColor
                   lineColor:(UIColor *)lineColor
              textAlignmentL:(NSTextAlignment)alignmentL
                   labelFont:(UIFont *)font
                  buttonFont:(UIFont *)btnFont;
@end
