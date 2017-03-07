//
//  MxTableViewCell.h
//  购物车test
//
//  Created by 刘明鑫 on 2017/3/4.
//  Copyright © 2017年 刘明鑫. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MxModel.h"
//选中按钮
typedef void(^SelectedBlock)(UIButton *selectedBtn , NSIndexPath *indexPath);
//增加商品数量按钮
typedef void(^AddBlock)(UIButton *addBtn , NSIndexPath *indexPath);
typedef void(^SubBlock)(UIButton *subBtn , NSIndexPath *indexPath);
@interface MxTableViewCell : UITableViewCell
//数量指针
@property (weak, nonatomic) IBOutlet UILabel *NumLabel;
@property (weak, nonatomic) IBOutlet UIButton *selectBtn;
@property (weak, nonatomic) IBOutlet UILabel *test1;

//block指针
@property (nonatomic , strong)NSIndexPath *indexPath;
@property (nonatomic , copy)SelectedBlock selectedBlock;
@property (nonatomic , copy)AddBlock addBlock;
@property (nonatomic , copy)SubBlock subBlock;
//模型
@property (nonatomic , strong)MxModel *model;

@end
