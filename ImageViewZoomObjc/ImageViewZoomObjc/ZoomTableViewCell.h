//
//  ZoomTableViewCell.h
//  ImageViewZoomObjc
//
//  Created by hsb9kr on 2017. 10. 31..
//  Copyright © 2017년 hsb9kr. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HSBZoomView;

@interface ZoomTableViewCell : UITableViewCell
@property (strong, nonatomic) UIView *view;
@property (weak, nonatomic) IBOutlet HSBZoomView *zoomView;

@end
