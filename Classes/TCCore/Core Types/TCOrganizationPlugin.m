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

#import "TCOrganizationPlugin.h"
#import "TCCoreUtils.h"

@implementation TCOrganizationPlugin

static NSMutableArray *pluginArray;

+(BOOL)loadFrameworkAtPath:(NSString *)frameworkPath{
	return [TCCoreUtils loadFrameworkAtPath:frameworkPath];
}

+(void)initialize{
	NSLog(@"Initializing %@",[self class]);
}

+(NSManagedObjectModel *)objectModel{
	return [NSManagedObjectModel mergedModelFromBundles:[NSArray arrayWithObject:[NSBundle bundleForClass:self]]];
}

+(CFUUIDRef)generateUUID{
	CFUUIDRef ref = CFUUIDCreate(NULL);
	return ref;
}

-(id)init{
	if(self = [super init]){
		
	}
	return self;
}

-(void)awake{
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(objectsChanged:) name:NSManagedObjectContextObjectsDidChangeNotification object:nil];
}

-(void)objectsChanged:(NSNotification *)notif{
	NSSet *insertedObjects = [[notif userInfo] objectForKey:NSInsertedObjectsKey];
	for(TCExtendableObject *object in insertedObjects){
		[self handleInsertedObject:object];
	}
}

-(void)handleInsertedObject:(TCExtendableObject *)object{ }

-(void)addViewController:(NSViewController *)controller forType:(NSString *)type{
	[[NSApp delegate] addViewController:controller forType:type];
}
-(CFUUIDRef)uuid{
	CFUUIDRef uuid = [TCOrganizationPlugin generateUUID];
	NSString *uuidString = (NSString *)CFUUIDCreateString(NULL, uuid);
	NSLog(@"Add this line to your %@ .m file\n\nTCUUID(\@\"%@\")",[self className],uuidString);
	return uuid;
}

-(NSString *)uuidString{
	CFUUIDRef uuid = [self uuid];
	
	CFStringRef uuidString = CFUUIDCreateString(NULL, uuid);
	NSString *uuidStr = (NSString *)uuidString;
	return [uuidStr autorelease];
}

@end
