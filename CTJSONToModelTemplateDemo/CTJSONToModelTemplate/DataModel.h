//
//  DataModel.h
//  CTJSONToModelTemplate
//
//  Created by Admin on 2016/11/8.
//  Copyright © 2016年 Arvin. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BodyModel;
@class FooterModel;
@class SalaryFinancingModel;
@class LoanActivityModel;
@class SalarySocialSecurityModel;
@class CurrentFinancingModel;
@class ActivityDomainModel;


@interface DataModel : NSObject

@property (nonatomic, strong) BodyModel * body;

@property (nonatomic, strong) FooterModel * footer;

@end


@interface FooterModel : NSObject

@property (nonatomic,   copy) NSString * status;

@end


@interface BodyModel : NSObject

@property (nonatomic,   copy) NSString * salaryFinancingLabel;

@property (nonatomic,   copy) NSString * availableBalance;

@property (nonatomic, strong) NSArray <SalaryFinancingModel *>* salaryFinancing;

@property (nonatomic,   copy) NSString * code;

@property (nonatomic,   copy) NSString * sumUser;

@property (nonatomic,   copy) NSString * salarySocialSecurityLabel;

@property (nonatomic,   copy) NSString * isCanQuerySocialSecurity;

@property (nonatomic,   copy) NSString * sumDualAmountLabel;

@property (nonatomic,   copy) NSString * currentFinancingTips;

@property (nonatomic, strong) LoanActivityModel * loanActivity;

@property (nonatomic, strong) NSArray <SalarySocialSecurityModel *>* salarySocialSecurity;

@property (nonatomic,   copy) NSString * activityDomainLabel;

@property (nonatomic, strong) NSArray <CurrentFinancingModel *>* currentFinancing;

@property (nonatomic,   copy) NSString * aboutZhonganH5Url;

@property (nonatomic, strong) NSArray <ActivityDomainModel *>* activityDomain;

@property (nonatomic,   copy) NSString * salarySocialSecurityTips;

@property (nonatomic,   copy) NSString * currentFinancingLabel;

@property (nonatomic,   copy) NSString * availableBalanceLabel;

@property (nonatomic,   copy) NSString * sumUserLabel;

@property (nonatomic,   copy) NSString * aboutCoopH5Url;

@property (nonatomic,   copy) NSString * message;

@property (nonatomic,   copy) NSString * showType;

@property (nonatomic,   copy) NSString * sumDualAmount;

@property (nonatomic,   copy) NSString * subTitle;

@end


@interface CurrentFinancingModel : NSObject

@property (nonatomic,   copy) NSString * code;

@property (nonatomic,   copy) NSString * buttonText;

@property (nonatomic,   copy) NSString * value;

@property (nonatomic,   copy) NSString * name;

@property (nonatomic,   copy) NSString * desc;

@end


@interface LoanActivityModel : NSObject

@property (nonatomic,   copy) NSString * loanAmount;

@property (nonatomic,   copy) NSString * conditionDesc;

@property (nonatomic,   copy) NSString * loanMinRate;

@property (nonatomic,   copy) NSString * detailDesc;

@property (nonatomic,   copy) NSString * loanProductName;

@property (nonatomic,   copy) NSString * loanRateDesc;

@end


@interface SalarySocialSecurityModel : NSObject

@property (nonatomic,   copy) NSString * code;

@property (nonatomic,   copy) NSString * buttonText;

@property (nonatomic,   copy) NSString * value;

@property (nonatomic,   copy) NSString * name;

@property (nonatomic,   copy) NSString * desc;

@end


@interface ActivityDomainModel : NSObject

@property (nonatomic,   copy) NSString * code;

@property (nonatomic,   copy) NSString * buttonText;

@property (nonatomic,   copy) NSString * value;

@property (nonatomic,   copy) NSString * name;

@property (nonatomic,   copy) NSString * desc;

@end


@interface SalaryFinancingModel : NSObject

@property (nonatomic,   copy) NSString * code;

@property (nonatomic,   copy) NSString * buttonText;

@property (nonatomic,   copy) NSString * value;

@property (nonatomic,   copy) NSString * name;

@property (nonatomic,   copy) NSString * desc;

@end
