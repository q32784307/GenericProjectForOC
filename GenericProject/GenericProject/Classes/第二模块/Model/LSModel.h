//
//  LSModel.h
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2019/10/18.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,LSPasswordStyleType) {
    LSPasswordStyleBottomLineNormal  = 0, //下划线高亮样式明文
    LSPasswordStyleBottomLineEncrypt = 1, //下划线高亮样式密文
    LSPasswordStyleRectangleNormal   = 2, //矩形框样式明文
    LSPasswordStyleRectangleEncrypt  = 3, //矩形框样式密文
    LSPasswordStyleWithAnimating     = 4, //带动画的
};

@interface LSModel : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) LSPasswordStyleType styleType;

@end

@interface LSViewModel : NSObject

- (NSInteger)numberOfSections;

- (NSInteger)numberOfRowInSection:(NSInteger)setion;

- (LSModel *)rowModelOfIndexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
