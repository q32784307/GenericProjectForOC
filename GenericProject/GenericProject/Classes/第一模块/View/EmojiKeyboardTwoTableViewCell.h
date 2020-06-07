//
//  EmojiKeyboardTwoTableViewCell.h
//  GenericProject
//
//  Created by 社科赛斯 on 2020/5/26.
//  Copyright © 2020 漠然丶情到深处. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YBEmojiGifImageView.h"

NS_ASSUME_NONNULL_BEGIN

@interface EmojiKeyboardTwoTableViewCell : UITableViewCell

@property(nonatomic,strong)UILabel *contentLabel;
@property(nonatomic,strong)YBEmojiGifImageView *contentImageView;

@end

NS_ASSUME_NONNULL_END
