# MooTive - An Objective-C Library Toolkit

Facing to the MVVM design pattern of GUI programming with iOS and OS X, I design a toolkit for engineers help them with their DAILY CODING.

面对用MVVM设计模式的iOS和OSX的GUI图形编程，我设计了一套工具面向工程师方便他们进行日常编码。

**Not like the other Toolkit. We don't like ```#define``` any data as Macro, which will pollute other code in your project. Instead, Object Oriented Programming is our goal and make your namespace clean.**

**不像其它的工具包，我们绝对不使用宏定义去污染别人的代码！取而代之，我们使用干净卫生的物件导向编程来达到这种目的并且让你的命名空间（可以写的名称）更加干净！**

There are 3 parts of MooTive:

这里MooTive有三个部分：

1. MooWeb - 用于替代AFNetwork作为网络底层
   1. Sync Data Request 同步数据请求
   2. Async Data Request 异步数据请求
2. MooModel - 基于MooWeb的抽象化数据对流模型扩展
   1. HTTP GET
   2. HTTP POST
   3. GET for JSON GET 获取 JSON
   4. POST for JSON POST 获取 JSON
3. MooCommon - 一些日常函数
   1. Color Conversion 颜色转换
   2. Angle Conversion 角度转换
   3. ImageView with Color 颜色绘图
   4. Alert Info 弹出消息
   5. Split by Dot 点分
   6. Split by Thousand 千分
   7. String Convert From Date 日期转字符串
   8. HmacMD5 加密算法
4. MooUI - 一些GUI类
   1. MooLoader 加载更多控件
   2. MooButton 按钮控件的扩展

## MooWeb

Object Stucture

对象结构

```objective-c
@interface MooWeb : NSObject

- (NSData *)curl:(NSString *)strUrl withMethod:(NSString *)method withParam:(NSMutableData *)param;

- (void)curl:(NSString *)strUrl withMethod:(NSString *)method withParam:(NSMutableData *)param completion:(void (^)(NSURLResponse * response, NSData * data, NSError * connectionError))completion;

@end
```

### Sync Data Request 同步数据请求

```objective-c
- (NSData *)curl:(NSString *)strUrl withMethod:(NSString *)method withParam:(NSMutableData *)param;
```

Details 详细：

| Param 参数 | Type 类型       | Example 示例          |
| -------- | ------------- | ------------------- |
| strUrl   | NSString      | @"http://localhost" |
| method   | NSString      | @"POST"             |
| param    | NSMutableData | N / A               |

### Async Data Request 异步数据请求

```objective-c
- (void)curl:(NSString *)strUrl withMethod:(NSString *)method withParam:(NSMutableData *)param completion:(void (^)(NSURLResponse * response, NSData * data, NSError * connectionError))completion;
```

Details 详细：

| Param 参数   | Type 类型       | Example 示例          |
| ---------- | ------------- | ------------------- |
| strUrl     | NSString      | @"http://localhost" |
| method     | NSString      | @"POST"             |
| param      | NSMutableData | N / A               |
| completion | Block         | N / A               |

## MooModel

Object Structure

对象模型

```objective-c
@interface MooModel : NSObject

- (void)get:(NSString *)path completion:(void (^)(NSData *data))completion;

- (void)post:(NSString *)path withParam:(NSMutableData *)param completion:(void (^)(NSData *data))completion;

- (void)getJSON:(NSString *)path completion:(void (^)(NSString *status, NSDictionary *data))completion;

- (void)postJSON:(NSString *)path withParam:(NSMutableData *)param completion:(void (^)(NSString *status, NSDictionary *data))completion;

@end
```

### HTTP GET

```objective-c
- (void)get:(NSString *)path completion:(void (^)(NSData *data))completion;
```

Details 详细：

| Param 参数   | Type 类型  | Example 示例          |
| ---------- | -------- | ------------------- |
| path       | NSString | @"http://localhost" |
| completion | Block    | N / A               |

### HTTP POST

```objective-c
- (void)post:(NSString *)path withParam:(NSMutableData *)param completion:(void (^)(NSData *data))completion;
```

Details 详细：

| Param 参数   | Type 类型       | Example 示例          |
| ---------- | ------------- | ------------------- |
| path       | NSString      | @"http://localhost" |
| param      | NSMutableData | N / A               |
| completion | Block         | N / A               |

### GET for JSON GET 获取 JSON

```objective-c
- (void)getJSON:(NSString *)path completion:(void (^)(NSString *status, NSDictionary *data))completion;
```

Details 详细：

| Param 参数   | Type 类型  | Example 示例          |
| ---------- | -------- | ------------------- |
| path       | NSString | @"http://localhost" |
| completion | Block    | N / A               |

### POST for JSON POST 获取 JSON

```objective-c
- (void)postJSON:(NSString *)path withParam:(NSMutableData *)param completion:(void (^)(NSString *status, NSDictionary *data))completion;
```

Details 详细：

| Param 参数   | Type 类型       | Example 示例          |
| ---------- | ------------- | ------------------- |
| path       | NSString      | @"http://localhost" |
| param      | NSMutableData | N / A               |
| completion | Block         | N / A               |

## MooCommon

Objective Struct

对象结构

```objective-c
@interface MooCommon : NSObject

- (UIColor *)colorFromRGBA:(int)rgbValue withAlphaValue:(int)alphaValue;

- (float)getRadian:(float)degree;

- (UIImage *)imageWithColor:(UIColor *)color withWidth:(CGFloat)width withHeight:(CGFloat)height;

@end
```

### Color Conversion 颜色转换

```objective-c
- (UIColor *)colorFromRGBA:(int)rgbValue withAlphaValue:(int)alphaValue;
```

Details 详细：

| Param 参数   | Type 类型 | Example 示例 |
| ---------- | ------- | ---------- |
| rgbValue   | int     | 0x00FFAA   |
| alphaValue | int     | 1          |

### Angle Conversion 角度转换

```objective-c
- (float)getRadian:(float)degree;
```

Details 详细：

| Param 参数 | Type 类型 | Example 示例 |
| -------- | ------- | ---------- |
| degree   | float   | 45         |

### ImageView with Color 颜色绘图

```objective-c
- (UIImage *)imageWithColor:(UIColor *)color withWidth:(CGFloat)width withHeight:(CGFloat)height;
```

Details 详细：

| Param 参数 | Type 类型 | Example 示例          |
| -------- | ------- | ------------------- |
| color    | UIColor | [UIColor blueColor] |
| width    | CGFloat | 100                 |
| height   | CGFloat | 100                 |

### Alert Info 弹出消息

```objective-c
- (void)alertInfo:(NSString *)title withMessage:(NSString *)message;
```

Details 详细：

| Param 参数 | Type 类型  | Example 示例      |
| -------- | -------- | --------------- |
| title    | NSString | @"Title"        |
| message  | NSString | @"Some Message" |

### Split by Dot 点分

```objective-c
- (NSArray *)splitByDot:(NSString *)number withOffset:(NSUInteger)offset;
```

Details 详细：

| Param 参数 | Type 类型    | Example 示例 |
| -------- | ---------- | ---------- |
| number   | NSString   | @"1.123"   |
| offset   | NSUInteger | 0 / 1      |

### Split by Thousand 千分

```objective-c
- (NSString *)splitByThousand:(NSString *)number;
```

Details 详细：

| Param 参数 | Type 类型  | Example 示例 |
| -------- | -------- | ---------- |
| number   | NSString | @"123456"  |

### String Conver From Date 日期转字符串

```objective-c
- (NSString *)stringConverFromDate:(NSDate *)date withFormat:(NSString *)format;
```

Details 详细：

| Param 参数 | Type 类型  | Example 示例    |
| -------- | -------- | ------------- |
| date     | NSDate   | [NSDate date] |
| format   | NSString | @"yyyy-MM-dd" |

### HmacMD5 加密函数

```objective-c
- (NSString *)HmacMD5:(NSString *)str WithKey:(NSString *)key;
```

Details 详细：

| Param 参数 | Type 类型  | Example 示例    |
| -------- | -------- | ------------- |
| str      | NSString | @"abcdef"     |
| key      | NSString | @"HelloWorld" |

## MooUI

### MooButton 按钮扩展

用法：

```objective-c
MooButton *btnMyButton = [[MooButton alloc] init];
[btnMyButton setMid:1];
[btnMyButton setData:[@{@"name": @"Jakit"}]];
[btnMyButton setInfo:@"Hello Jakit!"];
```

### MooLoader 加载更多

用法：

```objective-c
MooLoader *loader = [[MooLoader alloc] init];
[self.tableview setFooterview:loader];
[loader startDrag]; // 准备状态
[loader startLoading:^{
  // Some Code...
}]; // 开始状态
[loader endLoading]; // 结束状态
```



## Epilogue 后记

This is a Toolkit wrote in ObjectiveC and is of Moo Series. Document wrote in hurry so please don't mind. Thank you for your support!

这是Moo系列的ObjectiveC工具箱，文档赶时间写着比较急，^_^ 别介意，好用就OK！谢谢各位支持！