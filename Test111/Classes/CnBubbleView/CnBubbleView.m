//
//  CnBubbleView.m
//  CnMoble
//
//  Created by Cn on 2017/1/22.
//  Copyright © 2017年 Cn. All rights reserved.
//

#import "CnBubbleView.h"

@interface CnBubbleView ()

@property(nonatomic, strong) UILabel* label;
@property(nonatomic, strong) UIColor* bgColor;
@property(nonatomic, strong) CAShapeLayer *maskLayer;

@end


@implementation CnBubbleView

-(instancetype) initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        
        self.backgroundColor = [UIColor clearColor];
        _bgColor = [UIColor yellowColor];
        //设置覆盖层
        _maskLayer = [CAShapeLayer layer];
        [self.maskLayer setFillColor:_bgColor.CGColor];
        [self.maskLayer setStrokeColor:[UIColor whiteColor].CGColor];
        self.maskLayer.lineWidth = 1.f;
        [self.layer addSublayer:self.maskLayer];
        
        _label = [[UILabel alloc] initWithFrame:CGRectMake(4, 0, 0, CGRectGetHeight(frame))];
        _label.font = [UIFont systemFontOfSize:8.0];
        _label.textColor = [UIColor whiteColor];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.lineBreakMode = NSLineBreakByCharWrapping;
        [self addSubview:_label];
        
    }
    return self;
}


-(void) setText:(NSString*)text maxWidth:(CGFloat)maxWidth{
    
    if (!text || [text isEqualToString:@""]) {
        
        self.hidden = YES;
        return;
    }
    self.hidden = NO;
    
    if ([text isEqualToString:_label.text]) {
        return;
    }

    _label.text = text;
    NSDictionary *attributeDic = @{NSFontAttributeName:_label.font};
    CGSize size = [_label.text sizeWithAttributes:attributeDic];
    CGRect rect = _label.frame;
    rect.size.width = MIN(size.width, maxWidth - 8);
    _label.frame = rect;
    
    
    rect = self.frame;
    rect.size.width = CGRectGetWidth(_label.frame) + 8;
    self.frame = rect;
    
    [self setCornerRadius:MIN(CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))/2];
}

-(void) setTextFont:(UIFont *)font{
    
    _label.font = font;
}

-(void) setTextColor:(UIColor *)textColor{
    
    if (textColor == _label.textColor) {
        return;
    }
    _label.textColor = textColor;
}

-(void) setBackgroundColor:(UIColor *)bgColor{
    
    if (bgColor == _bgColor) {
        return;
    }
    _bgColor = bgColor;
    [self.maskLayer setFillColor:_bgColor.CGColor];
}

-(void) setCornerRadius:(CGFloat)cornerRadius {
    CGSize cornerSize = CGSizeMake(cornerRadius, cornerRadius);
    UIBezierPath* path = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                               byRoundingCorners:(UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomRight)
                                                     cornerRadii:cornerSize];
    [self.maskLayer setPath:[path CGPath]];
}

@end



