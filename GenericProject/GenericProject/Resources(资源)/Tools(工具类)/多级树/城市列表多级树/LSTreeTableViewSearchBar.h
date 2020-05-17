//
//  LSTreeTableViewSearchBar.h
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2019/12/5.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LSTreeTableViewSearchBar;
@protocol LSTreeTableViewSearchBarDelegate <NSObject>

/** 点击搜索框 - 用于埋点 */
- (void)treeTableViewSearchBarDidBeginEditing:(LSTreeTableViewSearchBar *)searchBar;
/** 点击搜索键 */
- (void)treeTableViewSearchBarShouldReturn:(LSTreeTableViewSearchBar *)searchBar;
/** 实时查询搜索框中的文字 */
- (void)treeTableViewSearchBarDidEditing:(LSTreeTableViewSearchBar *)searchBar;

@end

NS_ASSUME_NONNULL_BEGIN

@interface LSTreeTableViewSearchBar : UIView

@property(nonatomic,weak)id<LSTreeTableViewSearchBarDelegate> delegate;
@property(nonatomic,copy,readonly)NSString *text;  // 获取当前搜索框中的文字
- (void)resignFirstResponder;  // 落下键盘

@end

NS_ASSUME_NONNULL_END
