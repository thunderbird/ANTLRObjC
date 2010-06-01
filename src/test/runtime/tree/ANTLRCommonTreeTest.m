//
//  ANTLRCommonTreeTest.m
//  ANTLR
//
//  Created by Ian Michell on 26/05/2010.
//  Copyright 2010 Ian Michell. All rights reserved.
//

#import "ANTLRCommonTreeTest.h"
#import "ANTLRStringStream.h"
#import "ANTLRCommonTree.h"
#import "ANTLRCommonToken.h"
#import "ANTLRError.h"

@implementation ANTLRCommonTreeTest

-(void) testInitAndRelease
{
	ANTLRCommonTree *tree = [ANTLRCommonTree new];
	STAssertNotNil(tree, @"Tree was nil");
	STAssertEquals(tree.type, (NSInteger)ANTLRTokenTypeInvalid, @"Tree should have an invalid token type, because it has not token");
	STAssertEquals(tree.line, (NSInteger)0, @"Tree should be at line 0");
	STAssertEquals(tree.charPositionInLine, (NSInteger)0, @"Char position should be 0");
	[tree release];
}

-(void) testInitWithTree
{
	ANTLRCommonTree *tree = [[ANTLRCommonTree alloc] initWithTree:[ANTLRTree invalidNode]];
	STAssertNotNil(tree, @"Tree was nil");
	// FIXME: It doesn't do anything else, perhaps initWithTree should set something somewhere, java says no though...
	[tree release];
}

-(void) testWithToken
{
	ANTLRStringStream *stream = [[ANTLRStringStream alloc] initWithInput:@"this||is||a||double||piped||separated||csv"];
	ANTLRCommonToken *token = [[ANTLRCommonToken alloc] initWithCharStream:stream type:555 channel:ANTLRTokenChannelDefault start:4 stop:6];
	token.line = 1;
	token.charPositionInLine = 4;
	ANTLRCommonTree *tree = [[ANTLRCommonTree alloc] initWithToken:token];
	STAssertNotNil(tree, @"Tree was nil");
	STAssertEquals(tree.line, (NSInteger)1, @"Tree should be at line 1");
	STAssertEquals(tree.charPositionInLine, (NSInteger)1, @"Char position should be 1");
	STAssertTrue([tree.text isEqualToString:@"||"], @"Text was not ||");
	[tree release];
}

-(void) testInvalidTreeNode
{
	ANTLRCommonTree *tree = [ANTLRCommonTree invalidNode];
	STAssertNotNil(tree, @"Tree was nil");
	STAssertEquals(tree.type, (NSInteger)ANTLRTokenTypeInvalid, @"Tree Token type was not ANTLRTokenTypeInvalid");
	[tree release];
}

-(void) testInitWithCommonTreeNode
{
	ANTLRStringStream *stream = [[ANTLRStringStream alloc] initWithInput:@"this||is||a||double||piped||separated||csv"];
	ANTLRCommonToken *token = [[ANTLRCommonToken alloc] initWithCharStream:stream type:555 channel:ANTLRTokenChannelDefault start:4 stop:6];
	ANTLRCommonTree *tree = [[ANTLRCommonTree alloc] initWithToken:token];
	STAssertNotNil(tree, @"Tree was nil");
	ANTLRCommonTree *newTree = [[ANTLRCommonTree alloc] initWithCommonTreeNode:tree];
	STAssertNotNil(newTree, @"New tree was nil");
	STAssertEquals(newTree.token, tree.token, @"Tokens did not match");
	STAssertEquals(newTree.tokenStopIndex, tree.tokenStopIndex, @"Token stop index did not match");
	STAssertEquals(newTree.tokenStartIndex, tree.tokenStartIndex, @"Token start index did not match");
	[stream release];
	[tree release];
	[newTree release];
	[token release];
}

-(void) testCopyTree
{
	ANTLRStringStream *stream = [[ANTLRStringStream alloc] initWithInput:@"this||is||a||double||piped||separated||csv"];
	ANTLRCommonToken *token = [[ANTLRCommonToken alloc] initWithCharStream:stream type:555 channel:ANTLRTokenChannelDefault start:4 stop:6];
	ANTLRCommonTree *tree = [[ANTLRCommonTree alloc] initWithToken:token];
	STAssertNotNil(tree, @"Tree was nil");
	ANTLRCommonTree *newTree = [tree copyWithZone:nil];
	STAssertTrue([newTree isKindOfClass:[ANTLRCommonTree class]], @"Copied tree was not an ANTLRCommonTree");
	STAssertNotNil(newTree, @"New tree was nil");
	STAssertEquals(newTree.token, tree.token, @"Tokens did not match");
	STAssertEquals(newTree.tokenStopIndex, tree.tokenStopIndex, @"Token stop index did not match");
	STAssertEquals(newTree.tokenStartIndex, tree.tokenStartIndex, @"Token start index did not match");
	[stream release];
	[tree release];
	[newTree release];
	[token release];
	
}

-(void) testDescription
{
	ANTLRCommonTree *errorTree = [ANTLRCommonTree invalidNode];
	STAssertNotNil(errorTree, @"Error tree node is nil");
	STAssertTrue([[errorTree description] isEqualToString:@"<errornode>"], @"Not a valid error node description");
	[errorTree release];
	
	ANTLRCommonTree *tree = [[ANTLRCommonTree alloc] initWithTokenType:ANTLRTokenTypeUP];
	STAssertNotNil(tree, @"Tree is nil");
	STAssertNil([tree description], @"Tree description was not nil, was: %@", [tree description]);
	[tree release];
	
	tree = [ANTLRCommonTree new];
	STAssertNotNil(tree, @"Tree is nil");
	STAssertTrue([[tree description] isEqualToString:@"nil"], @"Tree description was not empty", [tree description]);
	[tree release];
	
	ANTLRStringStream *stream = [[ANTLRStringStream alloc] initWithInput:@"this||is||a||double||piped||separated||csv"];
	ANTLRCommonToken *token = [[ANTLRCommonToken alloc] initWithCharStream:stream type:555 channel:ANTLRTokenChannelDefault start:4 stop:6];
	tree = [[ANTLRCommonTree alloc] initWithToken:token];
	STAssertNotNil(tree, @"Tree node is nil");
	STAssertTrue([[tree description] isEqualToString:@"||"], @"description was not || was instead %@", [tree description]);
	[tree release];
}

-(void) testText
{
	ANTLRStringStream *stream = [[ANTLRStringStream alloc] initWithInput:@"this||is||a||double||piped||separated||csv"];
	ANTLRCommonToken *token = [[ANTLRCommonToken alloc] initWithCharStream:stream type:555 channel:ANTLRTokenChannelDefault start:4 stop:6];
	ANTLRCommonTree *tree = [[ANTLRCommonTree alloc] initWithToken:token];
	STAssertNotNil(tree, @"Tree was nil");
	STAssertTrue([tree.text isEqualToString:@"||"], @"Tree text was not valid, should have been || was %@", tree.text);
	[tree release];
	
	// test nil (for line coverage)
	tree = [ANTLRCommonTree new];
	STAssertNotNil(tree, @"Tree was nil");
	STAssertNil(tree.text, @"Tree text was not nil: %@", tree.text);
}

-(void) testAddChild
{
	// Create a new tree
	ANTLRCommonTree *parent = [ANTLRCommonTree new];
	
	// Child tree
	ANTLRStringStream *stream = [[ANTLRStringStream alloc] initWithInput:@"this||is||a||double||piped||separated||csv"];
	ANTLRCommonToken *token = [[ANTLRCommonToken alloc] initWithCharStream:stream type:555 channel:ANTLRTokenChannelDefault start:4 stop:6];
	token.line = 1;
	token.charPositionInLine = 4;
	ANTLRCommonTree *tree = [[ANTLRCommonTree alloc] initWithToken:token];
	
	// Add a child to the parent tree
	[parent addChild: tree];

	STAssertEquals(parent.line, (NSInteger)1, @"Tree should be at line 1");
	STAssertEquals(parent.charPositionInLine, (NSInteger)1, @"Char position should be 1");
	
	STAssertEquals(parent.childCount, (NSInteger)1, @"There were either no children or more than 1: %d", parent.childCount);
	STAssertEquals([parent childAtIndex:0].childIndex, (NSInteger)0, @"Child index should be 0 was : %d", [parent childAtIndex:0].childIndex);
	STAssertEquals([parent childAtIndex:0].parent, parent, @"Parent not set for child");
	
	[parent release];
}

-(void) testAddSelfAsChild
{
	ANTLRCommonTree *parent = [ANTLRCommonTree new];
	ANTLRCommonTree *emptyChild = [ANTLRCommonTree new];
	STAssertTrue(emptyChild.isEmpty, @"Child not empty");
	@try 
	{
		[parent addChild:emptyChild];
	}
	@catch (NSException * e) 
	{
		STAssertTrue([[e name] isEqualToString:ANTLRIllegalArgumentException], @"Got wrong king of exception!");
		return;
	}
	STFail(@"Did not get an exception when adding an empty child!");
}

-(void) testChildAtIndex
{
	// Create a new tree
	ANTLRCommonTree *parent = [ANTLRCommonTree new];
	
	// Child tree
	ANTLRStringStream *stream = [[ANTLRStringStream alloc] initWithInput:@"this||is||a||double||piped||separated||csv"];
	ANTLRCommonToken *token = [[ANTLRCommonToken alloc] initWithCharStream:stream type:555 channel:ANTLRTokenChannelDefault start:4 stop:6];
	ANTLRCommonTree *tree = [[ANTLRCommonTree alloc] initWithToken:token];
	
	// Add a child to the parent tree
	[parent addChild: tree];
	
	STAssertEquals((NSInteger)parent.childCount, (NSInteger)1, @"There were either no children or more than 1: %d", parent.childCount);
	
	ANTLRTree *child = [parent childAtIndex:0];
	STAssertNotNil(child, @"Child at index 0 should not be nil");
	STAssertEquals(child, tree, @"Child and Original tree were not the same");
	[parent release];
}

-(void) testSetChildAtIndex
{
	ANTLRCommonTree *parent = [ANTLRCommonTree new];
	
	// Child tree
	ANTLRStringStream *stream = [[ANTLRStringStream alloc] initWithInput:@"this||is||a||double||piped||separated||csv"];
	ANTLRCommonToken *token = [[ANTLRCommonToken alloc] initWithCharStream:stream type:555 channel:ANTLRTokenChannelDefault start:4 stop:6];
	ANTLRCommonTree *tree = [[ANTLRCommonTree alloc] initWithToken:token];
	
	[parent addChild:tree];
	
	tree = [[ANTLRCommonTree alloc] initWithTokenType:ANTLRTokenTypeUP];
	tree.token.text = @"<UP>";
	
	STAssertTrue(tree != [parent childAtIndex:0], @"Trees match");
	[parent setChildAtIndex:0 child:tree];
	
	ANTLRTree *child = [parent childAtIndex:0];
	STAssertEquals(parent.childCount, (NSInteger)1, @"There were either no children or more than 1: %d", parent.childCount);
	STAssertNotNil(child, @"Child at index 0 should not be nil");
	STAssertEquals(child, tree, @"Child and Original tree were not the same");
	[parent release];
}

-(void) testGetAncestor
{
	ANTLRCommonTree *parent = [[ANTLRCommonTree alloc] initWithTokenType:ANTLRTokenTypeUP];
	parent.token.text = @"<UP>";
	
	ANTLRCommonTree *down = [[ANTLRCommonTree alloc] initWithTokenType:ANTLRTokenTypeDOWN];
	down.token.text = @"<DOWN>";
	
	[parent addChild:down];
	
	// Child tree
	ANTLRStringStream *stream = [[ANTLRStringStream alloc] initWithInput:@"this||is||a||double||piped||separated||csv"];
	ANTLRCommonToken *token = [[ANTLRCommonToken alloc] initWithCharStream:stream type:555 channel:ANTLRTokenChannelDefault start:4 stop:6];
	ANTLRCommonTree *tree = [[ANTLRCommonTree alloc] initWithToken:token];
	
	[down addChild:tree];
	STAssertTrue([tree hasAncestor:ANTLRTokenTypeUP], @"Should have an ancestor of type ANTLRTokenTypeUP");
	
	ANTLRCommonTree *ancestor = [tree getAncestor:ANTLRTokenTypeUP];
	STAssertNotNil(ancestor, @"Ancestor should not be nil");
	STAssertEquals(ancestor, parent, @"Acenstors do not match");
	[parent release];
}

-(void) testFirstChildWithType
{
	// Create a new tree
	ANTLRCommonTree *parent = [ANTLRCommonTree new];
	
	ANTLRCommonTree *up = [[ANTLRCommonTree alloc] initWithTokenType:ANTLRTokenTypeUP];
	ANTLRCommonTree *down = [[ANTLRCommonTree alloc] initWithTokenType:ANTLRTokenTypeDOWN];
	
	[parent addChild:up];
	[parent addChild:down];
	
	ANTLRCommonTree *found = [parent firstChildWithType:ANTLRTokenTypeDOWN];
	STAssertEquals((NSInteger)found.type, (NSInteger)ANTLRTokenTypeDOWN, @"Token type was not correct, should be down!");
	found = [parent firstChildWithType:ANTLRTokenTypeUP];
	STAssertEquals((NSInteger)found.type, (NSInteger)ANTLRTokenTypeUP, @"Token type was not correct, should be up!");
	[parent release];
}


@end
