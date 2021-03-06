//  Created by JGroup(kimbobv22@gmail.com)

#import "ScrollMenuTestLayer.h"
#import "HelloWorldLayer.h"

@implementation ScrollMenuTestLayer

-(id)initWithColor:(ccColor4B)color width:(GLfloat)w height:(GLfloat)h{
	if(!(self = [super initWithColor:color width:w height:h])) return self;
	
	CMMMenuItemLabelTTF *menuItemButton_ = [CMMMenuItemLabelTTF menuItemWithFrameSeq:0];
	[menuItemButton_ setTitle:@"BACK"];
	menuItemButton_.position = ccp(menuItemButton_.contentSize.width/2+20,menuItemButton_.contentSize.height/2);
	menuItemButton_.callback_pushup = ^(id sender_){
		[[CMMScene sharedScene] pushLayer:[HelloWorldLayer node]];
	};
	[self addChild:menuItemButton_];
	
	menuItemButton_ = [CMMMenuItemLabelTTF menuItemWithFrameSeq:0];
	[menuItemButton_ setTitle:@"SCROLLMENU H"];
	menuItemButton_.position = ccp(contentSize_.width/2.0f-menuItemButton_.contentSize.width/2-10.0f,contentSize_.height/2.0f);
	menuItemButton_.callback_pushup = ^(id sender_){
		[[CMMScene sharedScene] pushLayer:[ScrollMenuTestLayer_H node]];
	};
	[self addChild:menuItemButton_];
	
	menuItemButton_ = [CMMMenuItemLabelTTF menuItemWithFrameSeq:0];
	[menuItemButton_ setTitle:@"SCROLLMENU V"];
	menuItemButton_.position = ccp(contentSize_.width/2.0f+menuItemButton_.contentSize.width/2+10.0f,contentSize_.height/2.0f);
	menuItemButton_.callback_pushup = ^(id sender_){
		[[CMMScene sharedScene] pushLayer:[ScrollMenuTestLayer_V node]];
	};
	[self addChild:menuItemButton_];
	
	return self;
}

@end

@implementation ScrollMenuTestLayer_H

-(id)initWithColor:(ccColor4B)color width:(GLfloat)w height:(GLfloat)h{
	if(!(self = [super initWithColor:color width:w height:h])) return self;
	
	scrollMenu1 = [CMMScrollMenuH scrollMenuWithFrameSeq:1 frameSize:CGSizeMake(200,220)];
	scrollMenu1.delegate = self;
	scrollMenu1.position = ccpSub(cmmFuncCommon_position_center(self, scrollMenu1),ccp(scrollMenu1.contentSize.width/2+20,-40));
	[self addChild:scrollMenu1];
	
	scrollMenu2 = [CMMScrollMenuH scrollMenuWithFrameSeq:0 frameSize:CGSizeMake(200,220)];
	scrollMenu2.delegate = self;
	scrollMenu2.position = ccpAdd(cmmFuncCommon_position_center(self, scrollMenu2),ccp(scrollMenu2.contentSize.width/2+20,40));
	[self addChild:scrollMenu2];
	
	CMMMenuItemLabelTTF *menuItemButton_ = [CMMMenuItemLabelTTF menuItemWithFrameSeq:0];
	[menuItemButton_ setTitle:@"remove"];
	menuItemButton_.position = ccp(self.contentSize.width-menuItemButton_.contentSize.width/2,menuItemButton_.contentSize.height/2);
	menuItemButton_.callback_pushup = ^(id sender_){
		[scrollMenu2 removeItemAtIndex:0];
	};
	[self addChild:menuItemButton_];
	
	menuItemButton_ = [CMMMenuItemLabelTTF menuItemWithFrameSeq:0];
	[menuItemButton_ setTitle:@"add"];
	menuItemButton_.position = ccp(self.contentSize.width-menuItemButton_.contentSize.width-menuItemButton_.contentSize.width/2,menuItemButton_.contentSize.height/2);
	menuItemButton_.callback_pushup = ^(id sender_){
		CMMMenuItemLabelTTF *menuItem_ = [CMMMenuItemLabelTTF menuItemWithFrameSeq:0 frameSize:CGSizeMake(scrollMenu2.contentSize.width,35)];
		[menuItem_ setTitle:[NSString stringWithFormat:@"object %d",scrollMenu2.count]];
		[scrollMenu2 addItem:menuItem_];
	};
	[self addChild:menuItemButton_];
	
	menuItemButton_ = [CMMMenuItemLabelTTF menuItemWithFrameSeq:0];
	[menuItemButton_ setTitle:@"BACK"];
	menuItemButton_.position = ccp(menuItemButton_.contentSize.width/2+20,menuItemButton_.contentSize.height/2);
	menuItemButton_.callback_pushup = ^(id sender_){
		[[CMMScene sharedScene] pushLayer:[ScrollMenuTestLayer node]];
	};
	[self addChild:menuItemButton_];
	
	labelDisplay = [CMMFontUtil labelWithstring:@" "];
	[self addChild:labelDisplay];
	
	return self;
}

-(void)_setDisplayStr:(NSString *)str_{
	[labelDisplay setString:str_];
	labelDisplay.position = ccp(self.contentSize.width/2,scrollMenu1.position.y-labelDisplay.contentSize.height/2-10.0f);
}

-(BOOL)scrollMenu:(CMMScrollMenuH *)scrollMenu_ isCanDragItem:(CCNode<CMMTouchDispatcherDelegate> *)item_{return YES;}
-(BOOL)scrollMenu:(CMMScrollMenu *)scrollMenu_ isCanLinkSwitchItem:(CCNode<CMMTouchDispatcherDelegate> *)item_ toScrollMenu:(CMMScrollMenu *)toScrollMenu_ toIndex:(int)toIndex_{return YES;}
-(BOOL)scrollMenu:(CMMScrollMenu *)scrollMenu_ isCanSwitchItem:(CCNode<CMMTouchDispatcherDelegate> *)item_ toIndex:(int)toIndex_{return YES;}

-(void)scrollMenu:(CMMScrollMenu *)scrollMenu_ whenSelectedAtIndex:(int)index_{
	[self _setDisplayStr:[NSString stringWithFormat:@"whenSelectedAtIndex : %d",index_]];
}
-(void)scrollMenu:(CMMScrollMenu *)scrollMenu_ whenAddedItem:(CCNode<CMMTouchDispatcherDelegate> *)item_ atIndex:(int)index_{
	[self _setDisplayStr:[NSString stringWithFormat:@"whenAddedItem : %d",index_]];
}
-(void)scrollMenu:(CMMScrollMenu *)scrollMenu_ whenRemovedItem:(CCNode<CMMTouchDispatcherDelegate> *)item_{
	[self _setDisplayStr:@"whenRemovedItem"];
}
-(void)scrollMenu:(CMMScrollMenu *)scrollMenu_ whenSwitchedItem:(CCNode<CMMTouchDispatcherDelegate> *)item_ toIndex:(int)toIndex_{
	[self _setDisplayStr:[NSString stringWithFormat:@"whenSwitchedItem : %d",toIndex_]];
}
-(void)scrollMenu:(CMMScrollMenu *)scrollMenu_ whenLinkSwitchedItem:(CCNode<CMMTouchDispatcherDelegate> *)fromItem_ toScrollMenu:(CMMScrollMenu *)toScrollMenu_ toIndex:(int)toIndex_{
	[self _setDisplayStr:[NSString stringWithFormat:@"whenLinkSwitchedItem : %d",toIndex_]];
}
-(void)scrollMenu:(CMMScrollMenu *)scrollMenu_ whenPushdownWithItem:(CCNode<CMMTouchDispatcherDelegate> *)item_{
	[self _setDisplayStr:@"whenPushdownWithItem"];
}
-(void)scrollMenu:(CMMScrollMenu *)scrollMenu_ whenPushupWithItem:(CCNode<CMMTouchDispatcherDelegate> *)item_{
	[self _setDisplayStr:@"whenPushupWithItem"];
}
-(void)scrollMenu:(CMMScrollMenu *)scrollMenu_ whenPushcancelWithItem:(CCNode<CMMTouchDispatcherDelegate> *)item_{
	[self _setDisplayStr:@"whenPushcancelWithItem"];
}
@end

@implementation ScrollMenuTestLayer_V

-(id)initWithColor:(ccColor4B)color width:(GLfloat)w height:(GLfloat)h{
	if(!(self = [super initWithColor:color width:w height:h])) return self;
	
	scrollMenu = [CMMScrollMenuV scrollMenuWithFrameSeq:0 frameSize:CGSizeMake(320, 200)];
	scrollMenu.index = 0;
	scrollMenu.marginPerItem = 150.0f;
	//scrollMenu.isSnapAtItem = NO;
	scrollMenu.position = cmmFuncCommon_position_center(self, scrollMenu);
	[self addChild:scrollMenu];
	
	CMMMenuItemLabelTTF *menuItemButton_ = [CMMMenuItemLabelTTF menuItemWithFrameSeq:0];
	[menuItemButton_ setTitle:@"BACK"];
	menuItemButton_.position = ccp(menuItemButton_.contentSize.width/2+20,menuItemButton_.contentSize.height/2);
	menuItemButton_.callback_pushup = ^(id sender_){
		[[CMMScene sharedScene] pushLayer:[ScrollMenuTestLayer node]];
	};
	[self addChild:menuItemButton_];
	
	menuItemButton_ = [CMMMenuItemLabelTTF menuItemWithFrameSeq:0];
	[menuItemButton_ setTitle:@"add"];
	menuItemButton_.position = ccp(self.contentSize.width-menuItemButton_.contentSize.width-menuItemButton_.contentSize.width/2,menuItemButton_.contentSize.height/2);
	menuItemButton_.callback_pushup = ^(id sender_){		
		CMMScrollMenuVItem *item_ = [CMMScrollMenuVItem layerWithColor:ccc4(255, 255, 255, 180) width:(arc4random()%200 + 200) height:150];
		
		CMMControlItemSlider *slider_ = [CMMControlItemSlider controlItemSliderWithFrameSeq:0 width:180];
		slider_.position = cmmFuncCommon_position_center(item_, slider_);
		[item_ addChild:slider_];
		
		[scrollMenu addItem:item_];
	};
	[self addChild:menuItemButton_];
	
	return self;
}

@end
