//
//  AlertTextViewTableViewCell.h
//  alerView
//
//  Created by xia on 2017/11/23.
//  Copyright © 2017年 xia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlertTextViewTableViewCell : UITableViewCell
- (void)fillInTextViewString: (NSString *)placeholderStr;

- (void)updateTextViewColor:(UIColor *)textColor
                   textFont:(UIFont *)textFont ;

- (NSString *)getTextViewString ;
@end
