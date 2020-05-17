//
//  SearchBarView.h
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2018/7/20.
//  Copyright © 2018年 漠然丶情到深处. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SearchDelegate <NSObject>

- (void)searchWithStr:(NSString *)text;

@end

@interface SearchBarView : UIView

@property(nonatomic,copy)NSString *Placeholder;
@property(nonatomic,strong)UIColor *CursorColor;
@property(nonatomic,weak) id<SearchDelegate> SearchDelegate;

@end
