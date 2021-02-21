//
//  AddressTableView.m
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2019/7/10.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#define RGB(r, g, b)  [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]

#import "AddressTableView.h"
#import "AddressModel.h"

@implementation AddressTableView

- (instancetype)initWithFrame:(CGRect)frame withParmas:(id)params {
    self = [super initWithFrame:frame];
    if (self) {
        self.datas = params;
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        
        [self addSubview:_tableView];
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellName = @"cellid";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellName];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    AddressModel *oneModel = self.datas[indexPath.row];
    cell.textLabel.text = oneModel.name;
    
    if (self.indexRow && self.indexRow.integerValue == indexPath.row) {
        cell.textLabel.textColor = [UIColor colorWithHexString:@"FDDE4C"];;
    }else{
        cell.textLabel.textColor = LSBlackColor;
    }
    
    cell.textLabel.font = LSSystemFont(LSSYRealValue(28 / 2));
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.indexRow = [NSString stringWithFormat:@"%ld",indexPath.row];
    
    [tableView reloadData];
    
    if (self.block) {
        self.block(indexPath.row);
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
