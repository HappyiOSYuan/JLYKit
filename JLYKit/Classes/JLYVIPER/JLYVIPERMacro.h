//
//  JLYVIPERMacro.h
//  Pods
//
//  Created by 袁宁 on 2016/11/25.
//
//

#ifndef JLYVIPERMacro_h
#define JLYVIPERMacro_h
//获取一个类的类
#define JLY_Class(Class) [Class class]
#define JLYRealProtocol(nowPort,oldPort) ((nowPort)(oldPort))

typedef void (^JLYCallBackHandler)(id _Nullable callBackParameters);
typedef void (^JLYCompletionHandler)(id _Nullable obj ,NSError * _Nullable error);

#endif /* JLYVIPERMacro_h */
