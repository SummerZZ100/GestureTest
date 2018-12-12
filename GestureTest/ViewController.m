//
//  ViewController.m
//  GestureTest
//
//  Created by Zhang xiaosong on 2018/4/13.
//  Copyright © 2018年 Zhang xiaosong. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic,strong)UIImageView *imageView;

@property (nonatomic,assign)NSInteger index;

@property (nonatomic,strong)NSMutableArray *images;

@end

@implementation ViewController

#pragma mark - life cycle -


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self initInterface];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - internal methods -

- (void)initInterface
{
    self.index = 0;
    [self.imageView setFrame:CGRectMake(10, 100, 200, 300)];
    
    [self tapGestureRecognizer];
    
    [self swipeGestureRecognizer];
    
    [self longPressGestureRecognizer];
    
//    [self panGestureRecognizer];
    
//    [self pinchGestureRecognizer];
    
    [self rotationGestureRecognizer];
    
//    [self screenEdgePanGestureRecognizer];
    
}

/**
 轻拍手势
 */
- (void)tapGestureRecognizer
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapActioin:)];
    tap.numberOfTapsRequired = 1;//轻拍次数
    tap.numberOfTouchesRequired = 1;//轻拍手指个数
    [self.imageView addGestureRecognizer:tap];
}

- (void)tapActioin:(UITapGestureRecognizer *)tap
{
    self.index ++;
    if(self.index == 3){
        self.index = 0;
    }
    self.imageView.image = [UIImage imageNamed:self.images[self.index]];
}

/**
 轻扫手势
 */
- (void)swipeGestureRecognizer
{
    //一个轻扫手势 只能支持一个方向 （向上/向下/向左/向右）
    //如果想支持多个方向，需要添加多个手势
    
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeActioin:)];
    swipe.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.imageView addGestureRecognizer:swipe];
    
    UISwipeGestureRecognizer *swipe2 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeActioin:)];
    swipe2.direction = UISwipeGestureRecognizerDirectionRight;
    [self.imageView addGestureRecognizer:swipe2];
    
}

- (void)swipeActioin:(UISwipeGestureRecognizer *)swipe
{
    if(swipe.direction == UISwipeGestureRecognizerDirectionLeft){
        self.index ++;
        if(self.index == 3){
            self.index = 0;
        }
        self.imageView.image = [UIImage imageNamed:self.images[self.index]];
    }
    else if (swipe.direction == UISwipeGestureRecognizerDirectionRight){
        self.index --;
        if(self.index == -1){
            self.index = 2;
        }
        self.imageView.image = [UIImage imageNamed:self.images[self.index]];
    }
}

/**
 长按手势
 */
- (void)longPressGestureRecognizer
{
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)];
    //最短长按时间
    longPress.minimumPressDuration = 2;
    longPress.allowableMovement = 1;//允许移动最大距离
    [self.imageView addGestureRecognizer:longPress];
}

- (void)longPressAction:(UILongPressGestureRecognizer *)longPress
{
    if(longPress.state == UIGestureRecognizerStateBegan) {
        NSLog(@"长按开始");
        
    }
    else if (longPress.state == UIGestureRecognizerStateEnded){
        NSLog(@"长按结束");
    }
}


/**
 平移手势
 */
- (void)panGestureRecognizer
{
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
    [self.imageView addGestureRecognizer:pan];
}

- (void)panAction:(UIPanGestureRecognizer *)pan
{
    CGPoint position = [pan translationInView:self.imageView];
    self.imageView.transform = CGAffineTransformTranslate(self.imageView.transform, position.x, position.y);
    [pan setTranslation:CGPointZero inView:self.imageView];
}


/**
 捏合手势
 */
- (void)pinchGestureRecognizer
{
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchAction:)];
    [self.imageView addGestureRecognizer:pinch];
    
}

- (void)pinchAction:(UIPinchGestureRecognizer *)pinch
{
    self.imageView.transform = CGAffineTransformScale(self.imageView.transform, pinch.scale, pinch.scale);
    pinch.scale = 1;
}

/**
 旋转手势
 */
- (void)rotationGestureRecognizer
{
    UIRotationGestureRecognizer *rotation = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotationAction:)];
    [self.imageView addGestureRecognizer:rotation];
}

- (void)rotationAction:(UIRotationGestureRecognizer *)rotation
{
    self.imageView.transform = CGAffineTransformRotate(self.imageView.transform, rotation.rotation);
    rotation.rotation = 0;
}

/**
 边缘手势
 */
- (void)screenEdgePanGestureRecognizer
{
    UIScreenEdgePanGestureRecognizer *screenPan = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(screenPanAction:)];
    [self.imageView addGestureRecognizer:screenPan];
}

- (void)screenPanAction:(UIScreenEdgePanGestureRecognizer *)screenPan
{
    NSLog(@"边缘");
}






#pragma mark - lazy loading -

- (UIImageView *)imageView
{
    if(!_imageView){
        _imageView = [[UIImageView alloc] init];
        [_imageView setImage:[UIImage imageNamed:@"timgKuang.jpg"]];
        _imageView.userInteractionEnabled = YES;
        [self.view addSubview:_imageView];
    }
    return _imageView;
}

- (NSMutableArray *)images
{
    if(!_images){
        _images = [[NSMutableArray alloc] init];
        [_images addObject:@"timgKuang.jpg"];
        [_images addObject:@"timg2kuang.jpg"];
        [_images addObject:@"timg3Kuang.jpg"];
    }
    return _images;
}


@end
