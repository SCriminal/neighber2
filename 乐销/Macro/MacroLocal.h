//
// MacroLocal.h
//中车运
//
// Created by 隋林栋 on 2016/12/13.
// Copyright © 2016年 ping. All rights reserved.
//

#ifndef MacroLocal_h
#define MacroLocal_h

//判断
#define isStr(T) ((T) && [(T) isKindOfClass:[NSString class]] && (T).length >0)
#define isValidDou(T) ((T) && [(T) isKindOfClass:[NSString class]] && [(T) doubleValue])
#define isAry(T) ((T) && [(T) isKindOfClass:[NSArray class]] && (T).count > 0)

#define isNum(T) ((T) && [(T) isKindOfClass:[NSNumber class]])
#define isDic(T) ((T) && [(T) isKindOfClass:[NSDictionary class]] && [(T) count] >0)

//判断手机号
#define isPhoneNum(T) ((T) && [(T) isKindOfClass:[NSString class]] && (T).length == 11)
#define isIdentityNum(T) ((T) && [(T) isKindOfClass:[NSString class]] && (T).length == 18)
#define isBusinessNum(T) ((T) && [(T) isKindOfClass:[NSString class]] && ((T).length == 18||(T).length == 15))


//解包
#define UnPackStr(T) (((T)&&([(T) isKindOfClass:NSString.class]||[(T) isKindOfClass:NSNumber.class]))?(T):@"")
//请求处理
#define RequestStrKey(T) (((T)&&[(T) isKindOfClass:NSString.class])?(T):[NSNull null])
#define RequestValidStrKey(T) (([(T) isKindOfClass:NSString.class]&&(T.length >0))?(T):[NSNull null])
#define RequestDoubleKey(T) ((T!=0)?(NSNumber.dou(T)):[NSNull null])
#define RequestLongKey(T) ((T!=0)?(NSNumber.lon(T)):[NSNull null])

//封装
#define strDotF(T) [NSString stringWithFormat:@"%.f",(T)]
#define strF(T) [NSString stringWithFormat:@"%lf",(T)]
#define strEnemy(T) [NSString stringWithFormat:@"%lu",(T)]

#define NUM_DOU(T) [NSNumber numberWithDouble:(T)]
#define NUM_INT(T) [NSNumber numberWithInt:(T)]

#define isIOS9 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0)
#define isIOS8 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define isIOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define isIOS6 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0)


#define RESPONSE_DATA @"data"//网络请求datas
#define RESPONSE_MESSAGE @"msg"//网络请求message
#define RESPONSE_CODE @"code"//网络请求提示码


#define RESPONSE_CHA_RET @"ret"//查好运的网络请求提示码
#define RESPONSE_CHA_DATA @"data"//查好运的网络请求datas

#define RESPONSE_CODE_SUCCESS 0//成功
#define RESPONSE_CODE_RELOGIN 1000//重新登陆

#define TIME_REQUEST_OUT 8
//选取照片数量
#define NUM_IMAGE 20
//Tag
#define TAG_LINE 371
#define TAG_KEYBOARD 372



#endif /* MacroLocal_h */
