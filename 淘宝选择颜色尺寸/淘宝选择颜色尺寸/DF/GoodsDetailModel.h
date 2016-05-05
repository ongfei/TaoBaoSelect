//
//  GoodsDetailModel.h
//  MobileBusiness
//
//  Created by df on 16/4/6.
//  Copyright © 2016年 df. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoodsDetailModel : NSObject
/**
 *  轮播图
 */
@property (nonatomic, strong) NSArray *productImageList;
/**
 *  轮播图字符串
 */
@property (nonatomic, copy) NSString *images;
/**
 *  尺寸图
 */
@property (nonatomic, copy) NSString *picture;
/**
 *  商品名
 */
@property (nonatomic, copy) NSString *name;
/**
 *  优先显示的商品名
 */
@property (nonatomic, copy) NSString *introduce;
/**
 *  原价
 */
@property (nonatomic, copy) NSString *price;
/**
 *  现价
 */
@property (nonatomic, copy) NSString *nowPrice;
/**
 *  图文详情
 */
@property (nonatomic, copy) NSString *productHTML;
/**
 *  销量
 */
@property (nonatomic, assign) NSInteger sellcount;
/**
 *  库存
 */
@property (nonatomic, assign) NSInteger stock;
/**
 *  积分
 */
@property (nonatomic ,strong) NSString *score;
/**
 *  尺寸
 */
@property (nonatomic, strong) NSArray *specSize;
/**
 *  颜色
 */
@property (nonatomic, strong) NSArray *specColor;
/**
 *  尺寸颜色对应的价格
 */
@property (nonatomic, copy) NSDictionary *spec;
/**
 *  赠品
 */
@property (nonatomic, strong) NSDictionary *gift;
/**
 *  图文中的文字
 */
@property (nonatomic, strong) NSArray *parameterList;

@end
