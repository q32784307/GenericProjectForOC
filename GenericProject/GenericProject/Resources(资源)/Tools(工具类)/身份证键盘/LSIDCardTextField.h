//
//  LSIDCardTextField.h
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2019/12/6.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LSIDCardTextField : UITextField

/**
 *  使用了键盘头部工具条，调整了键盘的高度
 */
@property(nonatomic,assign)BOOL adjustTextFeildH;
/** X按钮 */
@property(nonatomic,strong)UIButton *doneButton;

@end

NS_ASSUME_NONNULL_END
