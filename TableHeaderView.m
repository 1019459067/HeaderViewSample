//
//  TableHeaderView.m
//  huinongwang
//
//  Created by HN on 2020/7/31.
//  Copyright © 2020 cnhnb. All rights reserved.
//

#import "TableHeaderView.h"
//#import "RSSpecPriceCollectionCell.h"
#define HNWLoadViewFromNibInMainBundle(nibNameStr, indexInteger) [[NSBundle mainBundle] loadNibNamed:nibNameStr owner:nil options:nil][indexInteger]
#define HNWLoadFirstViewFromNibInMainBundle(nibNameStr) HNWLoadViewFromNibInMainBundle(nibNameStr, 0)


@interface TableHeaderView ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UIView *topBgView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIView *addSpecPriceBgView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topBgViewConstraintH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionViewConstraintH;
@property (nonatomic) id target;
@property (assign, nonatomic) NSInteger cellCount;

@end

@implementation TableHeaderView

+ (instancetype)headerContentView
{
    TableHeaderView *contentView = HNWLoadFirstViewFromNibInMainBundle(NSStringFromClass(self.class));
    [contentView settingUI];

    return contentView;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
//    [self settingUI];
//    [self setupGesture];
}

#pragma mark - UI
- (void)settingUI
{
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout new];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    //每行cell之间的最小距离
    flowLayout.minimumLineSpacing = 0;
    self.collectionView.collectionViewLayout = flowLayout;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    if (@available(iOS 11.0, *)) {
        self.collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
}

#pragma mark - other
- (CGFloat)rowHeightWithModelsWithCellCount:(NSInteger)cellCount;
{
    self.cellCount = cellCount;
    [self.collectionView reloadData];
    CGFloat cellW = (SCREEN_WIDTH-30-2*10.5)/3.;
    CGFloat cellH = cellW/2.;
    NSInteger row = cellCount%3?cellCount/3+1:cellCount/3;
    CGFloat height = cellH * row;

    self.collectionViewConstraintH.constant = height;
    return 54+height+50;
}

- (UIColor *)arc4randomColor
{
    return [UIColor colorWithRed:(arc4random()%255/255.0) green:(arc4random()%255/255.0) blue:(arc4random()%255/255.0) alpha:1];
}
#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource
-  (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identity = @"cell";
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identity forIndexPath:indexPath];
    
    cell.backgroundColor = [self arc4randomColor];
    UILabel *titleLabel = [cell.contentView viewWithTag:10000];
    if (titleLabel == nil) {
        titleLabel = [[UILabel alloc]init];
        titleLabel.tag = 10000;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.frame = CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height);
        titleLabel.font = [UIFont boldSystemFontOfSize:17];
        [cell.contentView addSubview:titleLabel];
    }
    titleLabel.text = [NSString stringWithFormat:@"%ld",indexPath.item+1];
    
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.cellCount;
}
//
//cell size
- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat cellW = (SCREEN_WIDTH-30-2*10.5)/3.;
    CGFloat cellH = cellW/2.;
    CGSize size = CGSizeMake(cellW, cellH);
    return size;
}
@end
