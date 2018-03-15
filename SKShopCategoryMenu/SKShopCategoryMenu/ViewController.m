//
//  ViewController.m
//  SKShopCategoryMenu
//
//  Created by AY on 2018/3/15.
//  Copyright © 2018年 AY. All rights reserved.
//

#import "ViewController.h"
#import "ShopMenuModel.h"

#define kScreenW  	[UIScreen mainScreen].bounds.size.width
#define kScreenH  	[UIScreen mainScreen].bounds.size.height


@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic
,strong)NSMutableArray *dataArr;

@property (nonatomic
,strong)UITableView *leftTbView;

@property (nonatomic
,strong)UITableView *rightTbView;



@end

@implementation ViewController

/** 
	加载本地数据
 */

- (NSMutableArray *)dataArr
{
	if (!_dataArr) {
		_dataArr = [NSMutableArray arrayWithCapacity:0];
		
		NSString *path = [[NSBundle mainBundle]pathForResource:@"shop" ofType:@"json"];
		NSData *data = [NSData dataWithContentsOfFile:path];
		NSArray *dataArr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
		
		for (NSDictionary *dic in dataArr) {
			ShopMenuModel *model = [[ShopMenuModel alloc]init];
			[model setValuesForKeysWithDictionary:dic];
			[_dataArr addObject:model];
		}
	}
	return _dataArr;

}





- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
	NSLog(@"%@",self.dataArr);
	
	UILabel *titleLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenW, 64)];
	titleLbl.backgroundColor = [[UIColor brownColor]colorWithAlphaComponent:0.5];
	titleLbl.text = @"商品列表";
	titleLbl.textAlignment = NSTextAlignmentCenter;
	titleLbl.font = [UIFont systemFontOfSize:25.0f];
	[self.view addSubview:titleLbl];
	
	
	[self createTb];
}



- (void)createTb
{

	self.leftTbView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, 150, kScreenH - 64) style:UITableViewStylePlain];
	
	self.leftTbView.delegate = self;
	self.leftTbView.dataSource = self;
	self.leftTbView.rowHeight = 66;
	[self.view addSubview:self.leftTbView];
	
	
	// 间隔view
	
	UIView *sepView = [[UIView alloc]initWithFrame:CGRectMake(150, 64, 8, kScreenH - 64)];
	sepView.backgroundColor = [UIColor colorWithRed:225/255.0f green:225/255.0f blue:225/255.0f alpha:1];
	
	[self.view addSubview:sepView];
	
	
	
	self.rightTbView = [[UITableView alloc]initWithFrame:CGRectMake(158, 64, kScreenW - 158, kScreenH - 64) style:UITableViewStylePlain];
	self.rightTbView.rowHeight = 66;
	self.rightTbView.delegate = self;
	self.rightTbView.dataSource = self;
	[self.view addSubview:self.rightTbView];
	
	

}


#pragma mark - datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	if (tableView == self.leftTbView) {
		return self.dataArr.count;
	}else{
		// 当前左边选中额行
		NSInteger idx =  self.leftTbView.indexPathForSelectedRow.row;
		
		ShopMenuModel *model = self.dataArr[idx];
		
		return model.subArray.count;
		
		
	}
	
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if(tableView == self.leftTbView){
		static NSString *leftID = @"leftID";
		
		UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
		
		if (!cell) {
			cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:leftID];
		}
		
		ShopMenuModel *model = self.dataArr[indexPath.row];
		
		cell.textLabel.text = model.title;
		cell.textLabel.highlightedTextColor = [UIColor redColor];
		
		return  cell;
	}else{
		
		static NSString *rightID = @"rightID";
		
		UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
		
		if (!cell) {
			cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:rightID];
		}
		
		// 获得左边的cell
		
		
		ShopMenuModel *model = self.dataArr[self.leftTbView.indexPathForSelectedRow.row];
		cell.textLabel.text = model.subArray[indexPath.row];
		cell.textLabel.highlightedTextColor = [UIColor redColor];
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
//		
//		
		return  cell;
	
	}

}

/**
	当用户选中左边的cell 的时候 右边的Tableview重新装载数据
*/

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (tableView == self.leftTbView) {
		[self.rightTbView reloadData];
	}

}





- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}


@end
