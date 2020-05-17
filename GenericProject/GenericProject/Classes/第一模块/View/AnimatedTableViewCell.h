//
//  AnimatedTableViewCell.h
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2019/4/26.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import "LSBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@class Game;

@interface AnimatedTableViewCell : LSBaseTableViewCell

- (void)initWithData:(Game *)game;

@end

NS_ASSUME_NONNULL_END
