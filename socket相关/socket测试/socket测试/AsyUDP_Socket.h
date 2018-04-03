//
//  AsyUDP_Socket.h
//  socket测试
//
//  Created by Yutian Duan on 16/1/1.
//  Copyright © 2016年 Yutian Duan. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AsyncUdpSocket.h"

//
typedef void(^ReceiveBlock) (NSString *type,BOOL issuccssed);

typedef void(^FaildBlock) (void);

@interface AsyUDP_Socket : NSObject<AsyncUdpSocketDelegate> {
  AsyncUdpSocket *udpSocket;
  BOOL isconnectToHost;
}

- (void)starUDP;
- (void)loadview:(NSString *)string;


/**
 *  socket请求
 *
 *  @param type   请求类型
 *  @param legth  跟参长度
 *  @param string 参数文本
 */

- (void)sendtype:(Byte )type andlength:(NSInteger)legth andstring:(NSString *)string;

@property (nonatomic, strong)  NSString *type;
@property (nonatomic, copy) ReceiveBlock receiveBlock;
@property (nonatomic, copy) FaildBlock faildBlock;
@end

