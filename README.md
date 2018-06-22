# MooTive

Moo - Moo - Moo | Moo - Moo - Moo | Moo - Moo - Moo

## What's this?

An Objective-C Library Toolkit

## What problem does it solved?

For helping GUI programming with iOS, I design a toolkit for engineers help them with their DAILY CODING.

为辅助 iOS 和 OSX 的 GUI 图形编程，我设计了一套工具面向工程师方便他们进行日常编码。

There are 3 parts of MooTive:

这里MooTive有三大部分：

1. Common Classes - 公共类
   1. MooCommon - 一些日常函数
   2. MooData - 数据元
   3. MooModel - 数据模型
   4. MooWeb - 用于替代 AFNetwork 作为网络底层
2. MooUI - 界面类
   1. MooBadge - 徽章图形元素
   2. MooButton - 按钮元素
   3. MooCalendar - 日历界面
   4. MooClearView - 遮罩透明元素
   5. MooDing - 下弹式提示元素
   6. MooEmpty - 置于列表视图表示列表为空的元素
   7. MooLoader - 列表底部下拉以加载更多的元素
   8. MooPage - 分页元素
   9. MooPicture - 图片元素
   10. MooPictureDisplay - 多图片可组合切换界面
   11. MooShare - 分享至社交平台元素（支持微信、QQ）
   12. MooSlider - 幻灯片元素
   13. MooUnlock - 解锁界面
   14. MooWait - 等待刷新元素
   15. MooZoomPicture - 图片可拉伸预览元素
3. Component - 组件类
   1. MooCalendarBody - 日历界面主体组件
   2. MooCalendarCell - 日历界面细胞单元
   3. MooDataValue - 数据值
   4. MooDeviceInfo - 设备信息
   5. MooJSONResponse - JSON 请求返回信息
   6. MooShareMessage - 分享界面消息
   7. MooUnlockButton - 解锁按钮

## License

MooTive is released under the GPL Lincense.

MooTive 使用开源 GPL 协议。

## Examples

### MooWeb

Object Stucture

对象结构

```objective-c
@interface MooWeb : NSObject

- (NSData *)curl:(NSString *)strUrl withMethod:(NSString *)method withParam:(NSMutableData *)param;

- (void)curl:(NSString *)strUrl withMethod:(NSString *)method withParam:(NSMutableData *)param completion:(void (^)(NSURLResponse * response, NSData * data, NSError * connectionError))completion;

@end
```

#### Sync Data Request 同步数据请求

```objective-c
- (NSData *)curl:(NSString *)strUrl withMethod:(NSString *)method withParam:(NSMutableData *)param;
```

Details 详细：

| Param 参数 | Type 类型       | Example 示例          |
| -------- | ------------- | ------------------- |
| strUrl   | NSString      | @"http://localhost" |
| method   | NSString      | @"POST"             |
| param    | NSMutableData | N / A               |

#### Async Data Request 异步数据请求

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

### MooModel

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

#### HTTP GET

```objective-c
- (void)get:(NSString *)path completion:(void (^)(NSData *data))completion;
```

Details 详细：

| Param 参数   | Type 类型  | Example 示例          |
| ---------- | -------- | ------------------- |
| path       | NSString | @"http://localhost" |
| completion | Block    | N / A               |

#### HTTP POST

```objective-c
- (void)post:(NSString *)path withParam:(NSMutableData *)param completion:(void (^)(NSData *data))completion;
```

Details 详细：

| Param 参数   | Type 类型       | Example 示例          |
| ---------- | ------------- | ------------------- |
| path       | NSString      | @"http://localhost" |
| param      | NSMutableData | N / A               |
| completion | Block         | N / A               |

#### GET for JSON GET 获取 JSON

```objective-c
- (void)getJSON:(NSString *)path completion:(void (^)(NSString *status, NSDictionary *data))completion;
```

Details 详细：

| Param 参数   | Type 类型  | Example 示例          |
| ---------- | -------- | ------------------- |
| path       | NSString | @"http://localhost" |
| completion | Block    | N / A               |

#### POST for JSON POST 获取 JSON

```objective-c
- (void)postJSON:(NSString *)path withParam:(NSMutableData *)param completion:(void (^)(NSString *status, NSDictionary *data))completion;
```

Details 详细：

| Param 参数   | Type 类型       | Example 示例          |
| ---------- | ------------- | ------------------- |
| path       | NSString      | @"http://localhost" |
| param      | NSMutableData | N / A               |
| completion | Block         | N / A               |

### MooCommon

Objective Struct

对象结构

```objective-c
@interface MooCommon : NSObject

- (UIColor *)colorFromRGBA:(int)rgbValue withAlphaValue:(int)alphaValue;

- (float)getRadian:(float)degree;

- (UIImage *)imageWithColor:(UIColor *)color withWidth:(CGFloat)width withHeight:(CGFloat)height;

@end
```

#### Color Conversion 颜色转换

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

#### ImageView with Color 颜色绘图

```objective-c
- (UIImage *)imageWithColor:(UIColor *)color withWidth:(CGFloat)width withHeight:(CGFloat)height;
```

Details 详细：

| Param 参数 | Type 类型 | Example 示例          |
| -------- | ------- | ------------------- |
| color    | UIColor | [UIColor blueColor] |
| width    | CGFloat | 100                 |
| height   | CGFloat | 100                 |

#### Alert Info 弹出消息

```objective-c
- (void)alertInfo:(NSString *)title withMessage:(NSString *)message;
```

Details 详细：

| Param 参数 | Type 类型  | Example 示例      |
| -------- | -------- | --------------- |
| title    | NSString | @"Title"        |
| message  | NSString | @"Some Message" |

#### Split by Dot 点分

```objective-c
- (NSArray *)splitByDot:(NSString *)number withOffset:(NSUInteger)offset;
```

Details 详细：

| Param 参数 | Type 类型    | Example 示例 |
| -------- | ---------- | ---------- |
| number   | NSString   | @"1.123"   |
| offset   | NSUInteger | 0 / 1      |

#### Split by Thousand 千分

```objective-c
- (NSString *)splitByThousand:(NSString *)number;
```

Details 详细：

| Param 参数 | Type 类型  | Example 示例 |
| -------- | -------- | ---------- |
| number   | NSString | @"123456"  |

#### String Conver From Date 日期转字符串

```objective-c
- (NSString *)stringConverFromDate:(NSDate *)date withFormat:(NSString *)format;
```

Details 详细：

| Param 参数 | Type 类型  | Example 示例    |
| -------- | -------- | ------------- |
| date     | NSDate   | [NSDate date] |
| format   | NSString | @"yyyy-MM-dd" |

#### HmacMD5 加密函数

```objective-c
- (NSString *)HmacMD5:(NSString *)str WithKey:(NSString *)key;
```

Details 详细：

| Param 参数 | Type 类型  | Example 示例    |
| -------- | -------- | ------------- |
| str      | NSString | @"abcdef"     |
| key      | NSString | @"HelloWorld" |

### MooUI

#### MooButton 按钮扩展

用法：

```objective-c
MooButton *btnMyButton = [[MooButton alloc] init];
[btnMyButton setMid:1];
[btnMyButton setData:[@{@"name": @"Jakit"}]];
[btnMyButton setInfo:@"Hello Jakit!"];
```

#### MooLoader 加载更多

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


### Epilogue 后记

This is a Toolkit wrote in ObjectiveC and is of Moo Series. Document wrote in hurry so please don't mind. Thank you for your support!

这是 Moo 系列的 Objective-C 工具箱，文档赶时间写着比较急，^_^ 别介意，好用就 OK！感谢各位支持！
