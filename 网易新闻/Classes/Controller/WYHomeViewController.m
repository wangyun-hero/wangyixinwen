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
#import "WYNewsListViewController.h"

static NSString *collectioncellid = @"collectioncellid";
@interface WYHomeViewController ()<UICollectionViewDataSource>
//频道视图
@property(nonatomic,strong) WYChannelView *channelView;
//显示新闻的collectionView
@property(nonatomic,strong) UICollectionView *collectionView;
//记录频道的数据
@property(nonatomic,strong) NSArray *channels;
//缓存控制器的字典
@property(nonatomic,strong) NSMutableDictionary *vcCache;


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
    //方法一  移除cell中的contentView的子控件
    for (UIView *v in cell.contentView.subviews) {
        [v removeFromSuperview];
    }
    //方法二 使他的元素执行某个方法
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    //取到对应cell的模型
    WYChannelModel *model = [self.channels objectAtIndex:indexPath.item];
    
    // 将新闻列表控制器的 view 添加到cell的contentView里面
    UIViewController *vc = [self viewControllerWithModel:model];
   //设置为当前控制器的子控制器
    [self addChildViewController:vc];
    //将vc.view添加到cell上
    [cell.contentView addSubview:vc.view];
    cell.backgroundColor = [UIColor randomColor];
    //设置控制器的view和cell一样大
    [vc.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(cell.contentView);
    }];
    
    return  cell;
}


-(UIViewController *)viewControllerWithModel:(WYChannelModel *)model
{
    UIViewController *vc = [self.vcCache objectForKey:model.tid];
    if (vc == nil) {
        vc = [[WYNewsListViewController alloc]initWithModel:model];
    }
    [self.vcCache setObject:vc forKey:model.tid];
    return vc;
}

#pragma mark -vcCache的懒加载
-(NSMutableDictionary *)vcCache
{
    if (_vcCache == nil) {
        _vcCache = [NSMutableDictionary dictionary];
    }
    return _vcCache;
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
