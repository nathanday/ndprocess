#import <Foundation/Foundation.h>
#import "NDProcess.h"

int main (int argc, const char * argv[])
{
	NSAutoreleasePool			* pool = [[NSAutoreleasePool alloc] init];
	NSArray						* theProcessArray;
	NDProcess					* theFrontProcess,
	* theCurrentProcess,
	* theNamedProcess;
	int							theChar;

	theProcessArray = [NDProcess everyProcess];

	printf("every processes:\n%s\n\n", [[theProcessArray description] UTF8String]);

	theFrontProcess = [NDProcess frontProcess];
	printf("front process:\n\t%s\n\tlocation:%s\n", [[theFrontProcess description] UTF8String], [[theFrontProcess path] UTF8String]);
	printf("launched by:\n\t%s\n\n", [[[theFrontProcess launcher] description] UTF8String]);

	//	[[theFrontProcess retain] release];				// test reuses of instance
	theCurrentProcess = [NDProcess currentProcess];
	printf("current process:\n\t%s\n\tlocation:%s\n", [[theCurrentProcess description] UTF8String], [[theFrontProcess path] UTF8String]);
	printf("launched by:\n\t%s\n\n", [[[theCurrentProcess launcher] description] UTF8String]);

	theNamedProcess = [NDProcess firstProcessNamed:@"TextEdit"];
	if( theNamedProcess )
	{
		printf( "Waiting while you quit TextEdit, then press return to continue\n");
		theChar = getchar();

		if( [theNamedProcess isValid] )
		{
			printf("TextEdit process:\n\t%s, mode:%x\n\tlocation:%s\n", [[theNamedProcess description] UTF8String], (unsigned int)[theNamedProcess mode], [[theNamedProcess path] UTF8String] );
			printf("launched by:\n\t%s\n\n", [[[theNamedProcess launcher] description] UTF8String]);
		}
		else
			printf("\nTextEdit process is invalid\n" );
	}
	else
		printf( "Attempt to get TextEdit process returned nil\n");

	[pool release];
	return 0;
}


