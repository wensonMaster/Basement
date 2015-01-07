//
//  XBasic.h
//  Basement
//
//  Created by Dylan on 15/1/3.
//  Copyright (c) 2015年 Dylan. All rights reserved.
//

/* 容器类 */
typedef NSArray * XArray;
typedef NSDictionary * XDictionary;
typedef NSSet * XSet;

/* 数据类 */
typedef NSData * XData;
typedef int XInt;
typedef double XDouble;
typedef float XFloat;

/* 控件类 */
typedef UIImage * XImage;
typedef UIImageView * XImageView;

typedef UIScrollView * XScrollView;
typedef UITableView * XTableView;
typedef UICollectionView * XCollectionView;

typedef UIButton * XButton;
typedef UILabel * XLabel;
typedef UITextField * XTextField;
typedef UITextView * XTextView;

extern NSString * const errorMsg;

@interface XBasic : NSObject

//--------------------------------------------------------------
X_SINGLETON_DEC(XBasic)
//--------------------------------------------------------------

/*!
 *  @brief  错误信息打印
 *
 *  @param error 错误
 */
+ (void)logErrorMessageWith: (NSError *)error;

//--------------------------------------------------------------
//--------------------------------------------------------------

/*!
 *  @brief  返回所有的属性
 *
 *  @return 返回包含这个对象所有属性名称的数组
 */
+ (NSMutableArray *) ClassAttributes: (NSObject *)classModel;

/*!
 动画相关操作
 */
typedef enum {
    XAnimationTypeRotate,     // 自转动画
    XAnimationTypeWiggle,     // 不停摇摆动画
    XAnimationTypeShake,      // 不停摇晃动画
    XAnimationTypeRipple,     // 涟漪动画
    XAnimationTypeStretch,    // x轴变形动画
    XAnimationTypeBreath,     // 呼吸动画
} XAnimationActionType;       // 视图运动的动画类型

typedef enum {
    XAnimationTypeFadeIn,     // 渐隐效果出现
    XAnimationTypeBounce,     // 弹簧效果出现
    XAnimationTypePop,        // 弹跳效果出来 （由0放大后至1）
    XAnimationTypePopUp,       // 弹出放大效果 （由0放大后至1）
} XAnimationAppearType;       // 视图出现的动画类型

typedef enum {
    XAnimationTypeFadeOut,           // 渐隐效果消失
    XAnimationTypeBounceDisappear,   // 弹簧效果消失
    XAnimationTypePopDisappear,      // 弹跳效果消失 （放1放大后至0）
} XAnimationDisappearType;        // 视图消失的动画类型

typedef enum {
    XAnimationCellTypeScaleFadeIn,     // 由大及小渐入
    XAnimationCellTypeNarrowFadeIn,    // 由宽及窄渐入
} XAnimationCellType;               // cell出现方式的动画类型


// 根据视图出现的动画类型返回相应动画
+ (CAAnimation *)animationWithActionType:(XAnimationActionType)type;

// 根据视图出现的动画类型返回相应动画
+ (CAAnimation *)animationWithAppearType:(XAnimationAppearType)type;

// 根据视图出现的动画类型返回相应动画
+ (CAAnimation *)animationWithDisappearType:(XAnimationDisappearType)type;

// 根据视图出现的动画类型返回相应动画
+ (CAAnimation *)animationWithCellType:(XAnimationCellType)type;


+ (CAAnimation *)fadeInWithDuration:(NSTimeInterval)duration;
+ (CAAnimation *)fadeOutWithDuration:(NSTimeInterval)duration;
+ (CAAnimation *)rotateWithDuration:(NSTimeInterval)duration;
+ (CAAnimation *)wiggleWithDuration:(NSTimeInterval)duration repeatCount:(NSUInteger)count;
+ (CAAnimation *)shakeWithDuration:(NSTimeInterval)duration repeatCount:(NSUInteger)count;
+ (CAAnimation *)rippleWithDuration:(NSTimeInterval)duration repeatCount:(NSUInteger)count;
+ (CAAnimation *)stretchWithDuration:(NSTimeInterval)duration repeatCount:(NSUInteger)count;
+ (CAAnimation *)popWithDuration:(NSTimeInterval)duration;
+ (CAAnimation *)popDisappearWithDuration:(NSTimeInterval)duration;
@end

//--------------------------------------------------------------
//--------------------------------------------------------------

typedef NS_ENUM(NSInteger, XErasureDirection)
{
    XErasureAppearDirectionFromTop,    // 擦除 从上->下 出现
    XErasureAppearDirectionFromLeft,   // 擦除 从左->右 出现
    XErasureAppearDirectionFromBottom, // 擦除 从下->上 出现
    XErasureAppearDirectionFromRight,  // 擦除 从右->左 出现
    
    XErasureDisappearDirectionFromTop, // 擦除 从上->下 消失
    XErasureDisappearDirectionFromLeft,// 擦除 从左->右 消失
    XErasureDisappearDirectionFromBottom, // 擦除 从下->上 消失
    XErasureDisappearDirectionFromRight,  // 擦除 从右->左 消失
};

@interface UIView (AnimationCate)

/**
 *  擦除动画方式出现
 *
 *  @param duration  动画时长
 *  @param direction 擦除的方向
 */
- (void)appearUsingErasureWithDuration:(NSTimeInterval)duration direction:(XErasureDirection)direction;

/**
 *  擦除动画方式消失
 *
 *  @param duration  动画时长
 *  @param direction 擦除的方向
 */
- (void)disappearUsingErasureWithDuration:(NSTimeInterval)duration direction:(XErasureDirection)direction;

/**
 *  高斯模糊出现效果
 *
 *  @param duration 动画时长
 */
- (void)appearUsingBlurringWithDuration:(NSTimeInterval)duration;

/**
 *  高斯模糊消失效果
 *
 *  @param duration 动画时长
 */
- (void)disapparUsingBlurringWithDuration:(NSTimeInterval)duration;

@end

//--------------------------------------------------------------
//--------------------------------------------------------------

#import <Accelerate/Accelerate.h>
#import <QuartzCore/QuartzCore.h>

@interface UIImage (SizeImage)

#pragma mark rotation

/*
 图片旋转
 */
- (UIImage *)rotate:(UIImageOrientation)orient;

/*
 图片旋转并且根据maxSize 进行等比缩放
 */
- (UIImage *)rotateAndScaleFromCameraWithMaxSize:(CGFloat)maxSize;

/*
 图片根据maxSize 进行等比缩放
 */
- (UIImage *)scaleWithMaxSize:(CGFloat)maxSize;

/*
 图片根据maxSize和quality进行等比缩放
 */
- (UIImage*)scaleWithMaxSize:(CGFloat)maxSize
                     quality:(CGInterpolationQuality)quality;

// 自由翻转图片根据给出的degress, if degrees > 0 then rotation is ClockWise
- (UIImage *)rotateImage:(CGFloat) degrees;

/*
 自动旋转图片
 */
- (UIImage *)fixOrientation;

#pragma mark resize

/*
 *根据bounds 截取图片
 *The bounds will be adjusted using CGRectIntegral.
 *This method ignores the image's imageOrientation setting.
 */
- (UIImage *)croppedImage:(CGRect)bounds;

/*
 *根据给出的thumbnailSize 、borderSize、cornerRadius、quality 进行等比压缩图片
 *thumbnailSize 最大的宽或高
 *borderSize    图片边框大小
 *cornerRadius  圆角大小
 *quality       缩放质量
 */
- (UIImage *)thumbnailImage:(NSInteger)thumbnailSize
          transparentBorder:(NSUInteger)borderSize
               cornerRadius:(NSUInteger)cornerRadius
       interpolationQuality:(CGInterpolationQuality)quality;

/*
 *根据质量和size 压缩图片
 */
- (UIImage *)resizedImage:(CGSize)newSize
     interpolationQuality:(CGInterpolationQuality)quality;

/*
 *根据质量和size、UIViewContentMode 压缩图片
 */
- (UIImage *)resizedImageWithContentMode:(UIViewContentMode)contentMode
                                  bounds:(CGSize)bounds
                    interpolationQuality:(CGInterpolationQuality)quality;


/*
 *根据质量和size、transform 压缩图片
 *transform  变换方式
 *transpose  是否进行变换
 */
- (UIImage *)resizedImage:(CGSize)newSize
                transform:(CGAffineTransform)transform
           drawTransposed:(BOOL)transpose
     interpolationQuality:(CGInterpolationQuality)quality;

/*
 *根据cornerSize、borderSize 创建图片圆角效果
 *cornerSize  圆角大小
 *borderSize  边框大小
 */
- (UIImage *)roundedCornerImage:(NSInteger)cornerSize borderSize:(NSInteger)borderSize;


// Returns a copy of the given image, adding an alpha channel if it doesn't already have one
- (UIImage *)imageWithAlpha;


// Returns a copy of the image with a transparent border of the given size added around its edges.
// If the image has no alpha layer, one will be added to it.
- (UIImage *)transparentBorderImage:(NSUInteger)borderSize;

- (UIImage *)blurredImage:(CGFloat)blurAmount;

#pragma mark conversion/detection

// 把图片转换成灰度色用8位/像素 --converts UIImage to grayscale with 8bpp
+ (UIImage *)convertTo8bppGrayscaleFromImage:(UIImage *)uimage;

// 把图片转换成灰度色用8位/像素并且根据maxSize进行等比缩放 maxSize = -1 when you don't want to scale the image
+ (UIImage *)convertTo8bppGrayscaleFromImage:(UIImage *)image scaleToMaximumSize:(NSInteger) maxSize;

- (BOOL)hasAlpha;

//图片裁减兼容方法
-(UIImage*)safeResizableImageWithCapInsets:(UIEdgeInsets)capInsets;

//For SDK
+(UIImage*)imageNamedForSDK:(NSString *)name;

//没有缓存的读取资源图片
+(UIImage*)imageNamedNoCache:(NSString *)name;
+(UIImage*)retinaOnlyImageNamedNoCache:(NSString *)name;//不再支持1倍图
-(BOOL)isGifImage;
+(NSString *)getImageFilePath:(BOOL)bRetina Name:(NSString *)name;//根据是否是retina屏获取图片路径

@end

//--------------------------------------------------------------
//--------------------------------------------------------------

@interface NSData (MD5)

- (NSData *)MD5;
- (NSString *)MD5String;
- (NSString *)UTF8String;

+ (NSData *)dataFromBase64String:(NSString *)base64String;
- (id)initWithBase64String:(NSString *)base64String;
- (NSString *)base64EncodedString;

-(NSArray*)array;
-(NSDictionary*)dictionary;

/**
 *  仅用于图片数据的NSData，获取图片源的后缀名
 *
 *  @return 图片源的后缀名(.jpg,.png,.gif,.tiff,.bmp)
 */
- (NSString *)detectImageSuffix;

@end

typedef void (^XDateFormmaterConfigBlock)(NSDateFormatter *dateFormmater);

@interface NSDateFormatter (Format)

+ (NSDateFormatter *)dateFormatterWithFormat:(NSString *)format;

@end

#define D_MINUTE	60
#define D_HOUR		3600
#define D_DAY		86400
#define D_WEEK		604800
#define D_YEAR		31556926

//--------------------------------------------------------------
//--------------------------------------------------------------

@interface NSDate (CaluAndFormat)

- (NSString *)stringWithDateFormat:(NSString *)format;

+ (NSTimeInterval)timeIntervalSince1970;

+ (NSDate *) dateDayAfterTomorrow;
+ (NSDate *) dateTomorrow;
+ (NSDate *) dateYesterday;
+ (NSDate *) dateWithDaysFromNow: (NSUInteger) days;
+ (NSDate *) dateWithDaysBeforeNow: (NSUInteger) days;
+ (NSDate *) dateWithHoursFromNow: (NSUInteger) dHours;
+ (NSDate *) dateWithHoursBeforeNow: (NSUInteger) dHours;
+ (NSDate *) dateWithMinutesFromNow: (NSUInteger) dMinutes;
+ (NSDate *) dateWithMinutesBeforeNow: (NSUInteger) dMinutes;

// Comparing dates
- (BOOL) isEqualToDateIgnoringTime: (NSDate *) aDate;
- (BOOL) isToday;
- (BOOL) isTomorrow;
- (BOOL) isDayAfterTomorrow;
- (BOOL) isYesterday;
- (BOOL) isSameWeekAsDate: (NSDate *) aDate;
- (BOOL) isThisWeek;
- (BOOL) isNextWeek;
- (BOOL) isLastWeek;
- (BOOL) isSameYearAsDate: (NSDate *) aDate;
- (BOOL) isThisYear;
- (BOOL) isNextYear;
- (BOOL) isLastYear;
- (BOOL) isEarlierThanDate: (NSDate *) aDate;
- (BOOL) isLaterThanDate: (NSDate *) aDate;

// Adjusting dates
- (NSDate *) dateByAddingDays: (NSInteger) dDays;
- (NSDate *) dateBySubtractingDays: (NSUInteger) dDays;
- (NSDate *) dateByAddingHours: (NSInteger) dHours;
- (NSDate *) dateBySubtractingHours: (NSUInteger) dHours;
- (NSDate *) dateByAddingMinutes: (NSInteger) dMinutes;
- (NSDate *) dateBySubtractingMinutes: (NSUInteger) dMinutes;
- (NSDate *) dateAtStartOfDay;

// Retrieving intervals
- (NSInteger) minutesAfterDate: (NSDate *) aDate;
- (NSInteger) minutesBeforeDate: (NSDate *) aDate;
- (NSInteger) hoursAfterDate: (NSDate *) aDate;
- (NSInteger) hoursBeforeDate: (NSDate *) aDate;
- (NSInteger) daysAfterDate: (NSDate *) aDate;
- (NSInteger) daysBeforeDate: (NSDate *) aDate;

//转换日期为string
+ (NSString *)convertDateIntervalToStringWith:(NSString *)aInterVal;

// Decomposing dates
@property (readonly) NSInteger nearestHour;
@property (readonly) NSInteger hour;
@property (readonly) NSInteger minute;
@property (readonly) NSInteger seconds;
@property (readonly) NSInteger day;
@property (readonly) NSInteger month;
@property (readonly) NSInteger week;
@property (readonly) NSInteger weekday;
@property (readonly) NSInteger nthWeekday; // e.g. 2nd Tuesday of the month == 2
@property (readonly) NSInteger year;

/**
 *  创建指定格式的当前时间字符串
 *
 *  @param format 格式
 *
 *  @return 时间字符串
 */
+ (NSString *)stringWithDateFormat:(NSString *)format;

/**
 *  创建指定格式的指定时间字符串
 *
 *  @param timeInterval 时间戳
 *  @param format       格式
 *
 *  @return 时间字符串
 */
+ (NSString *)stringWithTimeInterval:(NSTimeInterval)timeInterval andDateFormat:(NSString *)format;

@end

//--------------------------------------------------------------
//--------------------------------------------------------------

@interface NSString (StringEncode)

//将dict转换为 key=value&key2=value2 的字符串追加到str
- (NSString *)urlByAppendingDict:(NSDictionary *)params;

//将dict转换为 key=value&key2=value2 的字符串
+ (NSString *)queryStringFromDictionary:(NSDictionary *)dict;

//计算md5
- (NSString *)MD5;

@end
