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
@interface WYHomeViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,WYChannelViewDelegata>
//频道视图
@property(nonatomic,strong) WYChannelView *channelView;
//显示新闻的collectionView
@property(nonatomic,strong) UICollectionView *collectionView;
//记录频道的数据
@property(nonatomic,strong) NSArray *channels;
//缓存控制器的字典
@property(nonatomic,strong) NSMutableDictionary *vcCache;
//记录adview
@property(nonatomic,strong) UIView *adView;

@end

@implementation WYHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    [WYChannelModel channels];
   //添加一个边缘手势
    UIScreenEdgePanGestureRecognizer *edgePan = [[UIScreenEdgePanGestureRecognizer alloc]initWithTarget:self action:@selector(showAd:)];
    //指定滑动的方向
    edgePan.edges = MASAttributeLeft;
    //
    [self.collectionView.panGestureRecognizer requireGestureRecognizerToFail:edgePan];
    //添加手势
    [self.view addGestureRecognizer:edgePan];


}

-(void)showAd:(UIScreenEdgePanGestureRecognizer *)ges
{
    //手指的位置
    CGPoint p = [ges locationInView:self.view];
    CGRect frame = self.adView.frame;
    //改变x的frame
    frame.origin.x = p.x - [UIScreen mainScreen].bounds.size.width;
    //重新设置上去
    self.adView.frame = frame;
    //当手势停止或者取消的时候,将adview完全展示出来
    if (ges.state == UIGestureRecognizerStateCancelled || ges.state == UIGestureRecognizerStateEnded)
    {
        //判断如果adview的中心出现在屏幕上,那么完全展示
        if (CGRectContainsPoint(self.view.frame, self.adView.center)) {
            frame.origin.x = 0;
        }
        else
        {
            //如果没有就隐藏
            frame.origin.x = -[UIScreen mainScreen].bounds.size.width;
        }
        [UIView animateWithDuration:0.25 animations:^{
                    //将修改后 的frame赋值重新赋值
                    self.adView.frame = frame;

        }];
    }
    
}

#pragma mark -关于channelView
-(void)setupUI
{
    //添加频道的view
    WYChannelView *channelView = [WYChannelView channelView];
    //添加到view上
     [self.view addSubview:channelView];
    // 6 设置传递事件的代理属性为vc
    channelView.delagata = self;
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
    [self setupAdView];
}

#pragma mark -setupAdView
-(void )setupAdView
{
    //初始化adView
    UIView *adView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    //记录adview
    self.adView = adView;
    //设置颜色
    adView.backgroundColor = [UIColor orangeColor];
    //大小
    CGRect frame = adView.frame;
    //因为这个adview是盖在所以view的上面,所以添加到window上
    frame.origin.x = -adView.frame.size.width;
    //将修改后的frame重新赋值给adview的frame
    adView.frame = frame;
    //添加到window上
    [[UIApplication sharedApplication].keyWindow addSubview:adView];
    
    //添加轻扫的手势
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(closeAd:)];
    swipe.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.adView addGestureRecognizer:swipe];
    
}

#pragma mark -关闭adview
-(void)closeAd:(UISwipeGestureRecognizer *)ges
{
    [UIView animateWithDuration:0.25 animations:^{
        CGRect frame = self.adView.frame;
        frame.origin.x = -[UIScreen mainScreen].bounds.size.width;
        self.adView.frame = frame;
    }];
    
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
    //设置数据源和代理
    collectionView.dataSource = self;
    collectionView.delegate = self;
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

#pragma mark -传递cell被点击的事件的代理方法
-(void)channelView:(WYChannelView *)channelView clickWithIndex:(NSInteger)index
{
    NSLog(@"点击了%zd",index);
    //取到位置
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];
    //让scrollview滚动到对应的位置
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:false];
    
    
}


#pragma mark -UICollectionViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"%@",NSStringFromCGPoint(self.collectionView.contentOffset));
    CGFloat ratio = self.collectionView.contentOffset.x / self.collectionView.frame.size.width;
    NSLog(@"%f",ratio);
    //取到当前页面的索引
    NSInteger curruntIndex = ratio / 1;
    NSLog(@"%zd",curruntIndex);
    //根据滚动的距离求出缩放的比例
    
        
        CGFloat scale = ratio - curruntIndex;
    NSLog(@"%f",scale);
    if (curruntIndex + 1 < self.channels.count) {
        [self.channelView setScale: scale withIndex:curruntIndex + 1];
        [self.channelView setScale: 1- scale withIndex:curruntIndex];
    }
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
//    for (UIView *v in cell.contentView.subviews) {
//        [v removeFromSuperview];
//    }
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
