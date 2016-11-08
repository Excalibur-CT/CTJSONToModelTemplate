//
//  DataModel.m
//  CTJSONToModelTemplate
//
//  Created by Admin on 2016/11/8.
//  Copyright © 2016年 Arvin. All rights reserved.
//

#import "DataModel.h"

@implementation DataModel

+ (NSDictionary *)objectClassInArray
{
    return @{
             @"footer":[FooterModel class],
             @"body":[BodyModel class]
             };
}

@end



@implementation FooterModel

@end



@implementation BodyModel

+ (NSDictionary *)objectClassInArray
{
    return @{
             @"loanActivity":[LoanActivityModel class]
             };
}

@end



@implementation CurrentFinancingModel

@end



@implementation LoanActivityModel

@end



@implementation SalarySocialSecurityModel

@end



@implementation ActivityDomainModel

@end



@implementation SalaryFinancingModel

@end


