//
//  LOTAnimationView_Internal.h
//  Lottie
//
//  Created by Brandon Withrow on 12/7/16.
//  Copyright © 2016 Brandon Withrow. All rights reserved.
//

#import "LOTAnimationView.h"

typedef enum : NSUInteger {
  LOTConstraintTypeAlignToBounds,
  LOTConstraintTypeAlignToLayer,
  LOTConstraintTypeNone
} LOTConstraintType;

@interface LOTAnimationView () <CAAnimationDelegate>

@property (nonatomic, readonly) LOTComposition * _Nonnull sceneModel;
@property (nonatomic, copy, nullable) LOTAnimationCompletionBlock completionBlock;
@property (nonatomic, copy, nullable) NSString *cacheKey;

@end
