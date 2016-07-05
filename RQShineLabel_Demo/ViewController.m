//
//  ViewController.m
//  RQShineLabel_Demo
//
//  Created by admin on 16/7/5.
//  Copyright © 2016年 AlezJi. All rights reserved.
//

#import "ViewController.h"
#import "RQShineLabel.h"
@interface ViewController ()
@property (strong, nonatomic) RQShineLabel *shineLabel;
@property (strong, nonatomic) NSArray *textArray;
@property (assign, nonatomic) NSUInteger textIndex;
@property (strong, nonatomic) UIImageView *wallpaper1;
@property (strong, nonatomic) UIImageView *wallpaper2;
@end

@implementation ViewController

- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super initWithCoder:decoder]) {
        _textArray = @[
                       @"For something this complicated, it’s really hard to design products by focus groups. A lot of times, people don’t know what they want until you show it to them.",
                       @"We’re just enthusiastic about what we do.",
                       @"We made the buttons on the screen look so good you’ll want to lick them."
                       ];
        _textIndex  = 0;
    }
    return self;
}




- (void)viewDidLoad
{
    [super viewDidLoad];
    //先放两张图片  第二张得图片设为透明
    self.wallpaper1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"wallpaper1"]];
    self.wallpaper1.contentMode = UIViewContentModeScaleAspectFill;
    self.wallpaper1.frame = self.view.bounds;
    [self.view addSubview:self.wallpaper1];
    
    self.wallpaper2 =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"wallpaper2"]];
    self.wallpaper2.contentMode = UIViewContentModeScaleAspectFill;
    self.wallpaper2.frame = self.view.bounds;
    self.wallpaper2.alpha = 0;
    [self.view addSubview:self.wallpaper2];
    
    
    //RQShineLabel
    self.shineLabel = [[RQShineLabel alloc] initWithFrame:CGRectMake(16, 16, self.view.frame.size.width - 32, CGRectGetHeight(self.view.bounds) - 16)];
    self.shineLabel.numberOfLines = 0;
    self.shineLabel.text = [self.textArray objectAtIndex:self.textIndex];
    self.shineLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:24.0];
    self.shineLabel.backgroundColor = [UIColor clearColor];
    [self.shineLabel sizeToFit];
    self.shineLabel.center = self.view.center;
    [self.view addSubview:self.shineLabel];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.shineLabel shine];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    if (self.shineLabel.isVisible) { //如果是可见的
        [self.shineLabel fadeOutWithCompletion:^{
            [self changeText];//改变文字
            [UIView animateWithDuration:2.5 animations:^{
                if (self.wallpaper1.alpha > 0.1) {
                    //如果图片1显示
                    //图片1隐藏   图片2不隐藏
                    self.wallpaper1.alpha = 0;
                    self.wallpaper2.alpha = 1;
                }
                else {
                    //如果图片2显示
                    //图片2隐藏   图片1不隐藏
                    self.wallpaper1.alpha = 1;
                    self.wallpaper2.alpha = 0;
                }
            }];
            [self.shineLabel shine]; 
        }];
    }
    else {
        [self.shineLabel shine];
    }
}

- (void)changeText
{
    self.shineLabel.text = self.textArray[(++self.textIndex) % self.textArray.count];
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
@end
