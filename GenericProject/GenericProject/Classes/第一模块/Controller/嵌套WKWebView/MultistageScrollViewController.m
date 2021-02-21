//
//  MultistageScrollViewController.m
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2019/11/26.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import "MultistageScrollViewController.h"
#import "LSMultistageScrollViewHelper.h"
#import "LSMultistageSuperScrollView.h"

@interface MultistageScrollViewController ()<UIScrollViewDelegate>

@property (nonatomic) LSMultistageSuperScrollView *firstScrollView;
@property (nonatomic) UIScrollView *secondScrollView;
@property (nonatomic) LSMultistageScrollViewHelper *scrollHelper;

@end

@implementation MultistageScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self scrollHelper];
    
    [self.view addSubview:self.firstScrollView];
    [self.firstScrollView addSubview:self.secondScrollView];
    UIView *line  = [[UIView alloc]initWithFrame:CGRectMake(0, 400, 400, 100)];
    line.backgroundColor = [UIColor greenColor];
    [self.secondScrollView addSubview:line];
}

- (void)viewDidLayoutSubviews {
    self.firstScrollView.frame = CGRectMake(0, NAVIGATION_BAR_HEIGHT, LSScreenWidth, LSScreenHeight - NAVIGATION_BAR_HEIGHT - HOME_INDICATOR_HEIGHT);
    self.firstScrollView.contentSize = CGSizeMake(self.firstScrollView.bounds.size.width, self.firstScrollView.bounds.size.height + 300);
    self.secondScrollView.frame = CGRectMake(0, 300, self.firstScrollView.bounds.size.width, self.firstScrollView.bounds.size.height);
    self.secondScrollView.contentSize = CGSizeMake(self.secondScrollView.bounds.size.width, self.secondScrollView.bounds.size.height*2);
}

-(LSMultistageSuperScrollView *)firstScrollView {
    if (!_firstScrollView) {
        _firstScrollView = [LSMultistageSuperScrollView new];
        _firstScrollView.delegate = self;
        _firstScrollView.backgroundColor = [UIColor orangeColor];
    }
    return _firstScrollView;
}


-(UIScrollView *)secondScrollView {
    if (!_secondScrollView) {
        _secondScrollView = [UIScrollView new];
        _secondScrollView.delegate = self;
        _secondScrollView.backgroundColor = [UIColor grayColor];
    }
    return _secondScrollView;
}

- (LSMultistageScrollViewHelper *)scrollHelper {
    if (!_scrollHelper) {
        _scrollHelper = [[LSMultistageScrollViewHelper alloc]initWithBaseScrollView:self.firstScrollView subScrollView:self.secondScrollView];
    }
    return _scrollHelper;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
