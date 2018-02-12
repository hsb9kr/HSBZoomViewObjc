//
//  HSBZoomView.m
//  ImageViewZoomObjc
//
//  Created by hsb9kr on 2017. 10. 31..
//  Copyright © 2017년 hsb9kr. All rights reserved.
//

#import "HSBZoomView.h"

@interface HSBZoomView(UIScrollView) <UIScrollViewDelegate>
@end

@implementation HSBZoomView
@dynamic scrollView;

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (_scrollView.zooming) return;
    [self reload];
}

- (UIScrollView *)scrollView {
    return _scrollView;
}

- (void)setDataSource:(id<HSBZoomViewDataSource>)dataSource {
    _dataSource = dataSource;
    _dataSourceFlags.viewFlag = [_dataSource respondsToSelector:@selector(hsbZoomView:)];
}

- (void)setDelegate:(id<HSBZoomViewDelegate>)delegate {
    _delegate = delegate;
    _delegateFlags.willBeginZoomingFlag = [_delegate respondsToSelector:@selector(hsbZoomViewWillBeginZooming:)];
    _delegateFlags.DidEndZoomingFlag = [_delegate respondsToSelector:@selector(hsbZoomViewDidEndZooming:)];
}

- (void)setMinimumZoomScale:(CGFloat)minimumZoomScale {
    _scrollView.minimumZoomScale = minimumZoomScale;
}

- (CGFloat)minimumZoomScale {
    return _scrollView.minimumZoomScale;
}

- (void)setMaximumZoomScale:(CGFloat)maximumZoomScale {
    _scrollView.maximumZoomScale = maximumZoomScale;
}

- (CGFloat)maximumZoomScale {
    return _scrollView.maximumZoomScale;
}

#pragma mark - Private

- (void)initialize {
    _view = [[UIView alloc] init];
    _scrollView = [[UIScrollView alloc] init];
    
    _scrollView.delegate = self;
    _scrollView.showsHorizontalScrollIndicator = false;
    _scrollView.showsVerticalScrollIndicator = false;
    _scrollView.minimumZoomScale = 1;
    _scrollView.maximumZoomScale = 3;
    _scrollView.bouncesZoom = true;
    [self addSubview:_scrollView];
}

#pragma mark - Public

- (void)reload {
    if (_dataSourceFlags.viewFlag) _view = [_dataSource hsbZoomView:self];
    if (_view.superview != _scrollView) [_scrollView addSubview:_view];
    if (_scrollView.superview != self) [self addSubview:_scrollView];
    
    _scrollView.frame = self.bounds;
    _scrollView.contentSize = self.bounds.size;
    _view.frame = self.bounds;
}

@end

@implementation HSBZoomView(UIScrollView)

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return _view;
}

- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view {
    if (_delegateFlags.willBeginZoomingFlag) [_delegate hsbZoomViewWillBeginZooming:self];
    _scrollView.layer.masksToBounds = NO;
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale {
	
	__block struct DelegateFlags flags = _delegateFlags;
	
    [UIView animateWithDuration:0.1 animations:^{
		if (self.autoZoom) self.scrollView.zoomScale = 1;
    } completion:^(BOOL finished) {
        self.scrollView.layer.masksToBounds = NO;
        if (flags.DidEndZoomingFlag) [self.delegate hsbZoomViewDidEndZooming:self];
    }];
}

@end
