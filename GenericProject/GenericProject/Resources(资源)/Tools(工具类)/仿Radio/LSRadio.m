//
//  LSRadio.m
//  GenericProject
//
//  Created by 社科塞斯 on 2020/8/11.
//  Copyright © 2020 漠然丶情到深处. All rights reserved.
//

#import "LSRadio.h"

@interface LSRadio()

@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *val;

@end

@implementation LSRadio

+ (LSRadio *)creatRadioWithName:(NSString *)name val:(NSString *)val selected:(BOOL)selected{
    LSRadio *radio = [LSRadio buttonWithType:UIButtonTypeCustom];
    [radio setImage:[UIImage imageNamed:@"unSelectRadio"]  forState:UIControlStateNormal];
    [radio setImage:[UIImage imageNamed:@"selectRadio"] forState:UIControlStateSelected];
    [radio setTitle:[NSString stringWithFormat:@"  %@",name] forState:UIControlStateNormal];
    [radio setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
    radio.name = name;
    radio.val  = val;
    radio.selected = selected;
    radio.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    return radio;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
