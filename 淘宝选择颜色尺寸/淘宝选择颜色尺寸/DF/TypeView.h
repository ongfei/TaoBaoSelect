//
//  TypeView.h
//  AddShoppingCart
//
//  Created by df on 16/3/23.
//  Copyright © 2016年 df. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol TypeSeleteDelegete <NSObject>

-(void)btnindex:(UIButton *)btn isSelect:(NSInteger)select;

@end
@interface TypeView : UIView
@property(nonatomic)float height;
@property(nonatomic)int seletIndex;
@property (nonatomic,retain) id<TypeSeleteDelegete> delegate;

-(instancetype)initWithFrame:(CGRect)frame andDatasource:(NSArray *)arr :(NSString *)typename;
@end
