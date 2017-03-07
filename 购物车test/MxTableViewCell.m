//
//  MxTableViewCell.m
//  购物车test
//
//  Created by 刘明鑫 on 2017/3/4.
//  Copyright © 2017年 刘明鑫. All rights reserved.
//

#import "MxTableViewCell.h"

@implementation MxTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setModel:(MxModel *)model{
    
    _NumLabel.text = [NSString stringWithFormat:@"%ld",(long)model.number];
    
    _selectBtn.selected = model.isSelected;
    
    _test1.text = model.test1;
}
//加号
- (IBAction)addNumBtn:(UIButton *)sender {
    if (_addBlock) {
        _addBlock(sender , self.indexPath);
    }
}
//减号
- (IBAction)remNumBtn:(UIButton *)sender {
    if (_subBlock) {
        _subBlock(sender , self.indexPath);
    }
}
- (IBAction)selectBtn:(UIButton *)sender {
    if (_selectedBlock) {
        _selectedBlock(sender , self.indexPath);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
