//
//  MxModel.h
//  购物车test
//
//  Created by 刘明鑫 on 2017/3/5.
//  Copyright © 2017年 刘明鑫. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MxModel : NSObject
@property(nonatomic,assign)CGFloat price;
@property(nonatomic,assign)NSInteger number;
//测试用
@property (nonatomic , copy)NSString *test1;
//判断是否选中
@property(nonatomic,assign)BOOL isSelected;
@end
