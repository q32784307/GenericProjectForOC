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

#import "TABAnimatedCacheManager.h"
#import "TABAnimatedCacheModel.h"
#import "TABAnimatedDocumentMethod.h"
#import "TABAnimatedConfig.h"
#import "TABCollectionAnimated.h"
#import "TABTableAnimated.h"
#import "TABViewAnimated.h"
#import "TABViewAnimatedDefines.h"
#import "UIView+TABControlAnimation.h"
#import "UIView+TABControlModel.h"
#import "TABFormAnimated.h"
#import "TABBinAnimation.h"
#import "TABBinAnimationImpl.h"
#import "TABBaseComponent+TABClassicAnimation.h"
#import "TABClassicAnimation.h"
#import "TABClassicAnimationImpl.h"
#import "TABComponentLayer+TABClassicAnimation.h"
#import "TABComponentLayerClassicSerializationImpl.h"
#import "NSArray+TABDropAnimation.h"
#import "TABBaseComponent+TABDropAnimation.h"
#import "TABComponentLayer+TABDropAnimation.h"
#import "TABComponentLayerDropSerializationImpl.h"
#import "TABDropAnimation.h"
#import "TABDropAnimationDefines.h"
#import "TABDropAnimationImpl.h"
#import "TABAnimatedDecorateInterface.h"
#import "TABAnimationManagerInterface.h"
#import "TABShimmerAnimation.h"
#import "TABShimmerAnimationDefines.h"
#import "TABShimmerAnimationImpl.h"
#import "TABAnimationManagerImpl.h"
#import "TABAnimatedChainDefines.h"
#import "TABAnimatedChainManagerInterface.h"
#import "NSArray+TABAnimatedChain.h"
#import "TABAnimatedChainManagerImpl.h"
#import "TABBaseComponent.h"
#import "TABComponentManager.h"
#import "TABAnimatedDarkModeDefines.h"
#import "TABAnimatedDarkModeInterface.h"
#import "TABAnimatedDarkModeManagerInterface.h"
#import "TABAnimatedDarkModeImpl.h"
#import "TABAnimatedDarkModeManagerImpl.h"
#import "TABSentryView.h"
#import "TABAnimatedProductDefines.h"
#import "TABAnimatedProductInterface.h"
#import "TABComponentLayerSerializationInterface.h"
#import "TABAnimatedProductHelper.h"
#import "TABAnimatedProductImpl.h"
#import "TABAnimatedProduction.h"
#import "TABComponentLayer.h"
#import "UIView+TABAnimatedProduction.h"
#import "TABAnimatedPullLoadingComponent.h"
#import "UIScrollView+TABAnimated.h"
#import "UIView+TABExtension.h"
#import "TABAnimated.h"
#import "TABAnimatedInjectionIIIHelper.h"
#import "TABAnimationMethod.h"
#import "TABWeakDelegateManager.h"
#import "UIScrollView+TABExtension.h"

FOUNDATION_EXPORT double TABAnimatedVersionNumber;
FOUNDATION_EXPORT const unsigned char TABAnimatedVersionString[];

