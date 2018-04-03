//
//  ViewController.m
//  socket测试
//
//  Created by Yutian Duan on 16/1/1.
//  Copyright © 2016年 Yutian Duan. All rights reserved.
//

#import "ViewController.h"

#import "AsyUDP_Socket.h"

#import "HYAlertView.h"

@interface ViewController () {
  UITextField *myTexFile;
}

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // 登陆
  UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(10, 200, 100, 100)];
  [button setTitle:@"登录" forState:0];
  button.backgroundColor = [UIColor redColor];
  [button addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:button];
  
  
  // 注册
  UIButton *loadbutton = [[UIButton alloc] initWithFrame:CGRectMake(120, 200, 100, 100)];
  [loadbutton setTitle:@"注册" forState:0];
  loadbutton.backgroundColor = [UIColor redColor];
  [loadbutton addTarget:self action:@selector(load) forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:loadbutton];
  
  
  myTexFile = [[UITextField alloc] initWithFrame:CGRectMake(10, 100, 200, 50)];
  myTexFile.placeholder = @"请输入帐号!";
  myTexFile.backgroundColor = [UIColor lightGrayColor];
  myTexFile.keyboardType = UIKeyboardTypeNumberPad;
  [self.view addSubview:myTexFile];
  
  
  
  
  
  // Do any additional setup after loading the view, typically from a nib.
}


- (void)click {

  if (myTexFile.text.length == 0) {
    HYAlertView *myalertview = [[HYAlertView alloc] initWithTitle:@"温馨提示" message:@"请输入帐号" buttonTitles:@"好的", nil];
    myalertview.alertViewStyle = 0;
    [myalertview showWithCompletion:^(HYAlertView *alertView, NSInteger selectIndex) {
      NSLog(@"点击了%d", (int)selectIndex);
    
    }];
    return;
  }
  
  
  if (myTexFile.text.length != 11) {
    HYAlertView *myalertview = [[HYAlertView alloc] initWithTitle:@"温馨提示" message:@"请输入正确的帐号" buttonTitles:@"好的", nil];
    
    
    myalertview.alertViewStyle = 0;
    
    [myalertview showWithCompletion:^(HYAlertView *alertView, NSInteger selectIndex) {
      NSLog(@"点击了%d", (int)selectIndex);
      
      
      
    }];
    
    return;
  }
  
  AsyUDP_Socket *socket = [[AsyUDP_Socket alloc] init];
  [socket starUDP];
  [socket sendtype:0x02 andlength:11 andstring:myTexFile.text];
  
  socket.receiveBlock = ^(NSString *type,BOOL isSuccced) {
    
    if (isSuccced) {
      
      HYAlertView *myalertview = [[HYAlertView alloc] initWithTitle:@"温馨提示" message:@"登录成功" buttonTitles:@"好的", nil];
      
      myalertview.alertViewStyle = 0;
      
      [myalertview showWithCompletion:^(HYAlertView *alertView, NSInteger selectIndex) {
        NSLog(@"点击了%d", (int)selectIndex);
        
        
        
      }];
      
    } else {
      HYAlertView *myalertview = [[HYAlertView alloc] initWithTitle:@"温馨提示" message:@"登录失败" buttonTitles:@"好的", nil];
      
      myalertview.alertViewStyle = 0;
      
      [myalertview showWithCompletion:^(HYAlertView *alertView, NSInteger selectIndex) {
        NSLog(@"点击了%d", (int)selectIndex);
        
        
        
      }];
      
      
      
    }
  
    
    
  };
  
  
}



- (void)load {
  
  if (myTexFile.text.length == 0) {
    HYAlertView *myalertview = [[HYAlertView alloc] initWithTitle:@"温馨提示" message:@"请输入帐号" buttonTitles:@"好的", nil];
    
    
    myalertview.alertViewStyle = 0;
    
    [myalertview showWithCompletion:^(HYAlertView *alertView, NSInteger selectIndex) {
      NSLog(@"点击了%d", (int)selectIndex);
      
      
      
    }];
    
    return;
  }
  
  
  if (myTexFile.text.length != 11) {
    HYAlertView *myalertview = [[HYAlertView alloc] initWithTitle:@"温馨提示" message:@"请输入正确的帐号" buttonTitles:@"好的", nil];
    
    
    myalertview.alertViewStyle = 0;
    
    [myalertview showWithCompletion:^(HYAlertView *alertView, NSInteger selectIndex) {
      NSLog(@"点击了%d", (int)selectIndex);
      
      
      
    }];
    return;
    
  }
  
  AsyUDP_Socket *socket = [[AsyUDP_Socket alloc] init];
  
  [socket starUDP];
  
  [socket sendtype:0x01 andlength:11 andstring:myTexFile.text];
  
  //    [socket sen:mytextfile.text];
  
  socket.faildBlock = ^(void) {
    HYAlertView *myalertview = [[HYAlertView alloc] initWithTitle:@"温馨提示" message:@"服务器未响应" buttonTitles:@"好的", nil];
    
    myalertview.alertViewStyle = 0;
    
    [myalertview showWithCompletion:^(HYAlertView *alertView, NSInteger selectIndex) {
      NSLog(@"点击了%d", (int)selectIndex);
      
      
    }];
    
    
    
    
  };
  
  socket.receiveBlock = ^(NSString *type,BOOL isSuccced) {
    
    if (isSuccced) {
      
      HYAlertView *myalertview = [[HYAlertView alloc] initWithTitle:@"温馨提示" message:@"注册成功" buttonTitles:@"好的", nil];
      
      
      myalertview.alertViewStyle = 0;
      
      [myalertview showWithCompletion:^(HYAlertView *alertView, NSInteger selectIndex) {
        NSLog(@"点击了%d", (int)selectIndex);
        
        
        
      }];
      
    } else {
      HYAlertView *myalertview = [[HYAlertView alloc] initWithTitle:@"温馨提示" message:@"注册失败" buttonTitles:@"好的", nil];
      
      
      myalertview.alertViewStyle = 0;
      
      [myalertview showWithCompletion:^(HYAlertView *alertView, NSInteger selectIndex) {
        NSLog(@"点击了%d", (int)selectIndex);
        
        
        
      }];
      
      
      
    }
    
    
    
    
    
  };
  
  
  
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end

