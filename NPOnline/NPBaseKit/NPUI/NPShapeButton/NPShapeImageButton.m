//
//  NPShapeImageButton.m
//  NPShapeImageButton
//
//  Created by 李永杰 on 2020/5/6.
//  Copyright © 2020 NewPath. All rights reserved.
//

#import "NPShapeImageButton.h"

@implementation NPShapeImageButton
 
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    // 如果superResult = no（点击在bounds之外）,直接返回NO，不处理
    BOOL response = [super pointInside:point withEvent:event];
    if (!response) {
        return response;
    }
    // 判断设置有image
    if (self.currentImage || self.currentBackgroundImage) {
        // 重点
        response = [self isAlphaVisibleAtPoint:point];
    }
    return response;
}

/**
 截图
 */
-(UIImage *)shotViewImage{
    UIImage *imageRet = [[UIImage alloc]init];
    UIGraphicsBeginImageContextWithOptions(self.frame.size, false, 0.0);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    imageRet = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return imageRet;
}

/**
 判断点击点像素的透明度
 */
- (BOOL)isAlphaVisibleAtPoint:(CGPoint)point {
    UIImage *shotViewImage = [self shotViewImage];// 截图button
    UIColor *pixelColor = [self color:shotViewImage atPixel:point];// 获取图片某一像素点的颜色值
    CGFloat alpha = 0.0;
    [pixelColor getRed:NULL green:NULL blue:NULL alpha:&alpha];
    return alpha >= 0.1; // 透明度大于0.1说明点击到了图片上，透明部分不响应
}

- (UIColor *)color:(UIImage *)image atPixel:(CGPoint)point {
    
    if (!CGRectContainsPoint(CGRectMake(0.0f, 0.0f, image.size.width, image.size.height), point)) {
        return nil;
    }
    NSInteger pointX = trunc(point.x);
    NSInteger pointY = trunc(point.y);
    CGImageRef cgImage = image.CGImage;
    NSUInteger width = image.size.width;
    NSUInteger height = image.size.height;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    int bytesPerPixel = 4;
    int bytesPerRow = bytesPerPixel * 1;
    NSUInteger bitsPerComponent = 8;
    unsigned char pixelData[4] = { 0, 0, 0, 0 };
    CGContextRef context = CGBitmapContextCreate(pixelData,
                                                 1,
                                                 1,
                                                 bitsPerComponent,
                                                 bytesPerRow,
                                                 colorSpace,
                                                 kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGColorSpaceRelease(colorSpace);
    CGContextSetBlendMode(context, kCGBlendModeCopy);

    // Draw the pixel we are interested in onto the bitmap context
    CGContextTranslateCTM(context, -pointX, pointY-(CGFloat)height);
    CGContextDrawImage(context, CGRectMake(0.0f, 0.0f, (CGFloat)width, (CGFloat)height), cgImage);
    CGContextRelease(context);
    
    // Convert color values [0..255] to floats [0.0..1.0]
    CGFloat red   = (CGFloat)pixelData[0] / 255.0f;
    CGFloat green = (CGFloat)pixelData[1] / 255.0f;
    CGFloat blue  = (CGFloat)pixelData[2] / 255.0f;
    CGFloat alpha = (CGFloat)pixelData[3] / 255.0f;
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}
@end
