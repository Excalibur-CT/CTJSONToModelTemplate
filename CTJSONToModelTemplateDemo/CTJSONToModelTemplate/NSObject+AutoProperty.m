//
//  AppDelegate.m
//  CTTurnSet
//
//  Created by Admin on 2016/10/27.
//  Copyright © 2016年 Arvin. All rights reserved.
//


#import "NSObject+AutoProperty.h"

#define TEMP_OUT(FORMAT, ...) printf("%s", [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);


#define K_MODEL_NAME_KEY  @"ModelName"
#define K_MODEL_MAP_KEY   @"ModelMap"

@implementation NSObject (AutoProperty)

+ (void)autoProduceModelTemplateWithData:(id)jsonData rootModel:(NSString *)rootModelName
{
    if (jsonData == nil)
    {
        return;
    }
    NSString * rootModel = @"__";
    if (rootModelName.length != 0)
    {
        rootModel = rootModelName;
    }
    NSArray * dataAry;
    if ([jsonData isKindOfClass:[NSArray class]])
    {
        dataAry = [self dictaryTemplateAryFromArray:jsonData modelName:rootModel];
    }
    else if ([jsonData isKindOfClass:[NSDictionary class]])
    {
        dataAry = [self dictaryTemplateAryFromDictionary:jsonData modelName:rootModel];
    }
    TEMP_OUT(@"\n\n");
    [self autoProduceClassDeclarationWithArray:dataAry];
    [dataAry enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self autoProduceTemplateWithDictonary:obj];
    }];
    TEMP_OUT(@"-- 请将以下代码复制到.m 文件中 --");
    [dataAry enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self autoProduceTemplateImplWithDictonary:obj];
    }];
}

+ (NSArray *)dictaryTemplateAryFromArray:(NSArray *)ary modelName:(NSString *)modelName
{
    if (ary.count == 0)
    {
        return nil;
    }
    if ([ary[0] isKindOfClass:[NSString class]])
    {
        return nil;
    }
    __block NSMutableArray * tempAry = [@[] mutableCopy];
    __block NSMutableArray * mapAry  = [@[] mutableCopy];
    __block NSMutableDictionary * tempDict = [NSMutableDictionary dictionaryWithCapacity:1];
    [tempDict setObject:modelName forKey:K_MODEL_NAME_KEY];
    [ary enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull subObj, BOOL * _Nonnull subStop) {
            [tempDict setObject:typeWithValue(subObj, key) forKey:key];
            if ([subObj isKindOfClass:[NSDictionary class]])
            {
                NSArray * ary = [self dictaryTemplateAryFromDictionary:subObj modelName:key];
                if (ary)
                {
                    [mapAry addObject:key];
                    [tempAry addObjectsFromArray:ary];
                }
            }
            else if ([subObj isKindOfClass:[NSArray class]])
            {
                NSArray * ary = [self dictaryTemplateAryFromArray:subObj modelName:key];
                if (ary)
                {
                    [tempAry addObjectsFromArray:ary];
                }
            }
        }];
    }];
    [tempDict setObject:mapAry forKey:K_MODEL_MAP_KEY];
    if ([[tempDict allKeys] count] != 2)
    {
        [tempAry insertObject:tempDict atIndex:0];
    }
    return tempAry;
}

+ (NSArray *)dictaryTemplateAryFromDictionary:(NSDictionary *)dict modelName:(NSString *)modelName
{
    if ([[dict allKeys] count] == 0)
    {
        return nil;
    }

    __block NSMutableArray * tempAry = [@[] mutableCopy];
    __block NSMutableArray * mapAry  = [@[] mutableCopy];
    __block NSMutableDictionary * tempDict = [NSMutableDictionary dictionaryWithCapacity:1];
    [tempDict setObject:modelName forKey:K_MODEL_NAME_KEY];
    [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [tempDict setObject:typeWithValue(obj, key) forKey:key];
        if ([obj isKindOfClass:[NSDictionary class]])
        {
            NSArray * ary = [self dictaryTemplateAryFromDictionary:obj modelName:key];
            if (ary)
            {
                [mapAry addObject:key];
                [tempAry addObjectsFromArray:ary];
            }
        }
        else if ([obj isKindOfClass:[NSArray class]])
        {
            NSArray * ary = [self dictaryTemplateAryFromArray:obj modelName:key];
            if (ary)
            {
                [tempAry addObjectsFromArray:ary];
            }
        }
    }];
    [tempDict setObject:mapAry forKey:K_MODEL_MAP_KEY];
    if ([[tempDict allKeys] count] != 2)
    {
        [tempAry insertObject:tempDict atIndex:0];
    }
    return tempAry;
}

+ (void)autoProduceClassDeclarationWithArray:(NSArray *)modelTempAry
{
    TEMP_OUT(@"\n\n");
    __block NSMutableArray * intAry = [@[] mutableCopy];
    __block NSMutableArray * conAry = [@[] mutableCopy];
    [modelTempAry enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [intAry addObject:ClassName(obj[K_MODEL_NAME_KEY])];
        [obj enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, NSString * _Nonnull subObj, BOOL * _Nonnull stop)
         {
             if ([subObj isKindOfClass:[NSString class]])
             {
                 
                 if ([subObj hasPrefix:@"NSArray"] || [subObj hasPrefix:@"NSDictionary"])
                 {
                     NSArray * typeAry = [subObj componentsSeparatedByString:@"_"];
                     NSString * type = [typeAry lastObject];
                     if (([subObj hasPrefix:@"NSArray_Y_"] ||
                          [subObj hasPrefix:@"NSDictionary"]) &&
                         ![intAry containsObject:ClassName(type)])
                     {
                         [conAry addObject:ClassName(type)];
                     }
                 }
             }
         }];
    }];
    for (int i = 0; i < conAry.count; i++)
    {
        TEMP_OUT(@"@class %@;", conAry[i]);
        TEMP_OUT(@"\n");
    }
    TEMP_OUT(@"\n");
}

+ (void)autoProduceTemplateWithDictonary:(NSDictionary *)dict
{
    TEMP_OUT(@"\n");
    TEMP_OUT(@"@interface %@ : NSObject",ClassName(dict[K_MODEL_NAME_KEY]));
    TEMP_OUT(@"\n\n");
    [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop)
    {
        if ([obj isKindOfClass:[NSArray class]])
        {
            return ;
        }
        if ([obj hasPrefix:@"NSString"])
        {
            TEMP_OUT(@"@property (nonatomic,   copy) NSString * %@;", VerifyKey(key));
            TEMP_OUT(@"\n\n");
        }
        else if ([obj hasPrefix:@"NSNumber"])
        {
            TEMP_OUT(@"@property (nonatomic, strong) NSNumber * %@;", VerifyKey(key));
            TEMP_OUT(@"\n\n");
        }
        else if ([obj hasPrefix:@"NSData"])
        {
            TEMP_OUT(@"@property (nonatomic, strong) NSData  * %@;", VerifyKey(key));
            TEMP_OUT(@"\n\n");
        }
        else if ([obj hasPrefix:@"BOOL"])
        {
            TEMP_OUT(@"@property (nonatomic, assign) BOOL      %@;", VerifyKey(key));
            TEMP_OUT(@"\n\n");
        }
        else if ([obj hasPrefix:@"NSArray"])
        {
            NSArray * typeAry = [obj componentsSeparatedByString:@"_"];
            NSString * type = [typeAry lastObject];
            if ([typeAry[1] isEqualToString:@"Y"])
            {
                TEMP_OUT(@"@property (nonatomic, strong) NSArray <%@ *>* %@;", ClassName(type), VerifyKey(key));
            }
            else
            {
                TEMP_OUT(@"@property (nonatomic, strong) NSArray  * %@;", VerifyKey(key));
            }
            TEMP_OUT(@"\n\n");
        }
        else if ([obj hasPrefix:@"NSDictionary"])
        {
            NSString * type = [[obj componentsSeparatedByString:@"_"] lastObject];
            TEMP_OUT(@"@property (nonatomic, strong) %@ * %@;", ClassName(type), VerifyKey(key));
            TEMP_OUT(@"\n\n");
        }
    }];
    TEMP_OUT(@"@end");
    TEMP_OUT(@"\n\n"); 
}

+ (void)autoProduceTemplateImplWithDictonary:(NSDictionary *)dict
{
    NSArray * mapAry = dict[K_MODEL_MAP_KEY];
    TEMP_OUT(@"\n\n");
    TEMP_OUT(@"@implementation %@",ClassName(dict[K_MODEL_NAME_KEY]));
    TEMP_OUT(@"\n\n");
    if (mapAry.count != 0)
    {
        TEMP_OUT(@"+ (NSDictionary *)objectClassInArray");
        TEMP_OUT(@"\n");
        TEMP_OUT(@"{");
        TEMP_OUT(@"\n");
        TEMP_OUT(@"    return @{");
        [mapAry enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            TEMP_OUT(@"\n");
            TEMP_OUT(@"            @\"%@\":[%@ class]",obj, ClassName(obj));
            if (idx != mapAry.count -1)
            {
                TEMP_OUT(@",");
            }
        }];
        TEMP_OUT(@"\n");
        TEMP_OUT(@"            };");
        TEMP_OUT(@"\n");
        TEMP_OUT(@"}");
        TEMP_OUT(@"\n\n");
    }

    TEMP_OUT(@"@end");
    TEMP_OUT(@"\n\n");
}


NSString * typeWithValue(id value, NSString * key)
{
    if ([value isKindOfClass:[NSString class]])
    {
        return @"NSString";
    }
    else if ([value isKindOfClass:[NSNumber class]])
    {
        return @"NSNumber";
    }
    else if ([value isKindOfClass:[NSDictionary class]])
    {
        return [NSString stringWithFormat:@"NSDictionary_%@", key];
    }
    else if ([value isKindOfClass:[NSArray class]])
    {
        if ([value count] != 0 &&
            (![value[0] isKindOfClass:[NSString class]]&&
             ![value[0] isKindOfClass:[NSNumber class]])
            )
        {
            return [NSString stringWithFormat:@"NSArray_Y_%@", key];
        }
        else
        {
            return [NSString stringWithFormat:@"NSArray_N_%@", key];
        }
    }
    else if ([value isKindOfClass:[NSData class]])
    {
        return @"NSData";
    }
    else if ([value isKindOfClass:NSClassFromString(@"__NSCFBoolean")])
    {
        return @"BOOL";
    }
    else
    {
        return @"";
    }
}

NSString * VerifyKey(NSString * key)
{
    if ([key isEqualToString:@"id"])
    {
         return @"_id";
    }
    return key;
}

NSString * ClassName(NSString * key)
{
    if (key.length == 0)
    {
        return @"";
    }
    NSString * regKey = [key stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:[[key substringToIndex:1] capitalizedString]];
    NSString * name = [NSString stringWithFormat:@"%@%@%@",K_MODEL_PREFIX,regKey,K_MODEL_SUFFIX];
    return [name stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

@end
