//
//  GoodsDetailModel.m
//  MobileBusiness
//
//  Created by df on 16/4/6.
//  Copyright © 2016年 df. All rights reserved.
//

#import "GoodsDetailModel.h"
#import "MJExtension.h"


@implementation GoodsDetailModel
- (void)setValuesForKeysWithDictionary:(NSDictionary<NSString *,id> *)keyedValues {
    self.spec = keyedValues;
}
@end
