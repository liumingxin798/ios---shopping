购物车

一个超详细购物车的教程


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
