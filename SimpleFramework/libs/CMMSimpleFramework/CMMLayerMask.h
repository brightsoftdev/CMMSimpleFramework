//  Created by JGroup(kimbobv22@gmail.com)

#import "CMMLayer.h"

@interface CMMLayerMask : CMMLayer{
	CMMLayer *_innerLayer;
}

-(void)addChildDirect:(CCNode *)node z:(NSInteger)z tag:(NSInteger)tag;
-(void)addChildDirect:(CCNode *)node z:(NSInteger)z;
-(void)addChildDirect:(CCNode *)node;

-(CCNode *)getChildDirectByTag:(NSInteger)tag;
-(void)removeChildDirect:(CCNode *)node cleanup:(BOOL)cleanup;

-(void)innerDraw;

@property (nonatomic, readwrite) CGSize innerSize;
@property (nonatomic, readwrite) ccColor3B innerColor;
@property (nonatomic, readwrite) GLubyte innerOpacity;
@property (nonatomic, readwrite) CGPoint innerPosition;

@end

typedef enum{
	CMMTouchState_none,
	CMMTouchState_onTouchChild,
	CMMTouchState_onDrag,
	CMMTouchState_onScroll, //none touch state
	CMMTouchState_onDragChild,
	CMMTouchState_onFixed,
} CMMTouchState;

#define cmmVarCMMLayerMaskDrag_minInnerLayerPositionDiffValue 0.4f

struct CMMScrollbarDesign{
	CMMScrollbarDesign(){
		colorX = colorY = ccc4(255.0f, 255.0f, 255.0f, 145.0f);
		widthX = widthY = 2.0f;
		distanceX = distanceY = 4.0f;
	}
	
	ccColor4B colorX,colorY;
	float widthX,widthY,distanceX,distanceY;
};

@interface CMMLayerMaskDrag : CMMLayerMask{
	BOOL isCanDragX,isCanDragY;
	float dragAccelRate;
	CMMTouchState touchState;
	CMMScrollbarDesign scrollbarDesign;
	
	float _scrollAccelX,_scrollAccelY;
	BOOL _isInnerLayerMoved;
}

-(void)update:(ccTime)dt_;

@property (nonatomic, readwrite) BOOL isCanDragX,isCanDragY;
@property (nonatomic, readwrite) float dragAccelRate;
@property (nonatomic, readwrite) CMMTouchState touchState;
@property (nonatomic, readwrite) CMMScrollbarDesign scrollbarDesign;

@end

@interface CMMLayerMaskDrag(ViewControl)

-(void)gotoTop;
-(void)gotoBottom;
-(void)gotoLeft;
-(void)gotoRight;

@end