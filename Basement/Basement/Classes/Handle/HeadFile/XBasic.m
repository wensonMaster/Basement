//
//  XBasic.m
//  Basement
//
//  Created by Dylan on 15/1/3.
//  Copyright (c) 2015年 Dylan. All rights reserved.
//

#import "XBasic.h"

NSString * const errorMsg = @"出错误了";

@interface XBasic ()



@end

@implementation XBasic

//--------------------------------------------------------------
X_SINGLETON_DEF(XBasic)
//------------------------------------------------------------------

+ (void)logErrorMessageWith:(NSError *)error {
    
    XLogOut(@"domain: %@, code: %ld, des: %@ %@", [error domain], [error code], [error localizedDescription], errorMsg)
}

#pragma mark - allAttributes
/*!
 *  @author Dylan
 *
 *  @brief  返回所有的属性
 *
 *  @param classModel 传入一个对象
 *
 *  @return 返回包含这个对象所有属性名称的数组
 */
+ (NSMutableArray *) ClassAttributes: (NSObject *)classModel {
    
    NSMutableArray * data = [NSMutableArray array];
    NSString *className = NSStringFromClass([classModel class]);
    const char * cClassName = [className UTF8String];
    
    id classM = objc_getClass(cClassName);
    unsigned int outCount, i;
    objc_property_t * properties = class_copyPropertyList(classM, &outCount);
    
    for (i = 0; i < outCount; i++) {
        
        objc_property_t property = properties[i];
        NSString * attributeName = [NSString stringWithUTF8String:property_getName(property)];
        
        [data addObject:attributeName];
    }
    return data;
}

//------------------------------------------------------------------
//------------------------------------------------------------------
+ (CAAnimation *)animationWithAppearType:(XAnimationAppearType)type
{
    CAAnimation *animation = nil;
    
    switch(type)
    {
        case XAnimationTypeFadeIn:
            animation = [XBasic fadeInWithDuration:0.25];
            break;
        case XAnimationTypeBounce:
            break;
        case XAnimationTypePop:
            animation = [XBasic popWithDuration:0.45];
            break;
        case XAnimationTypePopUp:
            animation = [XBasic popUpWithDuration:0.25];
            break;
        default:
            break;
    }
    
    return animation;
}

+ (CAAnimation *)animationWithDisappearType:(XAnimationDisappearType)type
{
    CAAnimation *animation = nil;
    
    switch(type)
    {
        case XAnimationTypeFadeOut:
            animation = [XBasic fadeInWithDuration:0.25];
            break;
        case XAnimationTypeBounceDisappear:
            break;
        default:
            break;
    }
    
    return animation;
}

+ (CAAnimation *)animationWithActionType:(XAnimationActionType)type
{
    CAAnimation *animation = nil;
    switch (type)
    {
        case XAnimationTypeRotate:
            animation = [XBasic rotateWithDuration:0.25];
            break;
        case XAnimationTypeWiggle:
            animation = [XBasic wiggleWithDuration:0.25 repeatCount:5];
            break;
        case XAnimationTypeShake:
            animation = [XBasic shakeWithDuration:0.25 repeatCount:5];
            break;
        case XAnimationTypeStretch:
            animation = [XBasic stretchWithDuration:0.25 repeatCount:3];
            break;
        case XAnimationTypeRipple:
            animation = [XBasic rippleWithDuration:0.25 repeatCount:3];
            break;
        case XAnimationTypeBreath:
            animation = [XBasic breathWithDuration:0.25 repeatCount:3];
            break;
        default:
            break;
    }
    return animation;
}

+ (CAAnimation *)animationWithCellType:(XAnimationCellType)type
{
    CAAnimation *animation = nil;
    
    switch (type)
    {
        case XAnimationCellTypeScaleFadeIn:
            animation = [XBasic cellScaleAndFadeIn:0.25];
            break;
        case XAnimationCellTypeNarrowFadeIn:
            animation = [XBasic cellNarrowAndFadeIn:0.25];
            break;
        default:
            break;
    }
    
    return animation;
}

#pragma mark - Appear Animation

+ (CAAnimation *)fadeInWithDuration:(NSTimeInterval)duration
{
    CABasicAnimation *fadeIn = [CABasicAnimation animationWithKeyPath:@"opacity"];
    fadeIn.fromValue = [NSNumber numberWithFloat:0.0];
    fadeIn.toValue = [NSNumber numberWithFloat:1.0];
    fadeIn.duration = duration;
    return fadeIn;
}

#pragma mark - Disappear Animation

+ (CAAnimation *)fadeOutWithDuration:(NSTimeInterval)duration
{
    CABasicAnimation *fadeIn = [CABasicAnimation animationWithKeyPath:@"opacity"];
    fadeIn.fromValue = [NSNumber numberWithFloat:1.0];
    fadeIn.toValue = [NSNumber numberWithFloat:0.0];
    fadeIn.duration = duration;
    return fadeIn;
}

#pragma mark - Action Animation

+ (CAAnimation *)rotateWithDuration:(NSTimeInterval)duration
{
    CABasicAnimation *rotate = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotate.fromValue = @(0);
    rotate.toValue = @(M_PI * 2);
    rotate.duration = duration;
    rotate.repeatCount = HUGE_VAL;
    return rotate;
}

+ (CAAnimation *)wiggleWithDuration:(NSTimeInterval)duration repeatCount:(NSUInteger)count
{
    CABasicAnimation *wiggle = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    wiggle.fromValue = @(M_PI / 8);
    wiggle.toValue = @(-M_PI / 8);
    wiggle.duration = duration;
    wiggle.repeatCount = count;
    return wiggle;
}

#pragma mark - Shake Animation

+ (CAAnimation *)shakeWithDuration:(NSTimeInterval)duration repeatCount:(NSUInteger)count
{
    return [XBasic stretchWithDuration:0.25 fromValue:-10 toValue:10 repeatCount:count];
}

+ (CAAnimation *)shakeWithDuration:(NSTimeInterval)duration fromValue:(float)fromValue toValue:(float)toValue repeatCount:(NSUInteger)count
{
    CABasicAnimation *shake = [CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
    shake.fromValue = @(fromValue);
    shake.toValue = @(toValue);
    shake.repeatCount = count;
    shake.duration = duration;
    return shake;
}

#pragma mark - Ripple

+ (CAAnimation *)rippleWithDuration:(NSTimeInterval)duration repeatCount:(NSUInteger)count
{
    CATransition *transition = [CATransition animation];
    transition.duration = 0.5;
    transition.timingFunction = UIViewAnimationCurveEaseInOut;
    transition.type = @"rippleEffect";
    return transition;
}

#pragma mark - Stretch Animation

+ (CAAnimation *)stretchWithDuration:(NSTimeInterval)duration repeatCount:(NSUInteger)count
{
    return [XBasic stretchWithDuration:duration fromValue:1.0 toValue:1.08 repeatCount:count];
}

+ (CAAnimation *)stretchWithDuration:(NSTimeInterval)duration fromValue:(float)fromValue toValue:(float)toValue repeatCount:(NSUInteger)count
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale.x"];
    animation.fromValue = @(fromValue);
    animation.toValue = @(toValue);
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.repeatCount = count;
    animation.duration = duration;
    animation.autoreverses = YES;
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    return animation;
}

#pragma mark - Breath Animation

+ (CAAnimation *)breathWithDuration:(NSTimeInterval)duration repeatCount:(NSUInteger)count
{
    CABasicAnimation *breath = [CABasicAnimation animationWithKeyPath:@"opacity"];
    breath.fromValue = [NSNumber numberWithFloat:1.0];
    breath.toValue = [NSNumber numberWithFloat:0.0];
    breath.duration = duration;
    breath.repeatCount = count;
    breath.autoreverses = YES;
    return breath;
}

#pragma mark - Cell Animation

+ (CAAnimation *)cellScaleAndFadeIn:(NSTimeInterval)duration
{
    CABasicAnimation *scale = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scale.duration = duration;
    scale.fromValue = @(1.08);
    scale.toValue = @(1);
    scale.fillMode = kCAFillModeForwards;
    scale.removedOnCompletion = NO;
    
    CABasicAnimation *fadeIn = [CABasicAnimation animationWithKeyPath:@"opacity"];
    fadeIn.duration = duration;
    fadeIn.fromValue = @(0);
    fadeIn.toValue = @(1);
    fadeIn.fillMode = kCAFillModeForwards;
    fadeIn.removedOnCompletion = NO;
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[scale, fadeIn];
    group.duration = duration;
    group.fillMode = kCAFillModeForwards;
    group.removedOnCompletion = NO;
    
    return group;
}

+ (CAAnimation *)cellNarrowAndFadeIn:(NSTimeInterval)duration
{
    CABasicAnimation *narrow = [CABasicAnimation animationWithKeyPath:@"transform.scale.x"];
    narrow.duration = duration;
    narrow.fromValue = @(1.08);
    narrow.toValue = @(1.0);
    narrow.fillMode = kCAFillModeForwards;
    narrow.removedOnCompletion = NO;
    
    CABasicAnimation *fadeIn = [CABasicAnimation animationWithKeyPath:@"opacity"];
    fadeIn.duration = duration;
    fadeIn.fromValue = @(0);
    fadeIn.toValue = @(1);
    fadeIn.fillMode = kCAFillModeForwards;
    fadeIn.removedOnCompletion = NO;
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[narrow, fadeIn];
    group.duration = duration;
    group.fillMode = kCAFillModeForwards;
    group.removedOnCompletion = NO;
    
    return group;
}

+ (CAAnimation *)popWithDuration:(NSTimeInterval)duration
{
    NSTimeInterval zoomInDuration = duration * 0.5;
    NSTimeInterval zoomOutDuration = duration * 0.5;
    
    CABasicAnimation *zoomIn = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    zoomIn.duration = zoomInDuration;
    zoomIn.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    zoomIn.fromValue = @(0);
    zoomIn.toValue = @(1.35);
    zoomIn.fillMode = kCAFillModeForwards;
    zoomIn.removedOnCompletion = NO;
    
    CABasicAnimation *zoomOut = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    zoomOut.beginTime = zoomInDuration;
    zoomOut.duration = zoomOutDuration;
    zoomOut.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    zoomOut.fromValue = @(1.35);
    zoomOut.toValue = @(1.0);
    zoomOut.fillMode = kCAFillModeForwards;
    zoomOut.removedOnCompletion = NO;
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[zoomIn, zoomOut];
    group.duration = duration;
    group.fillMode = kCAFillModeForwards;
    group.removedOnCompletion = NO;
    
    return  group;
}

+ (CAAnimation *)popUpWithDuration:(NSTimeInterval)duration
{
    CABasicAnimation *zoomIn = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    zoomIn.duration = duration;
    zoomIn.fromValue = @(0.1);
    zoomIn.toValue = @(1.0);
    zoomIn.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    zoomIn.fillMode = kCAFillModeForwards;
    zoomIn.removedOnCompletion = NO;
    
    return zoomIn;
}

+ (CAAnimation *)popDisappearWithDuration:(NSTimeInterval)duration
{
    NSTimeInterval zoomInDuration = duration * 0.5;
    NSTimeInterval zoomOutDuration = duration * 0.5;
    
    CABasicAnimation *zoomIn = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    zoomIn.duration = zoomInDuration;
    zoomIn.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    zoomIn.fromValue = @(1);
    zoomIn.toValue = @(1.35);
    zoomIn.fillMode = kCAFillModeForwards;
    zoomIn.removedOnCompletion = NO;
    
    CABasicAnimation *zoomOut = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    zoomOut.beginTime = zoomInDuration;
    zoomOut.duration = zoomOutDuration;
    zoomOut.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    zoomOut.fromValue = @(1.35);
    zoomOut.toValue = @(0.0);
    zoomOut.fillMode = kCAFillModeForwards;
    zoomOut.removedOnCompletion = NO;
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[zoomIn, zoomOut];
    group.duration = duration;
    group.fillMode = kCAFillModeForwards;
    group.removedOnCompletion = NO;
    
    return  group;
}

@end

@implementation UIView (AnimationCate)

- (void)appearUsingErasureWithDuration:(NSTimeInterval)duration direction:(XErasureDirection)direction
{
    CAShapeLayer *mask = [CAShapeLayer layer];
    mask.path = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
    mask.backgroundColor = [UIColor whiteColor].CGColor;
    mask.frame = self.bounds;
    
    self.layer.mask = mask;
    
    CABasicAnimation *eraseAnimation = nil;
    
    if (direction == XErasureAppearDirectionFromTop)
    {
        eraseAnimation = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
        eraseAnimation.fromValue = @(-self.bounds.size.height);
        eraseAnimation.toValue = @(0);
    }
    else if (direction == XErasureAppearDirectionFromLeft)
    {
        eraseAnimation = [CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
        eraseAnimation.fromValue = @(-self.bounds.size.width);
        eraseAnimation.toValue = @(0);
    }
    else if (direction == XErasureAppearDirectionFromBottom)
    {
        eraseAnimation = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
        eraseAnimation.fromValue = @(self.bounds.size.height);
        eraseAnimation.toValue = @(0);
    }
    else if (direction == XErasureAppearDirectionFromRight)
    {
        eraseAnimation = [CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
        eraseAnimation.fromValue = @(self.bounds.size.width);
        eraseAnimation.toValue = @(0);
    }
    
    eraseAnimation.duration = duration;
    eraseAnimation.fillMode = kCAFillModeForwards;
    eraseAnimation.removedOnCompletion = NO;
    
    [self.layer.mask addAnimation:eraseAnimation forKey:@"erasure"];
}

- (void)disappearUsingErasureWithDuration:(NSTimeInterval)duration direction:(XErasureDirection)direction
{
    CAShapeLayer *mask = [CAShapeLayer layer];
    mask.path = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
    mask.backgroundColor = [UIColor whiteColor].CGColor;
    mask.frame = self.bounds;
    
    self.layer.mask = mask;
    
    CABasicAnimation *eraseAnimation = nil;
    
    if (direction == XErasureDisappearDirectionFromTop)
    {
        eraseAnimation = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
        eraseAnimation.fromValue = @(0);
        eraseAnimation.toValue = @(self.bounds.size.height);
    }
    else if (direction == XErasureDisappearDirectionFromLeft)
    {
        eraseAnimation = [CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
        eraseAnimation.fromValue = @(0);
        eraseAnimation.toValue = @(self.bounds.size.width);
    }
    else if (direction == XErasureDisappearDirectionFromBottom)
    {
        eraseAnimation = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
        eraseAnimation.fromValue = @(0);
        eraseAnimation.toValue = @(-self.bounds.size.height);
    }
    else if (direction == XErasureDisappearDirectionFromRight)
    {
        eraseAnimation = [CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
        eraseAnimation.fromValue = (0);
        eraseAnimation.toValue = @(-self.bounds.size.width);
    }
    
    eraseAnimation.duration = duration;
    eraseAnimation.fillMode = kCAFillModeForwards;
    eraseAnimation.removedOnCompletion = NO;
    
    [self.layer.mask addAnimation:eraseAnimation forKey:@"erasure"];
}

#pragma mark - Blurring Animation

- (void)appearUsingBlurringWithDuration:(NSTimeInterval)duration
{
    UIGraphicsBeginImageContext(self.bounds.size);
    
    if ([self respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)])
    {
        [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:NO];
    }
    else
    {
        [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    }
    
    UIImage *blurredImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    NSData *imageData = UIImageJPEGRepresentation(blurredImage, .0001);
    UIImage *blurredSnapshot = [[UIImage imageWithData:imageData] blurredImage:0.6];
    
    UIImageView *blurred = [[UIImageView alloc] initWithImage:blurredSnapshot];
    [self addSubview:blurred];
    
    [UIView animateWithDuration:2.5 animations:^{
        blurred.alpha = 0.0f;
    } completion:^(BOOL finished) {
        [blurred removeFromSuperview];
    }];
}

- (void)disapparUsingBlurringWithDuration:(NSTimeInterval)duration
{
    UIGraphicsBeginImageContext(self.bounds.size);
    
    if ([self respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)])
    {
        [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:NO];
    }
    else
    {
        [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    }
    
    UIImage *blurredImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    NSData *imageData = UIImageJPEGRepresentation(blurredImage, .0001);
    UIImage *blurredSnapshot = [[UIImage imageWithData:imageData] blurredImage:0.6];
    
    UIImageView *blurred = [[UIImageView alloc] initWithImage:blurredSnapshot];
    [self addSubview:blurred];
    
    blurred.alpha = 0.0f;
    [UIView animateWithDuration:2.5 animations:^{
        blurred.alpha = 1.0f;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
@end

static inline CGSize swapWidthAndHeight(CGSize size) {
    CGFloat swap = size.width;
    size.width  = size.height;
    size.height = swap;
    return size;
}

static inline CGFloat degreesToRadians(CGFloat degrees) {
    return M_PI * (degrees / 180.0);
}

static int temporaryImageAngle;
static inline CGFloat toRadians (CGFloat degrees) { return degrees * M_PI/180.0f; }

//images on iPhone should be no bigger than 1024, making images bigger than 1024 may cause crashes caused by not enough memory
#define maximumResultImageSize 1024
//indicates how many lines we check, when put 40 in here, 1 line is checked, 40th line, 80th line and so on
//the bigger the number the less concrete the result but faster detection
#define lineCheckingStep 40


@implementation UIImage (SizeImage)

- (UIImage *)rotate:(UIImageOrientation)orient{
    CGRect bnds = CGRectZero;
    UIImage *copy = nil;
    CGContextRef ctxt = nil;
    CGRect rect = CGRectZero;
    CGAffineTransform tran = CGAffineTransformIdentity;
    
    bnds.size = self.size;
    rect.size = self.size;
    
    switch (orient) {
        case UIImageOrientationUp:
            return self;
            
        case UIImageOrientationUpMirrored:
            tran = CGAffineTransformMakeTranslation(rect.size.width, 0.0);
            tran = CGAffineTransformScale(tran, -1.0, 1.0);
            break;
            
        case UIImageOrientationDown:
            tran = CGAffineTransformMakeTranslation(rect.size.width,
                                                    rect.size.height);
            tran = CGAffineTransformRotate(tran, degreesToRadians(180.0));
            break;
            
        case UIImageOrientationDownMirrored:
            tran = CGAffineTransformMakeTranslation(0.0, rect.size.height);
            tran = CGAffineTransformScale(tran, 1.0, -1.0);
            break;
            
        case UIImageOrientationLeft:
            bnds.size = swapWidthAndHeight(bnds.size);
            tran = CGAffineTransformMakeTranslation(0.0, rect.size.width);
            tran = CGAffineTransformRotate(tran, degreesToRadians(-90.0));
            break;
            
        case UIImageOrientationLeftMirrored:
            bnds.size = swapWidthAndHeight(bnds.size);
            tran = CGAffineTransformMakeTranslation(rect.size.height, rect.size.width);
            tran = CGAffineTransformScale(tran, -1.0, 1.0);
            tran = CGAffineTransformRotate(tran, degreesToRadians(-90.0));
            break;
            
        case UIImageOrientationRight:
            bnds.size = swapWidthAndHeight(bnds.size);
            tran = CGAffineTransformMakeTranslation(rect.size.height, 0.0);
            tran = CGAffineTransformRotate(tran, degreesToRadians(90.0));
            break;
            
        case UIImageOrientationRightMirrored:
            bnds.size = swapWidthAndHeight(bnds.size);
            tran = CGAffineTransformMakeScale(-1.0, 1.0);
            tran = CGAffineTransformRotate(tran, degreesToRadians(90.0));
            break;
            
        default:
            // orientation value supplied is invalid
            assert(false);
            return nil;
    }
    
    UIGraphicsBeginImageContext(bnds.size);
    ctxt = UIGraphicsGetCurrentContext();
    
    switch (orient) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            CGContextScaleCTM(ctxt, -1.0, 1.0);
            CGContextTranslateCTM(ctxt, -rect.size.height, 0.0);
            break;
            
        default:
            CGContextScaleCTM(ctxt, 1.0, -1.0);
            CGContextTranslateCTM(ctxt, 0.0, -rect.size.height);
            break;
    }
    
    CGContextConcatCTM(ctxt, tran);
    CGContextDrawImage(ctxt, rect, self.CGImage);
    
    copy = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return copy;
}

- (UIImage *)rotateAndScaleFromCameraWithMaxSize:(CGFloat)maxSize{
    UIImage *imag = self;
    imag = [imag rotate:imag.imageOrientation];
    imag = [imag scaleWithMaxSize:maxSize];
    return imag;
}


- (UIImage *)scaleWithMaxSize:(CGFloat)maxSize{
    return [self scaleWithMaxSize:maxSize quality:kCGInterpolationHigh];
}


- (UIImage*)scaleWithMaxSize:(CGFloat)maxSize
                     quality:(CGInterpolationQuality)quality
{
    CGRect        bnds = CGRectZero;
    UIImage*      copy = nil;
    CGContextRef  ctxt = nil;
    CGRect        orig = CGRectZero;
    CGFloat       rtio = 0.0;
    CGFloat       scal = 1.0;
    
    bnds.size = self.size;
    orig.size = self.size;
    rtio = orig.size.width / orig.size.height;
    
    if ((orig.size.width <= maxSize) && (orig.size.height <= maxSize))
    {
        return self;
    }
    
    if (rtio > 1.0)
    {
        bnds.size.width  = maxSize;
        bnds.size.height = maxSize / rtio;
    }
    else
    {
        bnds.size.width  = maxSize * rtio;
        bnds.size.height = maxSize;
    }
    
    //UIGraphicsBeginImageContext(bnds.size);
    UIGraphicsBeginImageContextWithOptions(bnds.size, NO, 0);
    ctxt = UIGraphicsGetCurrentContext();
    
    scal = bnds.size.width / orig.size.width;
    CGContextSetInterpolationQuality(ctxt, quality);
    CGContextScaleCTM(ctxt, scal, -scal);
    CGContextTranslateCTM(ctxt, 0.0, -orig.size.height);
    CGContextDrawImage(ctxt, orig, self.CGImage);
    
    copy = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return copy;
}

- (UIImage *)fixOrientation
{
    // No-op if the orientation is already correct
    if (self.imageOrientation == UIImageOrientationUp) return self;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (self.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, self.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, self.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
            
        default:
            break;
    }
    
    switch (self.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        default:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, self.size.width, self.size.height,
                                             CGImageGetBitsPerComponent(self.CGImage), 0,
                                             CGImageGetColorSpace(self.CGImage),
                                             CGImageGetBitmapInfo(self.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (self.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.height,self.size.width), self.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.width,self.size.height), self.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}


#pragma mark -
#pragma mark Rotation
+ (unsigned char) avarageColorOfThe8bppImageBorder:(UIImage *) image {
    NSAssert(image, @"can't find average color of nil image");
    NSInteger bpp = CGImageGetBitsPerPixel(image.CGImage);
    if(bpp != 8){
        image = [UIImage convertTo8bppGrayscaleFromImage:image];
    }
    
    CFDataRef data = CGDataProviderCopyData(CGImageGetDataProvider(image.CGImage));
    unsigned char *rawData = (unsigned char *) CFDataGetBytePtr(data);
    NSInteger height = image.size.height;
    NSInteger width = image.size.width;
    NSInteger bytesPerRow = CGImageGetBytesPerRow(image.CGImage);
    
    NSInteger avarageColor = 0;
    NSInteger samplesTakenInHorizontal = width  >> 1;
    NSInteger samplesTakenInVertical = height  >> 1;
    
    NSInteger w, h; //random
    unsigned char c;
    for(NSInteger i = 0; i < samplesTakenInHorizontal; i+=2){
        //top line border
        h = 0;
        w = arc4random() % width;
        c = *(rawData + bytesPerRow*h + w);
        avarageColor += c;
        //bottom line
        h = height - 1;
        w = arc4random() % width;
        c = *(rawData + bytesPerRow*h + w);
        avarageColor += c;
    }
    for(NSInteger i = 0; i < samplesTakenInVertical; i += 2){
        //left line
        w = 0;
        h = arc4random() % height;
        c = *(rawData + bytesPerRow*h + w);
        avarageColor += c;
        //right line
        w = width - 1;
        h = arc4random() % height;
        c = *(rawData + bytesPerRow*h + w);
        avarageColor += c;
    }
    avarageColor = avarageColor / (samplesTakenInVertical+samplesTakenInHorizontal);
    if(data != NULL){
        CFRelease(data);
    }
    return avarageColor;
}

//if degrees < 0 than rotation is clockWise, otherwise CounterClockWise
+ (CGPoint) rotatePoint:(CGPoint)point byDegrees:(CGFloat) degrees aroundOriginPoint:(CGPoint) origin {
    CGPoint rotated = CGPointMake(0.0f, 0.0f);
    CGFloat radians = toRadians(degrees);
    rotated.x = cos(radians) * (point.x-origin.x) - sin(radians) * (point.y-origin.y) + origin.x;
    rotated.y = sin(radians) * (point.x-origin.x) + cos(radians) * (point.y-origin.y) + origin.y;
    return rotated;
}


+ (CGPoint) getPointAtIndex:(NSUInteger) index ofRect:(CGRect) rect {
    CGPoint point = rect.origin;
    if(index == 1){
        point.x += CGRectGetWidth(rect);
    } else if(index == 2){
        point.y += CGRectGetHeight(rect);
    } else if(index == 3){
        point.y += CGRectGetHeight(rect);
        point.x += CGRectGetWidth(rect);
    }
    
    return point;
}

+ (CGSize) imageSizeForRect:(CGRect) rect rotatedByDegreees:(CGFloat) degrees {
    CGPoint rotationOrigin = CGPointMake(0.0f, 0.0f);
    CGFloat maxX = 0, minX = INT_MAX, maxY = 0, minY = INT_MAX;
    
    for(NSInteger i = 0; i < 4; ++i){
        CGPoint toRotate = [UIImage getPointAtIndex:i ofRect:rect];
        CGPoint rotated = [UIImage rotatePoint:toRotate byDegrees:degrees aroundOriginPoint:rotationOrigin];
        minX = MIN(minX, rotated.x);
        minY = MIN(minY, rotated.y);
        maxX = MAX(maxX, rotated.x);
        maxY = MAX(maxY, rotated.y);
    }
    CGSize newSize = CGSizeMake(maxX - minX, maxY - minY);
    return newSize;
}

//clockwise when degrees < 0
- (UIImage *) rotateImage:(CGFloat) degrees {
    CGSize newImageSize = [UIImage imageSizeForRect:CGRectMake(0.0f, 0.0f, self.size.width, self.size.height) rotatedByDegreees:degrees];
    //if the new ImageSize will be bigger than 1024 then we need to scale the image
    CGFloat maximum = MAX(newImageSize.width, newImageSize.height);
    CGFloat scaleFactor = 1.0f;
    if(maximum > maximumResultImageSize){
        scaleFactor = maximumResultImageSize/maximum;
    }
    
    UIGraphicsBeginImageContext(CGSizeMake(newImageSize.width*scaleFactor, newImageSize.height*scaleFactor));
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIGraphicsPushContext(context);
    CGRect drawingRect = CGRectMake(0.0f, 0.0f, newImageSize.width*scaleFactor, newImageSize.height*scaleFactor);
    
    unsigned char midColor = [UIImage avarageColorOfThe8bppImageBorder:self];
    
    [[UIColor colorWithRed:midColor/255.0 green:midColor/255.0 blue:midColor/255.0 alpha:1.0f] set];
    CGContextFillRect(context, CGRectInset(drawingRect, -2, -2));
    
    CGContextTranslateCTM(context, drawingRect.size.width/2, drawingRect.size.height/2);
    CGContextRotateCTM(context, toRadians(degrees));
    
    [self drawInRect:CGRectMake((-self.size.width*scaleFactor)/2, (-self.size.height*scaleFactor)/2, self.size.width*scaleFactor, self.size.height*scaleFactor)];
    UIGraphicsPopContext();
    UIImage *copy = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return copy;
}

- (UIImage *)rotateImageandRotateAngle:(UIImageOrientation)orientation {
    UIGraphicsBeginImageContext(self.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIGraphicsPushContext(context);
    if (orientation == UIImageOrientationRight) {
        CGContextRotateCTM (context, toRadians(90));
    }
    else if (orientation == UIImageOrientationLeft) {
        CGContextRotateCTM (context, toRadians(-90));
    }
    else if (orientation == UIImageOrientationDown) {
        // NOTHING
    }
    else if (orientation == UIImageOrientationUp) {
        CGContextTranslateCTM(context, self.size.width, 0.0f);
        CGContextRotateCTM (context, toRadians(90));
    }
    [self drawAtPoint:CGPointMake(0, 0)];
    UIGraphicsPopContext();
    return UIGraphicsGetImageFromCurrentImageContext();
}

#pragma mark resize

- (UIImage *)croppedImage:(CGRect)bounds {
    CGImageRef imageRef = CGImageCreateWithImageInRect([self CGImage], bounds);
    UIImage *croppedImage = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    return croppedImage;
}


- (UIImage *)thumbnailImage:(NSInteger)thumbnailSize
          transparentBorder:(NSUInteger)borderSize
               cornerRadius:(NSUInteger)cornerRadius
       interpolationQuality:(CGInterpolationQuality)quality {
    UIImage *resizedImage = [self resizedImageWithContentMode:UIViewContentModeScaleAspectFill
                                                       bounds:CGSizeMake(thumbnailSize, thumbnailSize)
                                         interpolationQuality:quality];
    
    // Crop out any part of the image that's larger than the thumbnail size
    // The cropped rect must be centered on the resized image
    // Round the origin points so that the size isn't altered when CGRectIntegral is later invoked
    CGRect cropRect = CGRectMake(round((resizedImage.size.width - thumbnailSize) / 2),
                                 round((resizedImage.size.height - thumbnailSize) / 2),
                                 thumbnailSize,
                                 thumbnailSize);
    UIImage *croppedImage = [resizedImage croppedImage:cropRect];
    
    UIImage *transparentBorderImage = borderSize ? [croppedImage transparentBorderImage:borderSize] : croppedImage;
    
    return [transparentBorderImage roundedCornerImage:cornerRadius borderSize:borderSize];
}

- (UIImage *)resizedImage:(CGSize)newSize
     interpolationQuality:(CGInterpolationQuality)quality {
    BOOL drawTransposed;
    CGAffineTransform transform = CGAffineTransformIdentity;
    // In iOS 5 the image is already correctly rotated. See Eran Sandler's
    // addition here: http://eran.sandler.co.il/2011/11/07/uiimage-in-ios-5-orientation-and-resize/
    if ( [[[UIDevice currentDevice] systemVersion] floatValue] >= 5.0 )
    {
        drawTransposed = NO;
    }
    else
    {
        switch ( self.imageOrientation )
        {
            case UIImageOrientationLeft:
            case UIImageOrientationLeftMirrored:
            case UIImageOrientationRight:
            case UIImageOrientationRightMirrored:
                drawTransposed = YES;
                break;
            default:
                drawTransposed = NO;
        }
        
        transform = [self transformForOrientation:newSize];
    }
    
    return [self resizedImage:newSize transform:transform drawTransposed:drawTransposed interpolationQuality:quality];
}


- (UIImage *)resizedImageWithContentMode:(UIViewContentMode)contentMode
                                  bounds:(CGSize)bounds
                    interpolationQuality:(CGInterpolationQuality)quality {
    CGFloat horizontalRatio = bounds.width / self.size.width;
    CGFloat verticalRatio = bounds.height / self.size.height;
    CGFloat ratio;
    
    switch (contentMode) {
        case UIViewContentModeScaleAspectFill:
            ratio = MAX(horizontalRatio, verticalRatio);
            break;
            
        case UIViewContentModeScaleAspectFit:
            ratio = MIN(horizontalRatio, verticalRatio);
            break;
            
        default:
            [NSException raise:NSInvalidArgumentException format:@"Unsupported content mode: %d", (int)contentMode];
    }
    
    CGSize newSize = CGSizeMake(self.size.width * ratio, self.size.height * ratio);
    
    return [self resizedImage:newSize interpolationQuality:quality];
}



- (UIImage *)resizedImage:(CGSize)newSize
                transform:(CGAffineTransform)transform
           drawTransposed:(BOOL)transpose
     interpolationQuality:(CGInterpolationQuality)quality {
    CGRect newRect = CGRectIntegral(CGRectMake(0, 0, newSize.width, newSize.height));
    CGRect transposedRect = CGRectMake(0, 0, newRect.size.height, newRect.size.width);
    CGImageRef imageRef = self.CGImage;
    // Fix for a colorspace / transparency issue that affects some types of
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef bitmap =CGBitmapContextCreate( NULL,
                                               newRect.size.width,
                                               newRect.size.height,
                                               8,
                                               0,
                                               colorSpace,
                                               (CGBitmapInfo)kCGImageAlphaPremultipliedLast );
    CGColorSpaceRelease(colorSpace);
    
    // Rotate and/or flip the image if required by its orientation
    CGContextConcatCTM(bitmap, transform);
    
    // Set the quality level to use when rescaling
    CGContextSetInterpolationQuality(bitmap, quality);
    
    // Draw into the context; this scales the image
    CGContextDrawImage(bitmap, transpose ? transposedRect : newRect, imageRef);
    
    // Get the resized image from the context and a UIImage
    CGImageRef newImageRef = CGBitmapContextCreateImage(bitmap);
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    
    // Clean up
    CGContextRelease(bitmap);
    CGImageRelease(newImageRef);
    
    return newImage;
}


- (CGAffineTransform)transformForOrientation:(CGSize)newSize {
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (self.imageOrientation) {
        case UIImageOrientationDown:           // EXIF = 3
        case UIImageOrientationDownMirrored:   // EXIF = 4
            transform = CGAffineTransformTranslate(transform, newSize.width, newSize.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:           // EXIF = 6
        case UIImageOrientationLeftMirrored:   // EXIF = 5
            transform = CGAffineTransformTranslate(transform, newSize.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:          // EXIF = 8
        case UIImageOrientationRightMirrored:  // EXIF = 7
            transform = CGAffineTransformTranslate(transform, 0, newSize.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (self.imageOrientation) {
        case UIImageOrientationUpMirrored:     // EXIF = 2
        case UIImageOrientationDownMirrored:   // EXIF = 4
            transform = CGAffineTransformTranslate(transform, newSize.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:   // EXIF = 5
        case UIImageOrientationRightMirrored:  // EXIF = 7
            transform = CGAffineTransformTranslate(transform, newSize.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    return transform;
}


// Returns a copy of the image with a transparent border of the given size added around its edges.
// If the image has no alpha layer, one will be added to it.
- (UIImage *)transparentBorderImage:(NSUInteger)borderSize {
    // If the image does not have an alpha layer, add one
    UIImage *image = [self imageWithAlpha];
    
    CGRect newRect = CGRectMake(0, 0, image.size.width + borderSize * 2, image.size.height + borderSize * 2);
    
    // Build a context that's the same dimensions as the new size
    CGContextRef bitmap = CGBitmapContextCreate(NULL,
                                                newRect.size.width,
                                                newRect.size.height,
                                                CGImageGetBitsPerComponent(self.CGImage),
                                                0,
                                                CGImageGetColorSpace(self.CGImage),
                                                CGImageGetBitmapInfo(self.CGImage));
    
    // Draw the image in the center of the context, leaving a gap around the edges
    CGRect imageLocation = CGRectMake(borderSize, borderSize, image.size.width, image.size.height);
    CGContextDrawImage(bitmap, imageLocation, self.CGImage);
    CGImageRef borderImageRef = CGBitmapContextCreateImage(bitmap);
    
    // Create a mask to make the border transparent, and combine it with the image
    CGImageRef maskImageRef = [self newBorderMask:borderSize size:newRect.size];
    CGImageRef transparentBorderImageRef = CGImageCreateWithMask(borderImageRef, maskImageRef);
    UIImage *transparentBorderImage = [UIImage imageWithCGImage:transparentBorderImageRef];
    
    // Clean up
    CGContextRelease(bitmap);
    CGImageRelease(borderImageRef);
    CGImageRelease(maskImageRef);
    CGImageRelease(transparentBorderImageRef);
    
    return transparentBorderImage;
}

- (UIImage*)blurredImage:(CGFloat)blurAmount
{
    if (blurAmount < 0.0 || blurAmount > 1.0) {
        blurAmount = 0.5;
    }
    
    int boxSize = (int)(blurAmount * 40);
    boxSize = boxSize - (boxSize % 2) + 1;
    
    CGImageRef img = self.CGImage;
    
    vImage_Buffer inBuffer, outBuffer;
    vImage_Error error;
    
    void *pixelBuffer;
    
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
    
    inBuffer.width = CGImageGetWidth(img);
    inBuffer.height = CGImageGetHeight(img);
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    inBuffer.data = (void*)CFDataGetBytePtr(inBitmapData);
    
    pixelBuffer = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
    
    outBuffer.data = pixelBuffer;
    outBuffer.width = CGImageGetWidth(img);
    outBuffer.height = CGImageGetHeight(img);
    outBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    
    if (!error) {
        error = vImageBoxConvolve_ARGB8888(&outBuffer, &inBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
        
        if (!error) {
            error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
        }
    }
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    CGContextRef ctx = CGBitmapContextCreate(outBuffer.data,
                                             outBuffer.width,
                                             outBuffer.height,
                                             8,
                                             outBuffer.rowBytes,
                                             colorSpace,
                                             (CGBitmapInfo)kCGImageAlphaNoneSkipLast);
    
    CGImageRef imageRef = CGBitmapContextCreateImage (ctx);
    
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
    
    CGContextRelease(ctx);
    CGColorSpaceRelease(colorSpace);
    
    free(pixelBuffer);
    CFRelease(inBitmapData);
    
    CGColorSpaceRelease(colorSpace);
    CGImageRelease(imageRef);
    
    return returnImage;
}

// Returns true if the image has an alpha layer
- (BOOL)hasAlpha {
    CGImageAlphaInfo alpha = CGImageGetAlphaInfo(self.CGImage);
    return (alpha == kCGImageAlphaFirst ||
            alpha == kCGImageAlphaLast ||
            alpha == kCGImageAlphaPremultipliedFirst ||
            alpha == kCGImageAlphaPremultipliedLast);
}

// Returns a copy of the given image, adding an alpha channel if it doesn't already have one
- (UIImage *)imageWithAlpha {
    if ([self hasAlpha]) {
        return self;
    }
    
    CGImageRef imageRef = self.CGImage;
    size_t width = CGImageGetWidth(imageRef);
    size_t height = CGImageGetHeight(imageRef);
    
    // The bitsPerComponent and bitmapInfo values are hard-coded to prevent an "unsupported parameter combination" error
    CGContextRef offscreenContext = CGBitmapContextCreate(NULL,
                                                          width,
                                                          height,
                                                          8,
                                                          0,
                                                          CGImageGetColorSpace(imageRef),
                                                          kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedFirst);
    
    // Draw the image into the context and retrieve the new image, which will now have an alpha layer
    CGContextDrawImage(offscreenContext, CGRectMake(0, 0, width, height), imageRef);
    CGImageRef imageRefWithAlpha = CGBitmapContextCreateImage(offscreenContext);
    UIImage *imageWithAlpha = [UIImage imageWithCGImage:imageRefWithAlpha];
    
    // Clean up
    CGContextRelease(offscreenContext);
    CGImageRelease(imageRefWithAlpha);
    
    return imageWithAlpha;
}


// Creates a mask that makes the outer edges transparent and everything else opaque
// The size must include the entire mask (opaque part + transparent border)
// The caller is responsible for releasing the returned reference by calling CGImageRelease
- (CGImageRef)newBorderMask:(NSUInteger)borderSize size:(CGSize)size {
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    
    // Build a context that's the same dimensions as the new size
    CGContextRef maskContext = CGBitmapContextCreate(NULL,
                                                     size.width,
                                                     size.height,
                                                     8, // 8-bit grayscale
                                                     0,
                                                     colorSpace,
                                                     kCGBitmapByteOrderDefault | kCGImageAlphaNone);
    
    // Start with a mask that's entirely transparent
    CGContextSetFillColorWithColor(maskContext, [UIColor blackColor].CGColor);
    CGContextFillRect(maskContext, CGRectMake(0, 0, size.width, size.height));
    
    // Make the inner part (within the border) opaque
    CGContextSetFillColorWithColor(maskContext, [UIColor whiteColor].CGColor);
    CGContextFillRect(maskContext, CGRectMake(borderSize, borderSize, size.width - borderSize * 2, size.height - borderSize * 2));
    
    // Get an image of the context
    CGImageRef maskImageRef = CGBitmapContextCreateImage(maskContext);
    
    // Clean up
    CGContextRelease(maskContext);
    CGColorSpaceRelease(colorSpace);
    
    return maskImageRef;
}


// Creates a copy of this image with rounded corners
// If borderSize is non-zero, a transparent border of the given size will also be added
- (UIImage *)roundedCornerImage:(NSInteger)cornerSize borderSize:(NSInteger)borderSize {
    // If the image does not have an alpha layer, add one
    UIImage *image = [self imageWithAlpha];
    
    // Build a context that's the same dimensions as the new size
    CGContextRef context = CGBitmapContextCreate(NULL,
                                                 image.size.width,
                                                 image.size.height,
                                                 CGImageGetBitsPerComponent(image.CGImage),
                                                 0,
                                                 CGImageGetColorSpace(image.CGImage),
                                                 CGImageGetBitmapInfo(image.CGImage));
    
    // Create a clipping path with rounded corners
    CGContextBeginPath(context);
    [self addRoundedRectToPath:CGRectMake(borderSize, borderSize, image.size.width - borderSize * 2, image.size.height - borderSize * 2)
                       context:context
                     ovalWidth:cornerSize
                    ovalHeight:cornerSize];
    CGContextClosePath(context);
    CGContextClip(context);
    
    // Draw the image to the context; the clipping path will make anything outside the rounded rect transparent
    CGContextDrawImage(context, CGRectMake(0, 0, image.size.width, image.size.height), image.CGImage);
    
    // Create a CGImage from the context
    CGImageRef clippedImage = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    
    // Create a UIImage from the CGImage
    UIImage *roundedImage = [UIImage imageWithCGImage:clippedImage];
    CGImageRelease(clippedImage);
    
    return roundedImage;
}


#pragma mark -
#pragma mark Private helper methods

// Adds a rectangular path to the given context and rounds its corners by the given extents
- (void)addRoundedRectToPath:(CGRect)rect context:(CGContextRef)context ovalWidth:(CGFloat)ovalWidth ovalHeight:(CGFloat)ovalHeight {
    if (ovalWidth == 0 || ovalHeight == 0) {
        CGContextAddRect(context, rect);
        return;
    }
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, CGRectGetMinX(rect), CGRectGetMinY(rect));
    CGContextScaleCTM(context, ovalWidth, ovalHeight);
    CGFloat fw = CGRectGetWidth(rect) / ovalWidth;
    CGFloat fh = CGRectGetHeight(rect) / ovalHeight;
    CGContextMoveToPoint(context, fw, fh/2);
    CGContextAddArcToPoint(context, fw, fh, fw/2, fh, 1);
    CGContextAddArcToPoint(context, 0, fh, 0, fh/2, 1);
    CGContextAddArcToPoint(context, 0, 0, fw/2, 0, 1);
    CGContextAddArcToPoint(context, fw, 0, fw, fh/2, 1);
    CGContextClosePath(context);
    CGContextRestoreGState(context);
}



#pragma mark -
#pragma mark Conversion/detection
//converts each UIImage to UIImage with grayscale palette, 8 bits per pixel wide
+ (UIImage *)convertTo8bppGrayscaleFromImage:(UIImage *) uimage {
    return [UIImage convertTo8bppGrayscaleFromImage:uimage scaleToMaximumSize:-1];
}

//if maxSize
+ (UIImage *)convertTo8bppGrayscaleFromImage:(UIImage *) uimage scaleToMaximumSize:(NSInteger) maxSize {
    int iwidth = uimage.size.width;
    int iheight = uimage.size.height;
    int maxFromHeightAndWidth = MAX(iwidth, iheight);
    float scaleFactor = maxSize / (float)maxFromHeightAndWidth;
    if(maxSize == -1){
        scaleFactor = 1.0f;
        if(maxFromHeightAndWidth > maximumResultImageSize){
            scaleFactor = maximumResultImageSize / (float) maxFromHeightAndWidth;
        }
    }
    int newImageWidth = iwidth*scaleFactor;
    int newImageHeight = iheight*scaleFactor;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    uint8_t *pixels = (uint8_t *) malloc(newImageWidth * newImageHeight * sizeof(*pixels));
    
    CGContextRef context = CGBitmapContextCreate(pixels, newImageWidth, newImageHeight, 8, newImageWidth * sizeof(uint8_t), colorSpace, kCGBitmapByteOrderDefault | kCGImageAlphaNone);
    CGContextDrawImage(context, CGRectMake(0, 0, newImageWidth, newImageHeight), uimage.CGImage);
    
    CGImageRef image = CGBitmapContextCreateImage(context);
    
    // we're done with the context, color space, and pixels
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    free(pixels);
    
    // make a new UIImage to return
    UIImage *resultUIImage = [UIImage imageWithCGImage:image];
    
    // we're done with image now too
    CGImageRelease(image);
    
    int bitsPerPixel = (int)CGImageGetBitsPerPixel(resultUIImage.CGImage);
    NSAssert(bitsPerPixel == 8, @"Converted image doesn't have 8 bits per pixel size!");
    return resultUIImage;
}
/*
 Returns an array made with Bresenham's algorithm, each cell of the array represents the following line, value is the number of pixels that should be taken from this line
 */
+ (int *)newNumOfPixelsInEachLineForWidth:(NSInteger) w andAngle:(NSInteger) ang {
    int *cntTable = (int *)malloc(sizeof(int)*(ang+1));
    
    NSInteger dLong = w;
    NSInteger dShort = ang;
    
    NSInteger err = 3*dShort - 2*dLong;
    NSInteger cLong = 0;
    NSInteger cShort = 0;
    cntTable[cShort] = 1;
    
    while (cLong < dLong) {
        if (err >= 0) {
            err -= 2*(dLong - dShort);
            ++cShort;
            cntTable[cShort] = 0;
        } else {
            err += 2*dShort;
        }
        ++cLong;
        ++cntTable[cShort];
    }
    return cntTable;
}

//gives number of black pixels in skewed line with angle == [array count], for values given by bres array
+ (NSInteger)getBlackPixelsInLine:(NSInteger) lineNumber forImage:(UIImage *) image withBresArray:(int *) array andTreshold:(unsigned char) blackTreshold negativeAngle:(BOOL)negative {
    CFDataRef data = CGDataProviderCopyData(CGImageGetDataProvider(image.CGImage));
    NSInteger bytesPerLine = CGImageGetBytesPerRow(image.CGImage);
    unsigned char *rawData = (unsigned char *)CFDataGetBytePtr(data);
    
    NSInteger blacks = 0;
    NSInteger offsetInLine = 0;
    unsigned char *ptrToStartLine = (rawData + bytesPerLine*lineNumber);
    NSInteger linesSkewNumber = temporaryImageAngle;
    for(NSInteger i = 0; i < linesSkewNumber; ++i){ //lines
        NSInteger pixelsToTake = array[i];
        for(NSInteger j = 0; j < pixelsToTake && offsetInLine < CGImageGetWidth(image.CGImage); ++j, ++offsetInLine){
            NSInteger lineOffsetFromStartLine = bytesPerLine*i;
            if(negative){
                lineOffsetFromStartLine = bytesPerLine * (linesSkewNumber-1-i);
            }
            NSAssert(lineOffsetFromStartLine >= 0, @"line offset can't be negative!");
            unsigned char pixelValue = *(ptrToStartLine + lineOffsetFromStartLine + offsetInLine);
            if(pixelValue < blackTreshold){
                ++blacks;
            }
        }
    }
    if(data != NULL){
        CFRelease(data);
    }
    return blacks;
}


+ (NSInteger)degrees:(CGFloat)degrees inPixelsForImage:(UIImage *) image {
    return image.size.width * tanf(toRadians(degrees));
}


-(BOOL)isGifImage {
    NSData *imageData = UIImagePNGRepresentation(self);
    if (!imageData)
        return NO;
    const char* buf = (const char*)[imageData bytes];
    if (buf && buf[0] == 0x47 && buf[1] == 0x49 && buf[2] == 0x46 && buf[3] == 0x38) {
        return YES;
    }
    return NO;
}
-(UIImage*)safeResizableImageWithCapInsets:(UIEdgeInsets)capInsets
{
    float osVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (osVersion < 6.0) {
        // for iOS < 6.0 fix crash
        return [self stretchableImageWithLeftCapWidth:capInsets.left topCapHeight:capInsets.top];
    }
    else
    {
        return  [self resizableImageWithCapInsets:capInsets resizingMode:UIImageResizingModeStretch];
    }
    
}

//For SDK
+(UIImage*)imageNamedForSDK:(NSString *)name
{
    NSString* imgPath = [NSString stringWithFormat:@"%@%@%@",@"resBundle.bundle/",name,@".png"];
    return [UIImage imageNamed:imgPath];
}

+(UIImage*)imageNamedNoCache:(NSString *)name
{
    if (!name) {
        return nil;
    }
    BOOL isNeedHD = NO;
    NSString *filePath = nil;
    if([[UIScreen mainScreen] respondsToSelector:@selector(scale)] == YES)
    {
        if ([[UIScreen mainScreen] scale] == 2.00)
        {
            isNeedHD = YES;
            //retina 寻找文件
            filePath = [self getImageFilePath:isNeedHD Name:name];
            return [UIImage imageWithContentsOfFile:filePath];
        }
        else
        {
            //非retina 寻找文件
            filePath = [self getImageFilePath:isNeedHD Name:name];
            return [UIImage imageWithContentsOfFile:filePath];
        }
    }
    
    return nil;
}

+(UIImage*)retinaOnlyImageNamedNoCache:(NSString *)name
{
    if (!name) {
        return nil;
    }
    //retina 寻找文件
    NSString *filePath = [self getImageFilePath:YES Name:name];
    return [UIImage imageWithContentsOfFile:filePath];
}
+(NSString *)getImageFilePath:(BOOL)isNeedHD Name:(NSString *)name
{
    NSString* finalName ;
    if (isNeedHD) {
        finalName = [NSString stringWithFormat:@"%@@2x",name];
    }
    else
    {
        finalName = [NSString stringWithString:name];
    }
    //retina 寻找文件
    NSString *filePath = [[NSBundle mainBundle] pathForResource:finalName ofType:@"png"];
    if (!filePath) {
        filePath = [[NSBundle mainBundle] pathForResource:finalName ofType:@"jpg"];
    }
    //如果没有 那寻找正常文件
    if (!filePath) {
        filePath = [[NSBundle mainBundle] pathForResource:name ofType:@"png"];
        if (!filePath) {
            filePath = [[NSBundle mainBundle] pathForResource:name ofType:@"jpg"];
        }
    }
    
    return filePath;
}

@end

#import "b64.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSData (MD5)

- (NSData *)MD5
{
    unsigned char md5Result[CC_MD5_DIGEST_LENGTH + 1];
    CC_MD5( [self bytes], (int)[self length], md5Result );
    
    NSMutableData * retData = [[NSMutableData alloc] init];
    if ( nil == retData )
        return nil;
    
    [retData appendBytes:md5Result length:CC_MD5_DIGEST_LENGTH];
    return retData;
}

- (NSString *)MD5String
{
    NSData * value = [self MD5];
    if ( value )
    {
        char			tmp[16];
        unsigned char *	hex = (unsigned char *)malloc( 2048 + 1 );
        unsigned char *	bytes = (unsigned char *)[value bytes];
        unsigned long	length = [value length];
        
        hex[0] = '\0';
        
        for ( unsigned long i = 0; i < length; ++i )
        {
            sprintf( tmp, "%02X", bytes[i] );
            strcat( (char *)hex, tmp );
        }
        
        NSString * result = [NSString stringWithUTF8String:(const char *)hex];
        free( hex );
        return result;
    }
    else
    {
        return nil;
    }
}

- (NSString *)detectImageSuffix
{
    uint8_t c;
    NSString *imageFormat = @"";
    [self getBytes:&c length:1];
    
    switch (c) {
        case 0xFF:
            imageFormat = @".jpg";
            break;
        case 0x89:
            imageFormat = @".png";
            break;
        case 0x47:
            imageFormat = @".gif";
            break;
        case 0x49:
        case 0x4D:
            imageFormat = @".tiff";
            break;
        case 0x42:
            imageFormat = @".bmp";
            break;
        default:
            break;
    }
    
    return imageFormat;
}

- (NSString *)UTF8String
{
    NSString *string = [[NSString alloc] initWithData:self encoding:NSUTF8StringEncoding];
    return string;
}

+ (NSData *)dataFromBase64String:(NSString *)base64String
{
    NSData * charData = [base64String dataUsingEncoding: NSUTF8StringEncoding];
    return ( b64_decode(charData) );
}

- (id)initWithBase64String:(NSString *)base64String
{
    NSData * charData = [base64String dataUsingEncoding: NSUTF8StringEncoding];
    NSData * result = b64_decode(charData);
    return ( result );
}

- (NSString *)base64EncodedString
{
    NSData * charData = b64_encode( self );
    return [[NSString alloc] initWithData: charData encoding: NSUTF8StringEncoding];
}

-(NSArray*)array
{
    NSArray* arr= [NSKeyedUnarchiver unarchiveObjectWithData:self];
    return arr;
}
-(NSDictionary*)dictionary
{
    NSDictionary* dictionary= [NSKeyedUnarchiver unarchiveObjectWithData:self];
    return dictionary;
}

@end

static NSMutableDictionary *formatters = nil;

@implementation NSDateFormatter (Format)

+ (NSDateFormatter *)dateFormatterWithFormat:(NSString *)formmat
{
    return [self dateFormatterWithKey:[NSString stringWithFormat:@"<%@>",formmat] configBlock:^(NSDateFormatter *formatter)
            {
                if (formatter)
                {
                    [formatter setDateFormat:formmat];
                }
            }];
}

+ (NSDateFormatter *)dateFormatterWithKey:(NSString *)key configBlock:(XDateFormmaterConfigBlock)cofigBlock
{
    NSString *strKey = nil;
    if (!key)
    {
        strKey = @"defaultFormatter";
    }
    else
    {
        strKey = [key copy];
    }
    
    @synchronized(self)
    {
        NSDateFormatter *dateFormatter = [[self formatters] objectForKey:strKey];
        if (!dateFormatter) {
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [[self formatters] setObject:dateFormatter forKey:strKey];
            
            if (cofigBlock) {
                cofigBlock(dateFormatter); //配置它
            }
            
            return dateFormatter;
        }
        
        return dateFormatter;
    }
}

+ (NSMutableDictionary *)formatters
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!formatters)
        {
            formatters = [[NSMutableDictionary alloc] init];
        }
    });
    
    return formatters;
}

@end

#define DATE_COMPONENTS (NSYearCalendarUnit| NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekCalendarUnit |  NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit | NSWeekdayCalendarUnit | NSWeekdayOrdinalCalendarUnit)
#define CURRENT_CALENDAR [NSCalendar currentCalendar]

@implementation NSDate (CaluAndFormat)

- (NSString *)stringWithDateFormat:(NSString *)format
{
    NSTimeInterval time = [self timeIntervalSince1970];
    NSUInteger timeUint = (NSUInteger)time;
    
    NSDateFormatter * dateFormatter = [NSDateFormatter dateFormatterWithFormat:format];
    NSString * result = [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:timeUint]];
    return result;
}

+ (NSTimeInterval)timeIntervalSince1970
{
    NSDate *date = [[NSDate alloc] init];
    NSTimeInterval timeInterval = [date timeIntervalSince1970];
    return timeInterval;
}

#pragma mark Relative Dates

+ (NSDate *) dateWithDaysFromNow: (NSUInteger) days
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + D_DAY * days;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

+ (NSDate *) dateWithDaysBeforeNow: (NSUInteger) days
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - D_DAY * days;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

+ (NSDate *) dateDayAfterTomorrow
{
    return [NSDate dateWithDaysFromNow:2];
}

+ (NSDate *) dateTomorrow
{
    return [NSDate dateWithDaysFromNow:1];
}

+ (NSDate *) dateYesterday
{
    return [NSDate dateWithDaysBeforeNow:1];
}

+ (NSDate *) dateWithHoursFromNow: (NSUInteger) dHours
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + D_HOUR * dHours;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

+ (NSDate *) dateWithHoursBeforeNow: (NSUInteger) dHours
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - D_HOUR * dHours;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

+ (NSDate *) dateWithMinutesFromNow: (NSUInteger) dMinutes
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + D_MINUTE * dMinutes;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

+ (NSDate *) dateWithMinutesBeforeNow: (NSUInteger) dMinutes
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - D_MINUTE * dMinutes;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

#pragma mark Comparing Dates

- (BOOL) isEqualToDateIgnoringTime: (NSDate *) aDate
{
    NSDateComponents *components1 = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    NSDateComponents *components2 = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:aDate];
    return (([components1 year] == [components2 year]) &&
            ([components1 month] == [components2 month]) &&
            ([components1 day] == [components2 day]));
}

- (BOOL) isToday
{
    return [self isEqualToDateIgnoringTime:[NSDate date]];
}

- (BOOL) isTomorrow
{
    return [self isEqualToDateIgnoringTime:[NSDate dateTomorrow]];
}

- (BOOL) isDayAfterTomorrow
{
    return [self isEqualToDateIgnoringTime:[NSDate dateDayAfterTomorrow]];
}

- (BOOL) isYesterday
{
    return [self isEqualToDateIgnoringTime:[NSDate dateYesterday]];
}

// This hard codes the assumption that a week is 7 days
- (BOOL) isSameWeekAsDate: (NSDate *) aDate
{
    NSDateComponents *components1 = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    NSDateComponents *components2 = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:aDate];
    
    // Must be same week. 12/31 and 1/1 will both be week "1" if they are in the same week
    if ([components1 weekOfMonth] != [components2 weekOfMonth]) return NO;
    
    // Must have a time interval under 1 week. Thanks @aclark
    return (abs([self timeIntervalSinceDate:aDate]) < D_WEEK);
}

- (BOOL) isThisWeek
{
    return [self isSameWeekAsDate:[NSDate date]];
}

- (BOOL) isNextWeek
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + D_WEEK;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return [self isSameYearAsDate:newDate];
}

- (BOOL) isLastWeek
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - D_WEEK;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return [self isSameYearAsDate:newDate];
}

- (BOOL) isSameYearAsDate: (NSDate *) aDate
{
    NSDateComponents *components1 = [CURRENT_CALENDAR components:NSYearCalendarUnit fromDate:self];
    NSDateComponents *components2 = [CURRENT_CALENDAR components:NSYearCalendarUnit fromDate:aDate];
    return ([components1 year] == [components2 year]);
}

- (BOOL) isThisYear
{
    return [self isSameWeekAsDate:[NSDate date]];
}

- (BOOL) isNextYear
{
    NSDateComponents *components1 = [CURRENT_CALENDAR components:NSYearCalendarUnit fromDate:self];
    NSDateComponents *components2 = [CURRENT_CALENDAR components:NSYearCalendarUnit fromDate:[NSDate date]];
    
    return ([components1 year] == ([components2 year] + 1));
}

- (BOOL) isLastYear
{
    NSDateComponents *components1 = [CURRENT_CALENDAR components:NSYearCalendarUnit fromDate:self];
    NSDateComponents *components2 = [CURRENT_CALENDAR components:NSYearCalendarUnit fromDate:[NSDate date]];
    
    return ([components1 year] == ([components2 year] - 1));
}

- (BOOL) isEarlierThanDate: (NSDate *) aDate
{
    return ([self earlierDate:aDate] == self);
}

- (BOOL) isLaterThanDate: (NSDate *) aDate
{
    return ([self laterDate:aDate] == self);
}


#pragma mark Adjusting Dates

- (NSDate *) dateByAddingDays: (NSInteger) dDays
{
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + D_DAY * dDays;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

- (NSDate *) dateBySubtractingDays: (NSUInteger) dDays
{
    return [self dateByAddingDays: (dDays * -1)];
}

- (NSDate *) dateByAddingHours: (NSInteger) dHours
{
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + D_HOUR * dHours;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

- (NSDate *) dateBySubtractingHours: (NSUInteger) dHours
{
    return [self dateByAddingHours: (dHours * -1)];
}

- (NSDate *) dateByAddingMinutes: (NSInteger) dMinutes
{
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + D_MINUTE * dMinutes;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

- (NSDate *) dateBySubtractingMinutes: (NSUInteger) dMinutes
{
    return [self dateByAddingMinutes: (dMinutes * -1)];
}

- (NSDate *) dateAtStartOfDay
{
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    [components setHour:0];
    [components setMinute:0];
    [components setSecond:0];
    return [CURRENT_CALENDAR dateFromComponents:components];
}

- (NSDateComponents *) componentsWithOffsetFromDate: (NSDate *) aDate
{
    NSDateComponents *dTime = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:aDate toDate:self options:0];
    return dTime;
}

#pragma mark Retrieving Intervals

- (NSInteger) minutesAfterDate: (NSDate *) aDate
{
    NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
    return (NSInteger) (ti / D_MINUTE);
}

- (NSInteger) minutesBeforeDate: (NSDate *) aDate
{
    NSTimeInterval ti = [aDate timeIntervalSinceDate:self];
    return (NSInteger) (ti / D_MINUTE);
}

- (NSInteger) hoursAfterDate: (NSDate *) aDate
{
    NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
    return (NSInteger) (ti / D_HOUR);
}

- (NSInteger) hoursBeforeDate: (NSDate *) aDate
{
    NSTimeInterval ti = [aDate timeIntervalSinceDate:self];
    return (NSInteger) (ti / D_HOUR);
}

- (NSInteger) daysAfterDate: (NSDate *) aDate
{
    NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
    return (NSInteger) (ti / D_DAY);
}

- (NSInteger) daysBeforeDate: (NSDate *) aDate
{
    NSTimeInterval ti = [aDate timeIntervalSinceDate:self];
    return (NSInteger) (ti / D_DAY);
}

#pragma mark 转换日期为string
+ (NSString *)convertDateIntervalToStringWith:(NSString *)aInterVal
{
    time_t    statusCreateAt_t;
    NSString* timestamp = nil;
    time_t now;
    time(&now);
    
    statusCreateAt_t = (time_t)[aInterVal longLongValue];
    
    struct tm *nowtime;
    nowtime = localtime(&now);
    uint32_t thour = nowtime->tm_hour;
    
    struct tm *ptime;
    ptime = localtime(&statusCreateAt_t);
    
    int distance = (int)difftime(now, statusCreateAt_t);
    if (distance < 0) distance = 0;
    
    if (distance < 30)
    {
        timestamp = @"刚刚";
    }
    else if (distance < 60)
    {
        timestamp = @"30秒前";
    }
    else if (distance < 60 * 60) /* 小于1小时 */
    {
        distance = distance / 60;
        if (distance == 0) {
            distance = 1;
        }
        timestamp = [NSString stringWithFormat:@"%d分钟前", distance];
    }
    else if (distance < (60 * 60 * (thour))) /* 大于1小时，但是在今日 */
    {
        int mins=ptime->tm_min;
        if(mins<10){
            timestamp =[NSString stringWithFormat:@"%d:0%d",ptime->tm_hour ,ptime->tm_min];
        }
        else
        {
            timestamp =[NSString stringWithFormat:@"%d:%d",ptime->tm_hour ,ptime->tm_min];
        }
    }
    else if (distance >= (60 * 60 * thour) && distance < (60 * 60 * 24 * 31))
    {
        distance = distance / (60 * 60 * 24);
        if (distance == 0)
        {
            distance = 1;
        }
        if (distance == 1)
        {
            timestamp = [NSString stringWithFormat:@"昨天"];
        }
        else if (distance == 2)
        {
            timestamp = [NSString stringWithFormat:@"前天"];
        }
        else
        {
            timestamp = [NSString stringWithFormat:@"%d天前", distance];
        }
    }
    else
    {
        NSDate *date_now = [NSDate dateWithTimeIntervalSince1970:now];
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:statusCreateAt_t];
        NSInteger dateYear = [date year];
        NSInteger nowYear = [date_now year];
        
        if (dateYear == nowYear)
        {
            NSDateFormatter *dateFormatter = [NSDateFormatter dateFormatterWithFormat:@"MM-dd"];
            timestamp = [dateFormatter stringFromDate:date];
        }
        else
        {
            NSDateFormatter *dateFormatter = [NSDateFormatter dateFormatterWithFormat:@"yyyy-MM-dd"];
            timestamp = [dateFormatter stringFromDate:date];
        }
    }
    return timestamp;
    
}

#pragma mark Decomposing Dates

- (NSInteger) nearestHour
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + D_MINUTE * 30;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    NSDateComponents *components = [CURRENT_CALENDAR components:NSHourCalendarUnit fromDate:newDate];
    return [components hour];
}

- (NSInteger) hour
{
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    return [components hour];
}

- (NSInteger) minute
{
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    return [components minute];
}

- (NSInteger) seconds
{
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    return [components second];
}

- (NSInteger) day
{
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    return [components day];
}

- (NSInteger) month
{
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    return [components month];
}

- (NSInteger) week
{
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    return [components weekOfMonth];
}

- (NSInteger) weekday
{
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    return [components weekday];
}

- (NSInteger) nthWeekday // e.g. 2nd Tuesday of the month is 2
{
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    return [components weekdayOrdinal];
}
- (NSInteger) year
{
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    return [components year];
}

+ (NSString *)stringWithDateFormat:(NSString *)format
{
    return [NSDate stringWithTimeInterval:[NSDate timeIntervalSince1970] andDateFormat:format];
}

+ (NSString *)stringWithTimeInterval:(NSTimeInterval)timeInterval andDateFormat:(NSString *)format
{
    NSUInteger timeUint = (NSUInteger)timeInterval;
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    if (!format || format.length <= 0)
    {
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    }
    else
    {
        [dateFormatter setDateFormat:format];
    }
    NSString * result = [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:timeUint]];
    return result;
}

@end

@implementation NSString (StringEncode)

- (NSString *)URLEncoding
{
    NSString * result = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes( kCFAllocatorDefault,
                                                                            (CFStringRef)self,
                                                                            NULL,
                                                                            (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                            kCFStringEncodingUTF8 ));
    return result;
}

+ (NSString *)queryStringFromDictionary:(NSDictionary *)dict
{
    NSMutableArray * pairs = [NSMutableArray array];
    for ( NSString * key in [dict keyEnumerator] )
    {
        if ( !([[dict valueForKey:key] isKindOfClass:[NSString class]]) )
        {
            continue;
        }
        
        NSString * value = [dict objectForKey:key];
        NSString * urlEncoding = [value URLEncoding];
        [pairs addObject:[NSString stringWithFormat:@"%@=%@", key, urlEncoding]];
    }
    
    return [pairs componentsJoinedByString:@"&"];
}

- (NSString *)urlByAppendingDict:(NSDictionary *)params
{
    NSURL * parsedURL = [NSURL URLWithString:self];
    NSString * queryPrefix = parsedURL.query ? @"&" : @"?";
    NSString * query = [NSString queryStringFromDictionary:params];
    return [NSString stringWithFormat:@"%@%@%@", self, queryPrefix, query];
}

- (NSString *)MD5
{
    unsigned char *CC_MD5();
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, (int)strlen(cStr), result ); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

@end
