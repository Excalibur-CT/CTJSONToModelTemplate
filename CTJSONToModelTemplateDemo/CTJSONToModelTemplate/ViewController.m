//
//  ViewController.m
//  CTJSONToModelTemplate
//
//  Created by Admin on 2016/11/8.
//  Copyright © 2016年 Arvin. All rights reserved.
//

#import "ViewController.h"
#import "NSObject+AutoProperty.h"
#import "DataModel.h"
#import <MJExtension/MJExtension.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString * path = [[NSBundle mainBundle] pathForResource:@"testData" ofType:@"json"];
    id jsonData = [NSJSONSerialization JSONObjectWithData:[[NSData alloc] initWithContentsOfFile:path] options:NSJSONReadingMutableContainers error:nil];
//  1. 将控制台打印出来的代码分别复制到 创建的Modle 的 .h 和 .m  文件中
    [NSObject autoProduceModelTemplateWithData:jsonData rootModel:@"Data"];
    
//   2. 使用MJExtension将后台返回的数据转换成Model
    DataModel * model = [DataModel mj_objectWithKeyValues:jsonData];
    
    NSLog(@"%@", model.body.aboutCoopH5Url);
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
