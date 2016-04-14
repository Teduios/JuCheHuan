//
//  MWImageViewController.m
//  BaseProject
//
//  Created by CHC on 16/1/5.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "MWImageViewController.h"
#import <UIImageView+WebCache.h>

@interface MWImageViewController () <UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) UIBarButtonItem *downloadItem;

@end

@implementation MWImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.imageUrl) {
        [self addNavigationItem];
        [self.imageView sd_setImageWithURL:self.imageUrl placeholderImage:[UIImage imageNamed:@"Poppies"]];
    } else {
        [self.imageView setImage:self.image];
    }
    
    
    [self addGesture];
}
-(void)addNavigationItem
{
        self.downloadItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"28"] style:UIBarButtonItemStylePlain target:self action:@selector(downloadImage)];
        self.navigationItem.rightBarButtonItem = self.downloadItem;
}
-(void)downloadImage
{
    //images文件夹路径
    NSString *pathString = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *creatPath = [pathString stringByAppendingPathComponent:@"images"];
    // 图片存储路径
    NSString *imageName = [self.imageUrl absoluteString];
    NSString *filePath = [creatPath stringByAppendingPathComponent:[imageName lastPathComponent]];
    
    NSData *imageData = [NSData dataWithContentsOfFile:filePath];
    if (imageData) {
        NSLog(@"已经下载图片");
    } else {
        SDWebImageDownloader *downloader = [SDWebImageDownloader sharedDownloader];
        [downloader downloadImageWithURL:self.imageUrl options:SDWebImageDownloaderProgressiveDownload progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            MYLog(@"progress tracking ");
        } completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
            if (image && finished) {
                self.imageView.image = image;
                
                
                NSLog(@"%@", creatPath);
                // 如果不存在文件夹就创建
                if (![[NSFileManager defaultManager] fileExistsAtPath:creatPath]) {
                    NSError *error = nil;
                    [[NSFileManager defaultManager] createDirectoryAtPath:creatPath withIntermediateDirectories:YES attributes:nil error:&error];
                }
                
                // 将图片存到沙盒中
                NSData *imageData;
                if (UIImagePNGRepresentation(image) == nil) {
                    imageData = UIImageJPEGRepresentation(image, 1);
                } else {
                    imageData = UIImagePNGRepresentation(image);
                }
                [imageData writeToFile:filePath atomically:YES];
            }
        }];
    }
}

-(void)addGesture
{
    UIPinchGestureRecognizer *pinchGR = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(pinch:)];
    // 为了手势并存,需要设置手势的代理
    pinchGR.delegate = self;
    [self.view addGestureRecognizer:pinchGR];
    
    // 添加旋转手势
//    UIRotationGestureRecognizer *rotationGR = [[UIRotationGestureRecognizer alloc]initWithTarget:self action:@selector(rotation:)];
//    rotationGR.delegate = self;
//    [self.view addGestureRecognizer:rotationGR];
    
    // 添加拖拽手势
    UIPanGestureRecognizer *panGR = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
    [self.view addGestureRecognizer:panGR];
    
    // 添加一个支持双击的手势
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    tapGR.numberOfTapsRequired = 2;
    [self.view addGestureRecognizer:tapGR];

}
//捏合手势实现图片的缩放变形
-(void)pinch:(UIPinchGestureRecognizer *)pinchRec
{
    self.imageView.transform = CGAffineTransformScale(self.imageView.transform, pinchRec.scale, pinchRec.scale);
    pinchRec.scale = 1;
}
// 旋转手势实现旋转变形
-(void)rotation:(UIRotationGestureRecognizer *)gr
{
    self.imageView.transform = CGAffineTransformRotate(self.imageView.transform, gr.rotation);
    //使用完本次弧度后,将这一次的弧度归0
    gr.rotation = 0;
}

// 拖拽手势实现位移的变形
-(void)pan:(UIPanGestureRecognizer *)gr
{
    CGPoint distance = [gr translationInView:self.imageView];
    self.imageView.transform = CGAffineTransformTranslate(self.imageView.transform, distance.x, distance.y);
    [gr setTranslation:CGPointZero inView:self.imageView];
}

// 两个手势允许同时识别
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

-(void)tap:(UITapGestureRecognizer *)gr
{
    // 通过系统提供的一个常量,将transform恢复
    self.imageView.transform = CGAffineTransformIdentity;
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
