//
//  ANTLRTreeNodeStream.h
//  ANTLR
//
//  Created by Ian Michell on 22/03/2010.
//  Copyright 2010 Ian Michell. All rights reserved.
//

// [The "BSD licence"]
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions
// are met:
// 1. Redistributions of source code must retain the above copyright
//    notice, this list of conditions and the following disclaimer.
// 2. Redistributions in binary form must reproduce the above copyright
//    notice, this list of conditions and the following disclaimer in the
//    documentation and/or other materials provided with the distribution.
// 3. The name of the author may not be used to endorse or promote products
//    derived from this software without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR
// IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
// OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
// IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
// INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
// NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
// DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
// THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
// THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#import <Cocoa/Cocoa.h>
#import <ANTLR/ANTLRIntStream.h>
#import <ANTLR/ANTLRTokenStream.h>
#import <ANTLR/ANTLRTreeAdaptor.h>

@protocol ANTLRTreeNodeStream <NSObject, ANTLRIntStream>

-(id) get:(NSInteger) i;
-(id) LT:(NSInteger) i;
-(void) reset;
-(NSString *) stringValueFromObjects:(id) start end:(id) stop;
-(void) replaceChildren:(id<ANTLRTree>) parent start:(NSInteger) startIdx end:(NSInteger) stopIdx object:(id<ANTLRTree>) t;

@property(readwrite, retain) id<ANTLRTree> treeSource;
@property(readwrite, retain) id<ANTLRTokenStream> tokenStream;
@property(readwrite, retain) id<ANTLRTreeAdaptor> treeAdaptor;
@property(readwrite) BOOL uniqueNavigationNodes;

@end