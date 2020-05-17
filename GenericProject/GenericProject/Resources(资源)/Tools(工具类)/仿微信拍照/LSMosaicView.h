//
//  LSMosaicView.h
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2019/12/10.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 马赛克类型
typedef NS_ENUM(NSUInteger, LSMosaicType) {
    /// 方块马赛克
    LSMosaicTypeSquare,
    /// 画笔涂抹
    LSMosaicTypePaintbrush
};

NS_ASSUME_NONNULL_BEGIN

/// 马赛克  画板
@interface LSMosaicView : UIView

/// 马赛克类型
@property(nonatomic,assign)LSMosaicType mosaicType;
/// 马赛克方块大小  默认15
@property(nonatomic,assign)CGFloat squareWidth;
/// 画笔涂抹大小   默认 (50, 50)
@property(nonatomic,assign)CGSize paintSize;
/// 正在涂抹
@property(nonatomic,readonly)BOOL isBrushing;
/// 开始涂抹
@property(nonatomic,copy)void(^brushBegan)(void);
/// 涂抹结束
@property(nonatomic,copy)void(^brushEnded)(void);
///某个点的颜色
@property(nonatomic,copy)UIColor *(^brushColor)(CGPoint point);

/// 数据
@property(nonatomic,strong)NSDictionary *data;

/// 是否可撤销
- (BOOL)canBack;
// 撤销
- (void)goBack;
/// 清空画板 不可恢复
- (void)clear;

@end

NS_ASSUME_NONNULL_END
