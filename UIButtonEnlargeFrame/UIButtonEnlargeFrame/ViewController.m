//
//  ViewController.m
//  UIButtonEnlargeFrame
//
//  Created by 王宇辰 on 2022/9/18.
//

#import "ViewController.h"
#import "UIButton+EnlargeClickZone.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    button.backgroundColor = [UIColor blackColor];
    [button addTarget:self action:@selector(buttonclick) forControlEvents:UIControlEventTouchUpInside];
    [button setEnlargeEdgeWithTop:50 right:50 bottom:50 left:50];
    [self.view addSubview:button];
    
}

- (void)buttonclick
{
    NSLog(@"CLICK");
}


@end
