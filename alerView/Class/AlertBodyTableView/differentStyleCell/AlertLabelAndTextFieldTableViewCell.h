//
//  AlertLabelAndTextFieldTableViewCell.h
//  alerView
//
//  Created by xia on 2017/11/23.
//  Copyright © 2017年 xia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlertLabelAndTextFieldTableViewCell : UITableViewCell

- (NSString *)AlertLabelAndTextFieldTableCellReturnString;

- (void)updateWithLabelContentWithTitleStr: (NSString *)titleString
                                  ValueStr:(NSString *)valueString
                           secureTextEntry: (BOOL) isPassword;

- (void)updateLeftLabelColor:(UIColor *)colorL
             rightLabelColor: (UIColor *)colorR
              textAlignmentL:(NSTextAlignment)alignmentL
                   labelFont:(UIFont *)font;
@end
