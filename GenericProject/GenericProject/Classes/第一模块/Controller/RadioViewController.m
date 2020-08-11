//
//  RadioViewController.m
//  GenericProject
//
//  Created by 社科塞斯 on 2020/8/11.
//  Copyright © 2020 漠然丶情到深处. All rights reserved.
//

#import "RadioViewController.h"
#import "LSRadioGroup.h"
#import "LSRadio.h"

@interface RadioViewController ()

@end

@implementation RadioViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 300, 200, 30)];
    [self.view addSubview:label];
    
    LSRadio *radio1 = [LSRadio creatRadioWithName:@"苹果" val:@"1" selected:YES];
    radio1.frame = CGRectMake(20, 100, 100, 30);
    LSRadio *radio2 = [LSRadio creatRadioWithName:@"梨子" val:@"2" selected:NO];
    radio2.frame = CGRectMake(20, 140, 100, 30);
    LSRadio *radio3 = [LSRadio creatRadioWithName:@"香蕉" val:@"3" selected:NO];
    radio3.frame = CGRectMake(20, 180, 100, 30);
    [LSRadioGroup onView:self.view select:^(LSRadio *radio) {
        label.text = [NSString stringWithFormat:@"name:%@  val:%@",radio.name,radio.val];
    } radios:radio1,radio2,radio3,nil];
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
