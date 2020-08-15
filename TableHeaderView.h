//
//  TableHeaderView.h
//  huinongwang
//
//  Created by HN on 2020/7/31.
//  Copyright © 2020 cnhnb. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define SCREEN_SAFE_AREA_MARGIN_TOP ([UIApplication sharedApplication].statusBarFrame.size.height + 44)

NS_ASSUME_NONNULL_BEGIN

@interface TableHeaderView : UIView


@property (assign, nonatomic) BOOL bShowImage;

+ (instancetype)headerContentView;
- (CGFloat)rowHeightWithModelsWithCellCount:(NSInteger)cellCount;

@end

NS_ASSUME_NONNULL_END
