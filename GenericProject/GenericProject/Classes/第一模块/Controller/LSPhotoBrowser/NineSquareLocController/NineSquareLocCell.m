//
//  NineSquareLocCell.m
//  GenericProject
//
//  Created by 社科赛斯 on 2019/12/17.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import "NineSquareLocCell.h"
#import "NineSquareModel.h"

#import "LSPhotoBrowser.h"

@interface NineSquareLocCell()

@property (nonatomic, strong) NSMutableArray *imageArray;
@property (nonatomic, strong) NSMutableArray *urlArray;

@property (nonatomic, strong) NSMutableArray *itemsArr;

@end

@implementation NineSquareLocCell

- (NSMutableArray *)imageArray{
    if (!_imageArray) {
        _imageArray = [NSMutableArray array];
    }
    return _imageArray;
}

+ (instancetype)nineSquareLocCellWithTableView:(UITableView *)tableView{
    static NSString *const ID = @"nineSquareLocCellID";
    NineSquareLocCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[NineSquareLocCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews{
    for (NSInteger i = 0; i < 9; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        [imageView setUserInteractionEnabled:YES];
        [imageView setBackgroundColor:[UIColor grayColor]];
        [imageView setTag:i];
        [self.imageArray addObject:imageView];
        [self.contentView addSubview:imageView];
    }
}

- (void)setSquareM:(NineSquareModel *)squareM{
    _squareM = squareM;
    
    for (NSInteger i = squareM.urlArr.count; i < 9; i++) {
        UIImageView *imageView = [self.imageArray objectAtIndex:i];
        imageView.hidden = YES;
    }
    
    self.itemsArr = [NSMutableArray array];
    [self settingData];
}

- (void)settingData{
    
    CGFloat width = (self.contentView.frame.size.width - 40) / 3;
    
    for (NSInteger i = 0; i < _squareM.urlArr.count; i++) {
        UIImageView *imageView = [self.imageArray objectAtIndex:i];
        [imageView setHidden:NO];
        NineSquareUrlModel *urlModel = [_squareM.urlArr objectAtIndex:i];
        imageView.image = urlModel.img;
        NSInteger row = i / 3;
        NSInteger col = i % 3;
        CGFloat x = 10 + col * (10 + width);
        CGFloat y = 10 + row * (10 + width);
        imageView.frame = CGRectMake(x, y, width, width);
        [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewIBAction:)]];
        /****************************** == 添加 控件和url == ********************************/
        LSPhotoItems *items = [[LSPhotoItems alloc] init];
        items.sourceView = imageView;
        [self.itemsArr addObject:items];
    }
    
    switch (_squareM.urlArr.count) {
        case 1:
        case 2:
        case 3:
            _cellHeight = width + 20;
            break;
        case 4:
        case 5:
        case 6:
            _cellHeight = (width + 20) * 2;
            break;
        case 7:
        case 8:
        case 9:
            _cellHeight = (width + 20) * 3;
            break;
        default:
            break;
    }
}

- (void)imageViewIBAction:(UITapGestureRecognizer *)tap{
    LSPhotoBrowser *photoBrowser = [[LSPhotoBrowser alloc] init];
    photoBrowser.itemsArr = [self.itemsArr copy];
    photoBrowser.currentIndex = tap.view.tag;
    photoBrowser.isNeedPageControl = true;
    photoBrowser.isNeedPageNumView = true;
    photoBrowser.isNeedRightTopBtn = true;
    photoBrowser.isNeedPictureLongPress = true;
    [photoBrowser present];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
