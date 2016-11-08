//
//  AppDelegate.m
//  CTTurnSet
//
//  Created by Admin on 2016/10/27.
//  Copyright © 2016年 Arvin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


#define K_MODEL_PREFIX @""
#define K_MODEL_SUFFIX @"Model"


@interface NSObject (AutoProperty)

/**
 *  自动生成属性列表Model 模型模板
 */
+ (void)autoProduceModelTemplateWithData:(id)jsonData rootModel:(NSString *)rootModelName;

@end
