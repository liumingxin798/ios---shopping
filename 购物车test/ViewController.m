//
//  ViewController.m
//  购物车test
//
//  Created by 刘明鑫 on 2017/3/4.
//  Copyright © 2017年 刘明鑫. All rights reserved.
//
#define SCREEN_WIDTH   [UIScreen mainScreen].bounds.size.width
#define SCREENH_HEIGHT [UIScreen mainScreen].bounds.size.height
#import "ViewController.h"
#import "MxTableViewCell.h"
#import "MxModel.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , strong)UITableView *tableView;
//总价格
@property (weak, nonatomic) IBOutlet UILabel *totleLabel;
//数据源
@property (nonatomic , strong)NSMutableArray *dataSoureArray;
//选中数据源
@property (nonatomic , strong)NSMutableArray *selectArray;
//全选button
@property (weak, nonatomic) IBOutlet UIButton *everyBtn;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self CreateTableView];
}
- (void)CreateTableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 10,SCREEN_WIDTH, SCREENH_HEIGHT-59) style:UITableViewStylePlain];
    _tableView.delegate   = self;
    _tableView.dataSource = self;
    [_tableView registerNib:[UINib nibWithNibName:@"MxTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.view insertSubview:_tableView atIndex:0];
    
}
#pragma  tableView的基本代理
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MxTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    __weak __typeof (self)WeakSelf = self;
    __weak __typeof (cell)WeakCell = cell;
    __weak __typeof (tableView)WeakTableView = tableView;
    cell.indexPath = indexPath;
    MxModel *model = self.dataSoureArray[indexPath.row];
    cell.model = model;
    
    //增加按钮回调
    cell.addBlock  = ^(UIButton *addBtn , NSIndexPath *indexPath){
        //取得商品现在的数量，点击加号进行count++
        int count = [WeakCell.NumLabel.text intValue];
            count ++;
        //当商品数量大于10，进行返回
        if (count > 10) return;
        WeakCell.NumLabel.text = [NSString stringWithFormat:@"%d",count];
        model.number = count;
        //NSLog(@"以前%@",_dataSoureArray);
     //   [_dataSoureArray replaceObjectAtIndex:indexPath.row withObject:model];
       //  NSLog(@"之后%@",_dataSoureArray);
        //当商品从1变成2时 自动添加选中
        if (model.isSelected == NO) {
            model.isSelected = !model.isSelected;
            //刷新单个cell
            [WeakTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            //将模型加入选中数组
            [WeakSelf.selectArray addObject:model];
            //防止剩下最后一个，全选按钮不更改问题
            if (WeakSelf.selectArray.count == WeakSelf.dataSoureArray.count) {
                WeakSelf.everyBtn.selected = YES;
            }else{
                WeakSelf.everyBtn.selected = NO;
            }
        }
        //更新点击数组点击模型
        if ([_selectArray containsObject:model]) {
            [_selectArray removeObject:model];
            [_selectArray addObject:model];
            //计算总金额
            [WeakSelf calculateTheTotalPrice];
        }
    };
    //减少按钮回调
    cell.subBlock = ^(UIButton *subBtn , NSIndexPath *indexPath){
        //取得商品现在的数量，点击加号进行count--
        int count = [WeakCell.NumLabel.text intValue];
            count --;
        //当商品小于0，进行返回
        if (count <= 0) return;
        WeakCell.NumLabel.text = [NSString stringWithFormat:@"%d",count];
        model.number = count;
       // [_dataSoureArray replaceObjectAtIndex:indexPath.row withObject:model];
       
        //更新点击数组点击模型
        if ([_selectArray containsObject:model]) {
            [_selectArray removeObject:model];
            [_selectArray addObject:model];
        }
        //计算总金额
        [WeakSelf calculateTheTotalPrice];
    };
    //选中或取消按钮回调
    cell.selectedBlock = ^(UIButton *selectedBtn , NSIndexPath *indexPath){
        model.isSelected = !model.isSelected;
        //先刷新改变ui
        [WeakTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        if (model.isSelected) {
            [WeakSelf.selectArray addObject:model];
        }else{
            [WeakSelf.selectArray removeObject:model];
        }
         //如果要是选中的和数据源一样多，就把全选按钮设置为选中
        if (WeakSelf.selectArray.count == WeakSelf.dataSoureArray.count) {
            WeakSelf.everyBtn.selected = YES;
        }else{
            WeakSelf.everyBtn.selected = NO;
        }
        [self calculateTheTotalPrice];
    };
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSoureArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
#pragma 按钮全选的情况
- (IBAction)everybtnSelected:(UIButton *)sender {
    sender.selected = !sender.selected;
    [_selectArray removeAllObjects];
    if (sender.selected) {
        //全选的情况
        for (MxModel *model in self.dataSoureArray) {
            model.isSelected = YES;
            [self.selectArray addObject:model];
        }
    }else{
        //取消全选的情况
        for (MxModel *model in self.dataSoureArray) {
            model.isSelected = NO;
        }
    }
    [self.tableView reloadData];
    [self calculateTheTotalPrice];
}

#pragma 计算总价格
- (void)calculateTheTotalPrice{
    //总价格计算
    CGFloat totalMoney;
    for (MxModel *model  in _selectArray) {
        //计算商品总价格，商品数量*商品价格
        totalMoney += model.number*model.price;
    }
    //将总价格显示
    _totleLabel.text = [NSString stringWithFormat:@"总价格%.2f",totalMoney];
    
}
#pragma 懒加载数组(数据源)
- (NSMutableArray *)dataSoureArray{
    if(_dataSoureArray == nil){
        _dataSoureArray = [[NSMutableArray alloc]init];
        for (int i = 0; i < 20; i++) {
            MxModel *model = [[MxModel alloc]init];
            //商品数量
            model.number = 1;
            //商品价格
            model.price = 300;
            //判断该cell是否进行选中
            model.isSelected = NO;
            
            model.test1 = [NSString stringWithFormat:@"%d",i];
            
            [_dataSoureArray addObject:model];
        }
    }
    return _dataSoureArray;
}
#pragma 懒加载选中数据源
- (NSMutableArray *)selectArray{
    if (_selectArray == nil) {
        _selectArray = [[NSMutableArray alloc]init];
    }
    return _selectArray;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
