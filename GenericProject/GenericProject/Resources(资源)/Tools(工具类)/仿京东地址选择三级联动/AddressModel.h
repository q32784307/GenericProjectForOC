//
//  AddressModel.h
//  GenericProject
//
//  Created by 漠然丶情到深处 on 2019/7/10.
//  Copyright © 2019 漠然丶情到深处. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AddressModel : NSObject

@property(nonatomic,copy)NSArray *district;
@property(nonatomic,copy)NSString *zipcode;
@property(nonatomic,copy)NSString *name;

@end

NS_ASSUME_NONNULL_END
