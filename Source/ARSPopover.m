//
//  ARSPopover.m
//  Popover
//
//  Created by Yaroslav Arsenkin on 27.05.15.
//  Copyright (c) 2015 Iaroslav Arsenkin. All rights reserved.
//  Website: http://arsenkin.com
//

#import "ARSPopover.h"


@interface ARSPopover() <UIPopoverPresentationControllerDelegate>
	
@end

@implementation ARSPopover
	
#pragma mark Initialization
	
- (instancetype)init {
	if (self = [super init]) {
		[self initializePopover];
	}
	
	return self;
}
	
- (instancetype)initWithNibName:(nullable NSString *)nibNameOrNil bundle:(nullable NSBundle *)nibBundleOrNil {
	if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
		[self initializePopover];
	}
	
	return self;
}
	
- (instancetype)initWithCoder:(NSCoder *)coder {
	if (self = [super initWithCoder:coder]) {
		[self initializePopover];
	}
	
	return self;
}
	
- (void)initializePopover {
	self.modalPresentationStyle = UIModalPresentationPopover;
	self.popoverPresentationController.delegate = self;
	
	self.backgroundColor = [UIColor colorWithRed:18/255.0 green:40/255.0 blue:49/255.0 alpha:1];
}
	
#pragma mark - Actions
	
- (void)closePopover {
	[self dismissViewControllerAnimated:YES completion:nil];
}
	
- (void)insertContentIntoPopover:(void (^)(ARSPopover *popover, CGSize popoverPresentedSize, CGFloat presentationArrowHeight))content {
	CGFloat presentationArrowHeight = 12.0;
	CGFloat width = CGRectGetWidth(self.popoverPresentationController.frameOfPresentedViewInContainerView);
	CGFloat height = CGRectGetHeight(self.popoverPresentationController.frameOfPresentedViewInContainerView);
	CGSize popoverSize = CGSizeMake(width, height);
	
	content(self, popoverSize, presentationArrowHeight);
}
	
#pragma mark - Popover Presentation Controller Delegate
	
- (void)prepareForPopoverPresentation:(UIPopoverPresentationController *)popoverPresentationController {
	self.popoverPresentationController.sourceView = self.sourceView ? self.sourceView : self.view;
	self.popoverPresentationController.sourceRect = self.sourceRect;
	self.preferredContentSize = self.contentSize;
	
	popoverPresentationController.permittedArrowDirections = self.arrowDirection ? self.arrowDirection : UIPopoverArrowDirectionAny;
	popoverPresentationController.passthroughViews = self.passthroughViews;
	popoverPresentationController.backgroundColor = self.backgroundColor;
	popoverPresentationController.popoverLayoutMargins = self.popoverLayoutMargins;
}
	
- (void)popoverPresentationController:(UIPopoverPresentationController *)popoverPresentationController willRepositionPopoverToRect:(inout CGRect *)rect inView:(inout UIView *__autoreleasing *)view {
	if ([self.delegate respondsToSelector:@selector(popoverPresentationController:willRepositionPopoverToRect:inView:)]) {
		[self.delegate popoverPresentationController:popoverPresentationController willRepositionPopoverToRect:rect inView:view];
	}
}
	
- (BOOL)popoverPresentationControllerShouldDismissPopover:(UIPopoverPresentationController *)popoverPresentationController {
	if ([self.delegate respondsToSelector:@selector(popoverPresentationControllerShouldDismissPopover: withSelf:)]) {
		return [self.delegate popoverPresentationControllerShouldDismissPopover:popoverPresentationController withSelf:self];
	}
	
	return YES;
}
	
- (void)popoverPresentationControllerDidDismissPopover:(UIPopoverPresentationController *)popoverPresentationController {
	if ([self.delegate respondsToSelector:@selector(popoverPresentationControllerDidDismissPopover: withSelf:)]) {
		[self.delegate popoverPresentationControllerDidDismissPopover:popoverPresentationController withSelf:self];
	}
}
	
#pragma mark - Adaptive Presentation Controller Delegate
	
- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller {
	return UIModalPresentationNone;
}
	
- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller traitCollection:(UITraitCollection *)traitCollection {
	// This method is called in iOS 8.3 or later regardless of trait collection, in which case use the original presentation style (UIModalPresentationNone signals no adaptation)
	return UIModalPresentationNone;
}
@end
