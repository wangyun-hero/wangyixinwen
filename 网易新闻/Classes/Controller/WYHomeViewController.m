//
//  WYHomeViewController.m
//  网易新闻
//
//  Created by 王云 on 16/8/13.
//  Copyright © 2016年 王云. All rights reserved.
//

#import "WYHomeViewController.h"
#import "WYChannelView.h"
#import "WYChannelModel.h"

static NSString *collectioncellid = @"collectioncellid";
@interface WYHomeViewController ()<UICollectionViewDataSource>

@property(nonatomic,strong) WYChannelView *channelView;

@property(nonatomic,strong) UICollectionView *collectionView;

@property(nonatomic,strong) NSArray *channels;

@end

@implementation WYHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    //[WYChannelModel channels];
}

#pragma mark -关于channelView
-(void)setupUI
{
    //添加频道的view
    WYChannelView *channelView = [WYChannelView channelView];
    //添加到view上
     [self.view addSubview:channelView];
    //记录channelview
    self.channelView = channelView;
    //将模型加载的数据传递到vc
    self.channels = [WYChannelModel channels];
     // 读取频道数据,并且设置到频道视图上
    channelView.channels = self.channels;
    //设置自动布局
    [channelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.height.mas_equalTo(35);
        make.top.equalTo(self.mas_topLayoutGuideBottom);
    }];
    [self setupCollectionView];
}

#pragma mark -collectionview
-(void)setupCollectionView
{
    //创建流水布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    //设置滚动方向为水平
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    //设置行间距和组间距
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    //初始化一个collectionView
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    //记录这个collectionview
    self.collectionView = collectionView;
    //设置背景颜色
    collectionView.backgroundColor = [UIColor whiteColor];
    //设置分页
    collectionView.pagingEnabled = YES;
    //设置数据源
    collectionView.dataSource = self;
    //注册cell
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:collectioncellid];
    
    //添加到view上
    [self.view addSubview:collectionView];
    
    //布局
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.channelView.mas_bottom);
    }];
}

#pragma mark -collectionViewCell的大小
//已经准备好了collectionview的大小
-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    //取到collectionView的layout进行一个强转
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    //将cell的大小设置为collectionView的大小
    layout.itemSize = self.collectionView.bounds.size;
    
}




#pragma mark -数据源
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.channels.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //取缓存池找
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectioncellid forIndexPath:indexPath];
    cell.backgroundColor = [UIColor randomColor];
    
    
    return  cell;
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
