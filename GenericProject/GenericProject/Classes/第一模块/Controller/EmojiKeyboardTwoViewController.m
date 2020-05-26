//
//  EmojiKeyboardTwoViewController.m
//  GenericProject
//
//  Created by 社科赛斯 on 2020/5/26.
//  Copyright © 2020 漠然丶情到深处. All rights reserved.
//

#import "EmojiKeyboardTwoViewController.h"
#import "EmojiKeyboardTwoTableViewCell.h"
#import "InputBar.h"
#import "YBEmojiInputView.h"

@interface DataModel : NSObject

@property (nonatomic, assign) CGFloat cell_h;

@property (nonatomic, strong) id text;

@property (nonatomic, strong) UIImage *image;

- (instancetype)initWith:(id)text;

@end

@implementation DataModel

- (instancetype)initWith:(id)text {
    if (self = [super init]) {
        self.text = text;
    }
    return self;
}

- (void)setText:(id)text {
    _text = text;
    self.cell_h = [self cellHeighWith:text];
}

- (CGFloat)cellHeighWith:(id)sender {
    // cell 上label的宽为屏幕宽度 - 20
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width - 20, CGFLOAT_MAX)];
    label.numberOfLines = 0;
    if ([sender isKindOfClass:[NSString class]]) {
        label.font = [UIFont systemFontOfSize:17];
        label.text = sender;
    }
    if ([sender isKindOfClass:[NSAttributedString class]]) {
        label.attributedText = sender;
    }
    [label sizeToFit];
    return ceilf(label.frame.size.height);
}

- (void)setImage:(UIImage *)image {
    _image = image;
    self.cell_h = 100;
}

@end

@interface EmojiKeyboardTwoViewController ()<UITextViewDelegate, YBEmojiInputViewDelegate>

@property (nonatomic, strong) NSMutableArray<DataModel *> *dataSource;

@property (nonatomic, strong) InputBar *inputBar;

@property (nonatomic, assign) BOOL isIphoneX;

@property (nonatomic, strong) YBEmojiInputView *emojiKeyboard;

@property (nonatomic, strong) NSDictionary *attributes;

@end

@implementation EmojiKeyboardTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    self.dataSource = [NSMutableArray array];
    self.attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:17]};
    
    self.inputBar = [[InputBar alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - 55, self.view.bounds.size.width, 55)];
    [self.inputBar.emojiBtn addTarget:self action:@selector(clickedEmoji:) forControlEvents:UIControlEventTouchUpInside];
    [self.inputBar.sendBtn addTarget:self action:@selector(clickedSend:) forControlEvents:UIControlEventTouchUpInside];
    self.inputBar.textView.delegate = self;
    [self.view addSubview:self.inputBar];
    
    self.mainTableView.frame = CGRectMake(0, NAVIGATION_BAR_HEIGHT, ScreenWidth, ScreenHeight - NAVIGATION_BAR_HEIGHT - CGRectGetHeight(self.inputBar.frame));
    [self.view addSubview:self.mainTableView];

    YBEmojiConfig *config = [[YBEmojiConfig alloc] init];
    self.emojiKeyboard = [[YBEmojiInputView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 230) config:config delegate:self];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    // label 距离上下为h之和为20, 多加1为了协调在输入表情的时候高度计算会不正确的问题, 会导致显示 ...
    return self.dataSource[indexPath.row].cell_h + 21;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EmojiKeyboardTwoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EmojiKeyboardTwoTableViewCell"];
    if (!cell) {
        cell = [[EmojiKeyboardTwoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"EmojiKeyboardTwoTableViewCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.numberOfLines = 0;
    }
    DataModel *model = self.dataSource[indexPath.row];
    if (model.image) {
        cell.contentImageView.image = model.image;
        cell.contentLabel.hidden = YES;
        cell.contentImageView.hidden = NO;
    }else {
        if ([model.text isKindOfClass:[NSAttributedString class]]) {
            cell.contentLabel.attributedText = model.text;
        }else {
            cell.contentLabel.text = model.text;
        }
        cell.contentImageView.hidden = YES;
        cell.contentLabel.hidden = NO;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.view endEditing:YES];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (![scrollView isKindOfClass:[UITextView class]]) {
        [self.view endEditing:YES];
    }
}

#pragma mark - InputBarButtonClick
- (void)clickedEmoji:(UIButton *)sender {
    if (self.inputBar.textView.inputView == nil) {
        self.inputBar.textView.inputView = self.emojiKeyboard;
        [sender setImage:[UIImage imageNamed:@"btn_chat_input_keyborad"] forState:UIControlStateNormal];
    }else {
        self.inputBar.textView.inputView = nil;
        [sender setImage:[UIImage imageNamed:@"btn_chat_input_emoji"] forState:UIControlStateNormal];
    }
    [self.inputBar.textView reloadInputViews];
    [self.inputBar.textView becomeFirstResponder];
}

- (void)clickedSend:(UIButton *)sender {
    if (self.inputBar.textView.attributedText.length == 0) {
        return;
    }
    [self sendToTableView];
}

#pragma mark - UITextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    // 设置输入汉字拼音未确定状态的文字样式
    textView.typingAttributes = self.attributes;
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    textView.typingAttributes = self.attributes;
}

- (void)textViewDidChange:(UITextView *)textView {
    textView.typingAttributes = self.attributes;
    if (!textView.markedTextRange) {
        NSRange selectedRange = textView.selectedRange;
        NSAttributedString *attributedString = [YBEmojiDataManager.manager replaceEmojiWithAttributedString:textView.attributedText attributes:self.attributes];
        NSUInteger offset = textView.attributedText.length - attributedString.length;
        textView.attributedText = attributedString;
        textView.selectedRange = NSMakeRange(selectedRange.location - offset, 0);
    }else {
        // 输入汉字拼音未确定状态, 不做处理
    }
    [self refreshUIWith:textView];
}

- (void)refreshUIWith:(UITextView *)textView {
    CGFloat heigh = [textView sizeThatFits:CGSizeMake(textView.frame.size.width, MAXFLOAT)].height + 20;
    heigh = heigh < 55 ? 55 : heigh;
    heigh = heigh > 100 ? 100 : heigh;
    textView.scrollEnabled = heigh >= 100;
    CGFloat max_y = CGRectGetMaxY(self.inputBar.frame);
    CGFloat min_y = max_y - heigh;
    CGFloat top = self.isIphoneX ? 88 : 64;
    
    [UIView animateWithDuration:0.25 animations:^{
        self.inputBar.frame = CGRectMake(0, min_y, self.view.bounds.size.width, heigh);
        self.mainTableView.frame = CGRectMake(0, top, self.view.frame.size.width, min_y - top);
        if (self.dataSource.count > 0) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.dataSource.count-1 inSection:0];
            [self.mainTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:NO];
        }
    }];
}

#pragma mark - YBEmojiInputViewDelegate
// 点击表情
- (void)inputView:(YBEmojiInputView *)inputView clickedEmojiWith:(YBEmojiItemModel *)emoji {
    NSRange selectedRange = self.inputBar.textView.selectedRange;
    NSAttributedString *emojiAttributedString = [[NSAttributedString alloc] initWithString:emoji.desc];
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithAttributedString:self.inputBar.textView.attributedText];
    [attributedText replaceCharactersInRange:selectedRange withAttributedString:emojiAttributedString];
    self.inputBar.textView.attributedText = attributedText;
    self.inputBar.textView.selectedRange = NSMakeRange(selectedRange.location + emojiAttributedString.length, 0);
    [self textViewDidChange:self.inputBar.textView];
}

// 点击大表情
- (void)inputView:(YBEmojiInputView *)inputView clickedBigEmojiWith:(YBEmojiItemModel *)emoji {
    DataModel *model = [[DataModel alloc] init];
    model.image = emoji.gifImage;
    [self.dataSource addObject:model];
    [self.mainTableView reloadData];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.dataSource.count-1 inSection:0];
    [self.mainTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:NO];
}

// 点击删除
- (void)inputView:(YBEmojiInputView *)inputView clickedDeleteWith:(UIButton *)button {
    NSRange selectedRange = self.inputBar.textView.selectedRange;
    if (selectedRange.location == 0 && selectedRange.length == 0) {
        return;
    }
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithAttributedString:self.inputBar.textView.attributedText];
    if (selectedRange.length > 0) {
        [attributedText deleteCharactersInRange:selectedRange];
        self.inputBar.textView.attributedText = attributedText;
        self.inputBar.textView.selectedRange = NSMakeRange(selectedRange.location, 0);
    } else {
        NSUInteger deleteCharactersCount = 1;
        // 下面这段正则匹配是用来匹配文本中的所有系统自带的 emoji 表情，以确认删除按钮将要删除的是否是 emoji。这个正则匹配可以匹配绝大部分的 emoji，得到该 emoji 的正确的 length 值；不过会将某些 combined emoji（如 👨‍👩‍👧‍👦 👨‍👩‍👧‍👦 👨‍👨‍👧‍👧），这种几个 emoji 拼在一起的 combined emoji 则会被匹配成几个个体，删除时会把 combine emoji 拆成个体。瑕不掩瑜，大部分情况下表现正确，至少也不会出现删除 emoji 时崩溃的问题了。
        NSString *emojiPattern1 = @"[\\u2600-\\u27BF\\U0001F300-\\U0001F77F\\U0001F900-\\U0001F9FF]";
        NSString *emojiPattern2 = @"[\\u2600-\\u27BF\\U0001F300-\\U0001F77F\\U0001F900–\\U0001F9FF]\\uFE0F";
        NSString *emojiPattern3 = @"[\\u2600-\\u27BF\\U0001F300-\\U0001F77F\\U0001F900–\\U0001F9FF][\\U0001F3FB-\\U0001F3FF]";
        NSString *emojiPattern4 = @"[\\rU0001F1E6-\\U0001F1FF][\\U0001F1E6-\\U0001F1FF]";
        NSString *pattern = [[NSString alloc] initWithFormat:@"%@|%@|%@|%@", emojiPattern4, emojiPattern3, emojiPattern2, emojiPattern1];
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:kNilOptions error:NULL];
        NSArray<NSTextCheckingResult *> *matches = [regex matchesInString:attributedText.string options:kNilOptions range:NSMakeRange(0, attributedText.string.length)];
        for (NSTextCheckingResult *match in matches) {
            if (match.range.location + match.range.length == selectedRange.location) {
                deleteCharactersCount = match.range.length;
                break;
            }
        }
        [attributedText deleteCharactersInRange:NSMakeRange(selectedRange.location - deleteCharactersCount, deleteCharactersCount)];
        self.inputBar.textView.attributedText = attributedText;
        self.inputBar.textView.selectedRange = NSMakeRange(selectedRange.location - deleteCharactersCount, 0);
    }
    [self textViewDidChange:self.inputBar.textView];
}

// 点击发送
- (void)inputView:(YBEmojiInputView *)inputView clickedSendWith:(UIButton *)button {
    if (self.inputBar.textView.attributedText.length == 0) {
        return;
    }
    [self sendToTableView];
}

- (void)sendToTableView {
    NSAttributedString *attributedString = self.inputBar.textView.attributedText;
    NSString *string = [YBEmojiDataManager.manager plainStringWith:attributedString range:NSMakeRange(0, attributedString.length)];
    //显示表情
    [self.dataSource addObject:[[DataModel alloc] initWith:attributedString]];
    //显示表情名字
//    [self.dataSource addObject:[[DataModel alloc] initWith:string]];
    [self.mainTableView reloadData];
    UITextRange *textRange = [self.inputBar.textView textRangeFromPosition:self.inputBar.textView.beginningOfDocument toPosition:self.inputBar.textView.endOfDocument];
    [self.inputBar.textView replaceRange:textRange withText:@""];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.dataSource.count-1 inSection:0];
        [self.mainTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    });
}

#pragma mark - UIKeyboardNotification
- (void)keyboardWillShow:(NSNotification *)aNotification {
    CGFloat top = self.isIphoneX ? 88 : 64;
    double duration = [aNotification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGFloat keyboard_h = [aNotification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    [UIView animateWithDuration:duration animations:^{
        self.inputBar.frame = CGRectMake(0, self.view.bounds.size.height - keyboard_h - CGRectGetHeight(self.inputBar.frame), self.view.bounds.size.width, CGRectGetHeight(self.inputBar.frame));
        self.mainTableView.frame = CGRectMake(0, top, self.view.bounds.size.width, self.view.bounds.size.height - top - CGRectGetHeight(self.inputBar.frame) - keyboard_h);
    }];
    if (self.dataSource.count > 0) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.dataSource.count-1 inSection:0];
        [self.mainTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
}

- (void)keyboardWillHide:(NSNotification *)aNotification {
    CGFloat top = self.isIphoneX ? 88 : 64;
    double duration = [aNotification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        self.inputBar.frame = CGRectMake(0, self.view.bounds.size.height - 60, self.view.bounds.size.width, 60);
        self.mainTableView.frame = CGRectMake(0, top, self.view.bounds.size.width, self.view.bounds.size.height - top - CGRectGetHeight(self.inputBar.frame));
    }];
}

- (BOOL)isIphoneX {
    return UIScreen.mainScreen.bounds.size.height >= 812;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    NSLog(@"%s", __func__);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
