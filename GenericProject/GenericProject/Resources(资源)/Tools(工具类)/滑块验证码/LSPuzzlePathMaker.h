//
//  LSPuzzlePathMaker.h
//  GenericProject
//
//  Created by 社科赛斯 on 2019/12/12.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class LSPuzzlePathMaker;

typedef NS_ENUM(NSInteger, LSPathMirrorAxis) {
    LSPathMirrorAxisX,  // x 轴镜像
    LSPathMirrorAxisY   // y 轴镜像
};

@interface LSPuzzlePathMaker : NSObject

/** 原始路径 */
@property(nonatomic,strong)UIBezierPath *path;

/** 移动画笔至点 */
@property(nonatomic,copy)LSPuzzlePathMaker *(^moveTo)(CGFloat x, CGFloat y);
/** 添加直线 */
@property(nonatomic,copy)LSPuzzlePathMaker *(^addLineTo)(CGFloat x, CGFloat y);
/** 添加一次贝塞尔曲线 */
@property(nonatomic,copy)LSPuzzlePathMaker *(^addQuadCurveTo)(CGFloat endX, CGFloat endY, CGFloat controlX, CGFloat controlY);
/** 添加二次贝塞尔曲线 */
@property(nonatomic,copy)LSPuzzlePathMaker *(^addCurveTo)(CGFloat endX, CGFloat endY, CGFloat controlX1, CGFloat controlY1, CGFloat controlX2, CGFloat controlY2);
/** 添加弧线 */
@property(nonatomic,copy)LSPuzzlePathMaker *(^addArcWithCenter)(CGFloat centerX, CGFloat centerY, CGFloat radius, CGFloat startAngle, CGFloat endAngle, BOOL clockwise);
@property(nonatomic,copy)LSPuzzlePathMaker *(^addArcWithPoint)(CGFloat startX, CGFloat startY, CGFloat endX, CGFloat endY, CGFloat radius, BOOL clockwise, BOOL moreThanHalf);
/** 闭合曲线 */
@property(nonatomic,copy)LSPuzzlePathMaker *(^closePath)(void);
/**
 添加正弦曲线
 
 @param A 振幅
 @param Omega 角速度
 @param Phi 相位差
 @param K 偏移量
 @param deltaX 曲线横向长度
 */
@property(nonatomic,copy)LSPuzzlePathMaker *(^addSin)(CGFloat A, CGFloat Omega, CGFloat Phi, CGFloat K, CGFloat deltaX);
/** 镜像曲线 */
@property(nonatomic,copy)LSPuzzlePathMaker *(^mirror)(LSPathMirrorAxis axis, CGFloat x, CGFloat y, CGFloat width, CGFloat height);
/** 保证图形区域中心不变以比例形式缩放路径 */
@property(nonatomic,copy)LSPuzzlePathMaker *(^scale)(CGFloat scale);
/** 保证图形区域中心不变以角度旋转路径 */
@property(nonatomic,copy)LSPuzzlePathMaker *(^rotate)(CGFloat angle);
/** 平移路径 */
@property(nonatomic,copy)LSPuzzlePathMaker *(^translate)(CGFloat offsetX, CGFloat offsetY);
/** 移动路径至原点 */
@property(nonatomic,copy)LSPuzzlePathMaker *(^moveToOrigin)(void);

/** 快捷初始化 */
- (instancetype)initWithBezierPath:(UIBezierPath *)path NS_DESIGNATED_INITIALIZER;
+ (instancetype)makerWithBezierPath:(UIBezierPath *)path;

@end

NS_ASSUME_NONNULL_END
