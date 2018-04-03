//
//  AsyUDP_Socket.m
//  socket测试
//
//  Created by Yutian Duan on 16/1/1.
//  Copyright © 2016年 Yutian Duan. All rights reserved.
//

#import "AsyUDP_Socket.h"

@implementation AsyUDP_Socket

- (instancetype)init {
  self = [super init];
  if (self) {
    
    
  }
  return self;
}

- (void)starUDP {
  udpSocket = [[AsyncUdpSocket alloc] initWithDelegate:self];
  [udpSocket setRunLoopModes:[NSArray arrayWithObject:NSRunLoopCommonModes]];
  [udpSocket receiveWithTimeout:10 tag:2];
  // 端口 和服务器的ip都改了
  isconnectToHost =  [udpSocket connectToHost:@"192.168.3.254" onPort:5000 error:nil];
  
  if (isconnectToHost) {
    NSLog(@"连接成功！");
  } else {
    NSLog(@"连接失败");
  }
}


- (void)loadview:(NSString *)string {
  
  Byte outdate[19];
  
  outdate[0] = 0x3E;
  outdate[1] = 0x3F;
  outdate[2] = 0x00;
  outdate[3] = 0x02; // 协议类型  01 注册  02 登录 03 忘记密码
  
  outdate[4] = 0x00;
  outdate[5] = 0x00;
  outdate[6] = 0x00;
  outdate[7] = 0x0b;
  
  for (int i = 0; i < string.length; i++) {
    
    int asciiCode = [string characterAtIndex:i]; // 65
    outdate[8+i]  = asciiCode;
    NSLog(@"----%x",outdate[8+i]);
  }
  NSData *udpPacketData = [[[NSData alloc] initWithBytes:outdate length:19] autorelease];
  [udpSocket sendData:udpPacketData withTimeout:10 tag:1];
}


- (void)sendtype:(Byte )type andlength:(NSInteger)legth andstring:(NSString *)string {
  
  NSInteger bytelen = 8 + legth;
  
  Byte outdate[bytelen];
  
  outdate[0] = 0x3E;
  outdate[1] = 0x3F;
  outdate[2] = 0x00;
  
  outdate[3] = type; // 协议类型  01 注册  02 登录 03 忘记密码
  
  outdate[4] = 0x00;
  outdate[5] = 0x00;
  outdate[6] = 0x00;
  
  //整形 到时转为 Byte
  outdate[7] = (Byte)legth;  // 跟参的长度
  for (int i = 0; i < legth; i++) {
    int asciiCode = [string characterAtIndex:i]; // 65
    outdate[8+i]  = asciiCode;
  }
  NSData *udpPacketData = [[[NSData alloc] initWithBytes:outdate length:bytelen] autorelease];
  NSLog(@"--%@",udpPacketData);
  [udpSocket sendData:udpPacketData withTimeout:10 tag:1];
}

#pragma mark-代理协议
- (BOOL)onUdpSocket:(AsyncUdpSocket *)sock didReceiveData:(NSData *)data withTag:(long)tag fromHost:(NSString *)host port:(UInt16)port {
  NSLog(@"----%@",data);
  Byte *AckByte = (Byte *)[data bytes];
  NSLog(@"-1--%x",AckByte[0]);
  NSLog(@"-2--%x",AckByte[1]);
  NSLog(@"-3--%x",AckByte[2]);
  NSLog(@"-4--%x",AckByte[3]);
  NSLog(@"-5--%x",AckByte[4]);
  NSLog(@"-6--%x",AckByte[5]);
  
  if ((AckByte[3]&0x02)  == (Byte)0x02) {
    // 判断是登陆
    _type = @"登陆";
    if ( AckByte[4] == (Byte)0x0c) {
      NSLog(@"成功登陆----%d",AckByte[4] == 0x0c);
      _receiveBlock(_type,YES);
    } else {
      NSLog(@"失败登陆");
      _receiveBlock(_type,NO);
    }
  }
  return YES;
}

- (void)onUdpSocket:(AsyncUdpSocket *)sock didNotSendDataWithTag:(long)tag dueToError:(NSError *)error {
  NSLog(@"didNotSendDataWithTag----");
  
}

- (void)onUdpSocket:(AsyncUdpSocket *)sock didNotReceiveDataWithTag:(long)tag dueToError:(NSError *)error {
  NSLog(@"didNotReceiveDataWithTag----服务器未响应");
  if (self.faildBlock) {
    _faildBlock();
  }
}

- (void)onUdpSocket:(AsyncUdpSocket *)sock didSendDataWithTag:(long)tag {
  NSLog(@"didSendDataWithTag----");
}


- (void)onUdpSocketDidClose:(AsyncUdpSocket *)sock {
  NSLog(@"onUdpSocketDidClose----");
}



@end

