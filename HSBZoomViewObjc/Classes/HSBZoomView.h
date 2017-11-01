//
//  HSBZoomView.h
//  ImageViewZoomObjc
//
//  Created by hsb9kr on 2017. 10. 31..
//  Copyright © 2017년 hsb9kr. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol HSBZoomViewDataSource;
@protocol HSBZoomViewDelegate;

@interface HSBZoomView : UIView {
@private
    BOOL _isZooming;
    UIScrollView *_scrollView;
    
    struct {
        unsigned int viewFlag :1;
    }_dataSourceFlags;
    
    struct {
        unsigned int willBeginZoomingFlag   :1;
        unsigned int DidEndZoomingFlag      :1;
    }_delegateFlags;
}

@property (weak, nonatomic) id<HSBZoomViewDataSource> dataSource;
@property (weak, nonatomic) id<HSBZoomViewDelegate> delegate;
@property (strong, nonatomic, readonly) UIScrollView *scrollView;
@property (strong, nonatomic) UIView *view;
@property (nonatomic, readonly) BOOL isZooming;

- (void)reload;

@end

@protocol HSBZoomViewDataSource <NSObject>
- (UIView *)hsbZoomView:(HSBZoomView *)view;
@end

@protocol HSBZoomViewDelegate <NSObject>
@optional
- (void)hsbZoomViewWillBeginZooming:(HSBZoomView *)view;
- (void)hsbZoomViewDidEndZooming:(HSBZoomView *)view;
@end
