//
//  ShopMenuModel.m
//  SKShopCategoryMenu
//
//  Created by AY on 2018/3/15.
//  Copyright © 2018年 AY. All rights reserved.
//

#import "ShopMenuModel.h"

@implementation ShopMenuModel

-(void)setValuesForKeysWithDictionary:(NSDictionary<NSString *,id> *)keyedValues
{
	
	_title = keyedValues[@"title"];
	_subArray = keyedValues[@"subArray"];
	[super setValuesForKeysWithDictionary:keyedValues];
	
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
	
	
}

@end
