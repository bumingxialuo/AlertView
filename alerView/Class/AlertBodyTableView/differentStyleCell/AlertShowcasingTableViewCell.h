//
//  AlertShowcasingTableViewCell.h
//  alerView
//
//  Created by xia on 2017/11/23.
//  Copyright © 2017年 xia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlertShowcasingTableViewCell : UITableViewCell

- (void)updateWithLabelContentWithTitleStr: (NSString *)titleString
                                  ValueStr:(NSString *)valueString;

- (void)updateLeftLabelColor:(UIColor *)colorL
             rightLabelColor: (UIColor *)colorR
              textAlignmentL:(NSTextAlignment)alignmentL
              textAlignmentR:(NSTextAlignment)alignmentR
                   labelFont:(UIFont *)font;
@end
