//
//  CheckVerifyCodeView.m
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2019/4/17.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import "CheckVerifyCodeView.h"
#import "CheckVerifyCodeCell.h"

// 验证码的长度
static NSInteger const kVerifyCodeLength = 6;
// cell复用ID
static NSString * const kCellReuseID = @"kCellReuseID";
// cell间距
static CGFloat const kCellSpacing = 17;

@interface CheckVerifyCodeView () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

/** 用来接收用户输入的验证码 */
@property(nonatomic,strong)UITextField *textField;
/** 横向collectionView，用来展示用来输入的验证码 */
@property(nonatomic,strong)UICollectionView *collectionView;

@property(nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation CheckVerifyCodeView

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
        // 默认6个空字符
        for (int i = 0; i < kVerifyCodeLength; i++) {
            [_dataArray addObject:@""];
        }
    }
    return _dataArray;
}

- (NSString *)verifyCode {
    return self.textField.text;
}

#pragma mark - init & dealloc

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // 如果使用了IQKeyboardManager，建议此处隐藏其Toolbar
        // [[IQKeyboardManager sharedManager] setEnableAutoToolbar:NO];
        [self setupUI];
    }
    return self;
}

- (void)dealloc {
    // [[IQKeyboardManager sharedManager] setEnableAutoToolbar:YES];
}

#pragma mark - UI

- (void)setupUI {
    // textField放下面
    self.textField = [[UITextField alloc] init];
    [self addSubview:self.textField];
    self.textField.keyboardType = UIKeyboardTypeNumberPad;
    [self.textField addTarget:self action:@selector(textFieldTextChanged) forControlEvents:UIControlEventEditingChanged];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    
    // collectionView放上面
    UICollectionViewFlowLayout *normalLayout = [[UICollectionViewFlowLayout alloc] init];
    normalLayout.itemSize = CGSizeMake(30, 40);
    normalLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:normalLayout];
    [self addSubview:self.collectionView];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    [self.collectionView registerClass:[CheckVerifyCodeCell class] forCellWithReuseIdentifier:kCellReuseID];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
}

#pragma mark - 开始输入 & 结束输入

- (void)startInput {
    [self.textField becomeFirstResponder];
}

- (void)endInput {
    [self.textField resignFirstResponder];
}

#pragma mark - 重置

- (void)reset {
    self.textField.text = @"";
    self.dataArray = nil;
    [self.collectionView reloadData];
}

#pragma mark - 文本改变时回调

- (void)textFieldTextChanged {
    // 限制输入长度
    if (self.textField.text.length > kVerifyCodeLength) {
        self.textField.text = [self.textField.text substringToIndex:kVerifyCodeLength];
        return;
    }
    
    [self.dataArray removeAllObjects];
    
    // 遍历字符串，加入数据源数组
    for(int i =0; i < [self.textField.text length]; i++)
    {
        NSString *a = [self.textField.text substringWithRange:NSMakeRange(i, 1)];
        [self.dataArray addObject:a];
    }
    
    // 数据源数组空余部分用空字符串补充
    for (NSInteger i = self.textField.text.length; i < kVerifyCodeLength; i++) {
        [self.dataArray addObject:@""];
    }
    
    [self.collectionView reloadData];
    
    // 输入完成回调
    if (self.textField.text.length == kVerifyCodeLength) {
        !self.inputCompletion ?: self.inputCompletion(self.textField.text);
    }
}

#pragma mark - UICollectionView DataSource & Delegate

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CheckVerifyCodeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellReuseID forIndexPath:indexPath];
    cell.code = self.dataArray[indexPath.row];
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

// 设置每个组的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

// item间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return kCellSpacing;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
