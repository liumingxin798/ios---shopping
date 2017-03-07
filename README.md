# -test
一个超详细购物车的教程

//将演示下载里面的注释让你每一步都能看懂的
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
