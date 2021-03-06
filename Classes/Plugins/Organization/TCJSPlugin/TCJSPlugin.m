/*
 
 Copyright (c) 2008 Technicolor Project
 Licensed under the MIT License
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 
 */

#import "TCJSPlugin.h"

#import "TCTVShowJSBridge.h"

@implementation TCJSPlugin

+(void)initialize{
	NSString *frameworkPath=[[[NSBundle bundleForClass:[self class]] bundlePath]
							 stringByAppendingPathComponent:@"Contents/Frameworks/JSXObjC.framework"];
	
	[TCOrganizationPlugin loadFrameworkAtPath: frameworkPath];
}

TCUUID(@"B040A569-DE2C-4CAF-9905-DB327C876C41")

-(void)awake{
	interpreter = [[JSXObjCInterpreter alloc] init];
	[interpreter setDelegate:self];
	NSLog(@"Created the interpreter %@",interpreter);
	
	mInterpreterController = [[TCJSInterpreterController alloc] initWithInterpreter:interpreter];
	[self addViewController:mInterpreterController forType:@"Workers"];
	
	[interpreter loadBridge:[TCTVShowJSBridge class]];
}

- (void) jsxobjcInterpreter: (JSXObjCInterpreter *) interpreter log: (NSString *) message{
	NSLog(@"jsxobjc Logging message %@",message);
}

- (void) jsxobjcInterpreter: (JSXObjCInterpreter *) interpreter print: (NSString *) message{
	NSLog(@"jsxobjc Printing message %@",message);	
}

- (BOOL) jsxobjcInterpreter: (JSXObjCInterpreter *) interpreter exception: (JSXObjCObject *) exception{
	NSLog(@"jsxobjc Exception object %@",exception);
}

@end
