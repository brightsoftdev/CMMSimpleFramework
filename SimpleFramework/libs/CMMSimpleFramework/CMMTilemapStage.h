//  Created by JGroup(kimbobv22@gmail.com)

#import "CMMStage.h"

#define cmmFuncCMMTilemapStage_tileYIndex(_curIndex_,_totalTileWidth_) floorf((_curIndex_)/(_totalTileWidth_))
#define cmmFuncCMMTilemapStage_tileXIndex(_curIndex_,_totalTileWidth_,_yIndex_) (_curIndex_) - ((_totalTileWidth_)*(_yIndex_))

@class CMMTilemapStage;

@protocol CMMTilemapStageDelegate <CMMStageDelegate>

@optional
-(BOOL)tilemapStage:(CMMTilemapStage *)stage_ isSingleTileAtTMXLayer:(CCTMXLayer *)tmxLayer_ tile:(CCSprite *)tile_ xIndex:(float)xIndex_ yIndex:(float)yIndex_;
-(void)tilemapStage:(CMMTilemapStage *)stage_ whenTileBuiltupAtTMXLayer:(CCTMXLayer *)tmxLayer_ fromXIndex:(float)fromXIndex_ toXIndex:(float)toXIndex_ yIndex:(float)yIndex_ tileFixture:(b2Fixture *)tileFixture_;

@end

@interface CMMTilemapStage : CMMStage{
	CCTMXTiledMap *tilemap;
	CCArray *groundTMXLayers;
	CMMb2ContactMask b2MaskTile;
	
	BOOL isTilemapBuiltup;
}

+(id)stageWithCMMStageSpecDef:(CMMStageSpecDef)stageSpecDef_ tmxFileName:(NSString *)tmxFileName_ isInDocument:(BOOL)isInDocument_;
-(id)initWithCMMStageSpecDef:(CMMStageSpecDef)stageSpecDef_ tmxFileName:(NSString *)tmxFileName_ isInDocument:(BOOL)isInDocument_;

@property (nonatomic, readonly) CCTMXTiledMap *tilemap;
@property (nonatomic, readonly) CCArray *groundTMXLayers;
@property (nonatomic, readonly) BOOL isTilemapBuiltup;

@end

@interface CMMTilemapStage(Tilemap)

-(void)addGroundTMXLayerAtLayerName:(NSString *)tmxLayerName_;
-(void)removeGroundTMXLayerAtLayerName:(NSString *)tmxLayerName_;

-(void)buildupTilemap;

@end