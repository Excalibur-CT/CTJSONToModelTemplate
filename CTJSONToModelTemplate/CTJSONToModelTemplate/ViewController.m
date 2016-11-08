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
//    [NSObject autoProduceModelTemplateWithData:jsonData rootModel:@"Data"];
    
    DataModel * model = [DataModel mj_objectWithKeyValues:jsonData];
    
    NSLog(@"%@", model.body.aboutCoopH5Url);
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
