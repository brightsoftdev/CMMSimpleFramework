//  Created by JGroup(kimbobv22@gmail.com)

#import "CMMLayer.h"

@protocol CMMCustomUIDelegate <NSObject>

@end

@interface CMMCustomUI : CMMLayer{
	id<CMMCustomUIDelegate>delegate;
}

-(void)update:(ccTime)dt_;

@property (nonatomic, retain) id<CMMCustomUIDelegate>delegate;

@end
