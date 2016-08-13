//
//  WYNewsListViewController.m
//  网易新闻
//
//  Created by 王云 on 16/8/12.
//  Copyright © 2016年 王云. All rights reserved.
//

#import "WYNewsListViewController.h"
#import "Masonry.h"
#import "WYNetWorkManager.h"
#import "WYNewsModel.h"

#import <UIImageView+WebCache.h>

#import "WYNewsBaseCell.h"

static NSString *noemalID = @"noemalID";
// 多图的可重用id
static NSString *imgExtraCellid = @"imgExtraCellid";
// 大图的可重用id
static NSString *bigImageCellid = @"bigImageCellid";

@interface WYNewsListViewController ()<UITableViewDataSource>

@property(nonatomic,strong) NSArray *newsList;

@property(nonatomic,strong) UITableView *tableView;

@end

@implementation WYNewsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self loadData];
}

-(void)setupUI
{
    //创建tableView
    UITableView *tableView = [[UITableView alloc]init];
    //添加到view上
    [self.view addSubview:tableView];
    //赋值
    self.tableView = tableView;
    //注册cell
    //[tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellid"];
    //注册常用的cell
    [tableView registerNib:[UINib nibWithNibName:@"WYNewsNormalCell" bundle:nil] forCellReuseIdentifier:noemalID];
    //注册多图的cell
    [tableView registerNib:[UINib nibWithNibName:@"WYNewsImgExtraCell" bundle:nil] forCellReuseIdentifier:imgExtraCellid];
    // 注册大图的cell
    [tableView registerNib:[UINib nibWithNibName:@"WYNewsBigImgCell" bundle:nil] forCellReuseIdentifier:bigImageCellid];
    //行高自动计算
    tableView.rowHeight = UITableViewAutomaticDimension;
    tableView.estimatedRowHeight = 100;
    //设置代理
    tableView.dataSource = self;
    //布局
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];
    
}

#pragma mark -获取网络数据
-(void)loadData
{
    //频道号
    NSString *tid = @"T1348649079062";
    //根据频道获取数据
    [[WYNetWorkManager shardManager] getHomeNewListWithChannelld:tid completion:^(id response, NSError *error) {
        NSLog(@"%@",response);
        //取到数组
        NSArray *array = response[tid];
        //字典转模型
        NSArray *modelArray = [NSArray yy_modelArrayWithClass:[WYNewsModel class] json:array];
       //赋值
        self.newsList = modelArray;
      //刷新数据
        [self.tableView reloadData];
    }];
    
}

#pragma mark -数据源
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.newsList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //取到对应位置的模型
    WYNewsModel *model = self.newsList[indexPath.row];
    NSString *result = noemalID;
    if (model.imgextra.count > 0) {
        result = imgExtraCellid;
    }
    else if (model.imgType)
    {
        result = bigImageCellid;
    }
    //去缓存池找
//    WYNewsNormalCell *cell = [tableView dequeueReusableCellWithIdentifier:@"noemalID" forIndexPath:indexPath];
    WYNewsBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:result
 forIndexPath:indexPath];
    cell.model = model;
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
