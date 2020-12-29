#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "HPKControllerProtocol.h"
#import "HPKModelProtocol.h"
#import "HPKPageHandler.h"
#import "HPKPageManager.h"
#import "HPKViewProtocol.h"
#import "HPKWebView.h"

FOUNDATION_EXPORT double HybridPageKitVersionNumber;
FOUNDATION_EXPORT const unsigned char HybridPageKitVersionString[];

