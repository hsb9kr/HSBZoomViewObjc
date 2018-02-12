//
//  ZoomTableViewCell.m
//  ImageViewZoomObjc
//
//  Created by hsb9kr on 2017. 10. 31..
//  Copyright © 2017년 hsb9kr. All rights reserved.
//

#import "ZoomTableViewCell.h"
#import "HSBZoomView.h"

@interface ZoomTableViewCell(HSBZoomView) <HSBZoomViewDataSource, HSBZoomViewDelegate>
@end

@implementation ZoomTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _view = [[UIView alloc] init];
    
    _zoomView.dataSource = self;
    _zoomView.delegate = self;
}

@end

@implementation ZoomTableViewCell(HSBZoomView)

- (UIView *)hsbZoomView:(HSBZoomView *)view {
    return _view;
}

- (void)hsbZoomViewWillBeginZooming:(HSBZoomView *)view {
    UIView *frontView = UIApplication.sharedApplication.keyWindow.subviews.firstObject;
    CGPoint origin = [view convertPoint:view.frame.origin toView:frontView];
    CGRect frame = view.scrollView.frame;
    frame.origin = origin;
    view.scrollView.frame = frame;
    [frontView addSubview:view.scrollView];
}

- (void)hsbZoomViewDidEndZooming:(HSBZoomView *)view {
//    [view reload];
}



@end
