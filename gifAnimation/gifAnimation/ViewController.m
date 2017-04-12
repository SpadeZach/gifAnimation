//
//  ViewController.m
//  gifAnimation
//
//  Created by 赵博 on 17/4/12.
//  Copyright © 2017年 赵博. All rights reserved.
//

#import "ViewController.h"
#import <ImageIO/ImageIO.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self imgArr];
    
}
#pragma mark - 性能最好
- (void)imgWeb{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"snow" ofType:@"gif"];
    NSData *gifData = [NSData dataWithContentsOfFile:path];
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.width * 3 / 2)];
    webView.scalesPageToFit = YES;
    [webView loadData:gifData MIMEType:@"image/gif" textEncodingName:@"UTF-8" baseURL:[NSURL fileURLWithPath:@""]];
    webView.backgroundColor = [UIColor clearColor];
    webView.opaque = NO;
    [self.view addSubview:webView];
}

- (void)imgArr{
    NSURL *fileUrl = [[NSBundle mainBundle] URLForResource:@"snow" withExtension:@"gif"]; //加载GIF图片
    CGImageSourceRef gifSource = CGImageSourceCreateWithURL((CFURLRef) fileUrl, NULL);           //将GIF图片转换成对应的图片源
    size_t frameCout = CGImageSourceGetCount(gifSource);                                         //获取其中图片源个数，即由多少帧图片组成
    NSMutableArray *frames = [[NSMutableArray alloc] init];                                      //定义数组存储拆分出来的图片
    for (size_t i = 0; i < frameCout; i++) {
        CGImageRef imageRef = CGImageSourceCreateImageAtIndex(gifSource, i, NULL); //从GIF图片中取出源图片
        UIImage *imageName = [UIImage imageWithCGImage:imageRef];                  //将图片源转换成UIimageView能使用的图片源
        [frames addObject:imageName];                                              //将图片加入数组中
        CGImageRelease(imageRef);
    }
    UIImageView *gifImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
    gifImageView.animationImages = frames; //将图片数组加入UIImageView动画数组中
    gifImageView.animationDuration = 0.5f; //每次动画时长
    [gifImageView startAnimating];         //开启动画，此处没有调用播放次数接口，UIImageView默认播放次数为无限次，故这里不做处理
    [self.view addSubview:gifImageView];
}
@end
