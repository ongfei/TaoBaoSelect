//
//  ViewController.m
//  淘宝选择颜色尺寸
//
//  Created by df on 16/5/4.
//  Copyright © 2016年 df. All rights reserved.
//

#import "ViewController.h"
#import "ChoseView.h"
#import "GoodsDetailModel.h"
#import "MJExtension.h"

@interface ViewController ()<TypeSeleteDelegete>
@property (nonatomic, strong) ChoseView *choseView;
@property (nonatomic, strong)GoodsDetailModel *goodsDM;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"goods" ofType:nil]] options:(NSJSONReadingMutableContainers) error:nil];
    self.goodsDM = [GoodsDetailModel mj_objectWithKeyValues:dic];
    
    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    btn.frame = CGRectMake(100, 100, 100, 100);
    [btn setTitle:@"选择!!!!!" forState:(UIControlStateNormal)];
    [btn addTarget:self action:@selector(btnselete) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:btn];

}

-(void)btnselete
{
    _choseView = [[ChoseView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:_choseView];
    //尺码
    _choseView.sizeView = [[TypeView alloc] initWithFrame:CGRectMake(0, 0, _choseView.frame.size.width, 50) andDatasource:self.goodsDM.specSize :@"尺码"];
    _choseView.sizeView.delegate = self;
    [_choseView.mainscrollview addSubview:_choseView.sizeView];
    _choseView.sizeView.frame = CGRectMake(0, 0, _choseView.frame.size.width, _choseView.sizeView.height);
    //颜色分类
    _choseView.colorView = [[TypeView alloc] initWithFrame:CGRectMake(0, _choseView.sizeView.frame.size.height, _choseView.frame.size.width, 50) andDatasource:self.goodsDM.specColor :@"颜色分类"];
    _choseView.colorView.delegate = self;
    [_choseView.mainscrollview addSubview:_choseView.colorView];
    _choseView.colorView.frame = CGRectMake(0, _choseView.sizeView.frame.size.height, _choseView.frame.size.width, _choseView.colorView.height);
    //购买数量
    _choseView.countView.frame = CGRectMake(0, _choseView.colorView.frame.size.height+_choseView.colorView.frame.origin.y, _choseView.frame.size.width, 50);
    _choseView.mainscrollview.contentSize = CGSizeMake(self.view.frame.size.width, _choseView.countView.frame.size.height+_choseView.countView.frame.origin.y);
    
    _choseView.lb_stock.text = [NSString stringWithFormat:@"库存%ld件",(long)self.goodsDM.stock];
    _choseView.lb_detail.text = [NSString stringWithFormat:@"单价: \"%@\"",self.goodsDM.price];
    
    
    [_choseView.bt_cancle addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [_choseView.bt_sureAdd addTarget:self action:@selector(addGoodsClick:) forControlEvents:UIControlEventTouchUpInside];
    [_choseView.bt_sureBuy addTarget:self action:@selector(addGoodsClick:) forControlEvents:UIControlEventTouchUpInside];
    
    //点击黑色透明视图choseView会消失
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    [_choseView.alphaiView addGestureRecognizer:tap];
    //点击图片放大图片
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showBigImage:)];
    _choseView.img.userInteractionEnabled = YES;
    [_choseView.img addGestureRecognizer:tap1];
    
    
    __weak typeof(self) weakself = self;
    [UIView animateWithDuration: 0.35 animations: ^{
        _choseView.frame = CGRectMake(0, 0, weakself.view.frame.size.width, weakself.view.frame.size.height);
    } completion: nil];
    
    
}
- (void)addGoodsClick:(UIButton *)btn {
    if (self.choseView.sizeView.seletIndex < 0 || self.choseView.sizeView.seletIndex > self.goodsDM.specSize.count || self.choseView.colorView.seletIndex < 0 || self.choseView.colorView.seletIndex > self.goodsDM.specColor.count) {
//        [MBHelper addHUDInView:self.view text:@"请先选择颜色尺寸" hideAfterDelay:2];
    }else {
        NSLog(@"%@  --- %@",self.goodsDM.specSize[self.choseView.sizeView.seletIndex],self.goodsDM.specColor[self.choseView.colorView.seletIndex]);
#pragma mark - 显示到tableview上
//        UITableViewCell *cell = [self.detaiTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:TWO_]];
//        cell.textLabel.text = [NSString stringWithFormat:@"已选择:%@%@",self.goodsDM.specSize[self.choseView.sizeView.seletIndex],self.goodsDM.specColor[self.choseView.colorView.seletIndex]];
        if ([btn.currentTitle isEqualToString:@"加入购物车"]) {
#pragma mark - 添加到购物车
            [self dismiss];
        }else {
#pragma mark - 立即购买
            [self dismiss];
        }
    }
    
}
-(void)dismiss
{
    __weak typeof(self) weakself = self;
    [UIView animateWithDuration: 0.35 animations: ^{
        _choseView.frame =CGRectMake(0, weakself.view.frame.size.height, weakself.view.frame.size.width, weakself.view.frame.size.height);
    } completion:^(BOOL finished) {
        [_choseView removeFromSuperview];
        _choseView = nil;
    }];
    
}

-(void)btnindex:(UIButton *)btn isSelect:(NSInteger)select {
    //通过seletIndex是否>=0来判断尺码和颜色是否被选择，－1则是未选择状态
    if (_choseView.sizeView.seletIndex >=0&&_choseView.colorView.seletIndex >=0) {
        //尺码和颜色都选择的时候
        NSString *size =[self.goodsDM.specSize objectAtIndex:_choseView.sizeView.seletIndex];
        NSString *color =[self.goodsDM.specColor objectAtIndex:_choseView.colorView.seletIndex];
        NSArray *arrcolor = [self.goodsDM.spec objectForKey:color];
        for (NSDictionary *dic in arrcolor) {
            if ([dic[@"specSize"] isEqualToString:btn.currentTitle]) {
                _choseView.lb_stock.text = [NSString stringWithFormat:@"库存%@件",dic[@"specStock"]];
                _choseView.lb_detail.text = [NSString stringWithFormat:@"单价: \"%@\"",dic[@"specPrice"]];
                _choseView.stock = [dic[@"specStock"] intValue];
            }
        }
        NSArray *arrsize = [self.goodsDM.spec objectForKey:size];
        for (NSDictionary *dic in arrsize) {
            if ([dic[@"specColor"] isEqualToString:btn.currentTitle]) {
                _choseView.lb_stock.text = [NSString stringWithFormat:@"库存%@件",dic[@"specStock"]];
                _choseView.lb_detail.text = [NSString stringWithFormat:@"单价: %@元",dic[@"specPrice"]];
                _choseView.stock = [dic[@"specStock"] intValue];
            }
        }
        
        [self reloadTypeBtn:[self.goodsDM.spec objectForKey:size] arr:self.goodsDM.specColor view:_choseView.colorView];
        [self reloadTypeBtn:[self.goodsDM.spec objectForKey:color] arr:self.goodsDM.specSize view:_choseView.sizeView];
        //        NSLog(@"%d",_choseView.colorView.seletIndex);
        //        NSLog(@"%@",str);
        _choseView.img.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg",_choseView.colorView.seletIndex+1]];
    }else if (_choseView.sizeView.seletIndex ==-1&&_choseView.colorView.seletIndex == -1)
    {
        //尺码和颜色都没选的时候
        _choseView.lb_stock.text =[NSString stringWithFormat:@"库存%ld件", (long)self.goodsDM.stock];
        _choseView.lb_detail.text = @"请选择 尺码 颜色分类";
        _choseView.stock = (int)self.goodsDM.stock;
        //全部恢复可点击状态
        [self resumeBtn:self.goodsDM.specColor :_choseView.colorView];
        [self resumeBtn:self.goodsDM.specSize :_choseView.sizeView];
        
    }else if (_choseView.sizeView.seletIndex ==-1&&_choseView.colorView.seletIndex >= 0)
    {
        //只选了颜色
        NSString *color =[self.goodsDM.specColor objectAtIndex:_choseView.colorView.seletIndex];
        //根据所选颜色 取出该颜色对应所有尺码的库存字典
        NSArray *arr = [self.goodsDM.spec objectForKey:color];
        [self reloadTypeBtn:arr arr:self.goodsDM.specSize view:_choseView.sizeView];
        [self resumeBtn:self.goodsDM.specColor :_choseView.colorView];
        _choseView.lb_stock.text = [NSString stringWithFormat:@"库存%ld件", (long)self.goodsDM.stock];
        _choseView.lb_detail.text = @"请选择 尺码";
        _choseView.stock = (int)self.goodsDM.stock;
        
        _choseView.img.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg",_choseView.colorView.seletIndex+1]];
    }else if (_choseView.sizeView.seletIndex >= 0&&_choseView.colorView.seletIndex == -1)
    {
        //只选了尺码
        NSString *size =[self.goodsDM.specSize objectAtIndex:_choseView.sizeView.seletIndex];
        //根据所选尺码 取出该尺码对应所有颜色的库存字典
        NSArray *arr = [self.goodsDM.spec objectForKey:size];
        [self resumeBtn:self.goodsDM.specSize :_choseView.sizeView];
        [self reloadTypeBtn:arr arr:self.goodsDM.specColor view:_choseView.colorView];
        _choseView.lb_stock.text = [NSString stringWithFormat:@"库存%ld件", (long)self.goodsDM.stock];
        _choseView.lb_detail.text = @"请选择 颜色分类";
        _choseView.stock = (int)self.goodsDM.stock;
        
        //        for (int i = 0; i<colorarr.count; i++) {
        //            int count = [[dic objectForKey:[colorarr objectAtIndex:i]] intValue];
        //            //遍历颜色字典 库存为零则改尺码按钮不能点击
        //            if (count == 0) {
        //                UIButton *btn =(UIButton *) [_choseView.colorView viewWithTag:100+i];
        //                btn.enabled = NO;
        //            }
        //        }
        
    }
    
}
//恢复按钮的原始状态
-(void)resumeBtn:(NSArray *)arr :(TypeView *)view
{
    for (int i = 0; i< arr.count; i++) {
        UIButton *btn =(UIButton *) [view viewWithTag:100+i];
        btn.enabled = YES;
        btn.selected = NO;
        [btn setBackgroundColor:[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1]];
        [btn setTitleColor:[UIColor blackColor] forState:0];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        if (view.seletIndex == i) {
            btn.selected = YES;
            [btn setBackgroundColor:[UIColor redColor]];
        }
    }
}
//根据所选的尺码或者颜色对应库存量 确定哪些按钮不可选
-(void)reloadTypeBtn:(NSArray *)array arr:(NSArray *)arr view:(TypeView *)view
{
    for (int i = 0; i<arr.count; i++) {
        UIButton *btn =(UIButton *)[view viewWithTag:100+i];
        btn.selected = NO;
        [btn setBackgroundColor:[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1]];
        btn.enabled = NO;
        [btn setTitleColor:[UIColor lightGrayColor] forState:0];
        
        for (NSDictionary *dict in array) {
            
            if ([dict[@"specColor"] isEqualToString:[arr objectAtIndex:i]] || [dict[@"specSize"] isEqualToString:[arr objectAtIndex:i]]) {
                btn.enabled = YES;
                [btn setTitleColor:[UIColor blackColor] forState:0];
            }
            //库存为零 不可点击
            //根据seletIndex 确定用户当前点了那个按钮
            if (view.seletIndex == i) {
                btn.selected = YES;
                [btn setBackgroundColor:[UIColor redColor]];
            }
            
            
        }
        
    }
}


/**
 *  此处嵌入浏览图片代码
 */
-(void)showBigImage:(UITapGestureRecognizer *)tap
{
    NSLog(@"放大图片");
}


@end
