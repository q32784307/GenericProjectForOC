//
//  LSBaseTagViewModel.h
//  GenericProject
//
//  Created by 社科赛斯 on 2019/12/12.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LSBaseTagViewModel : NSObject

@property(nonatomic,copy)NSString *Id;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,assign)BOOL isSelected;
@property(nonatomic,strong)UIImage *titleImage;  // 标题图片
@property(nonatomic,strong)UIImage *selectedTitleImage;  // 选中标题图片

@end

NS_ASSUME_NONNULL_END
