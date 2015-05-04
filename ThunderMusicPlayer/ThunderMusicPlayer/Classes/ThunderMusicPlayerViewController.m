//
//  ThunderMusicPlayerViewController.m
//  ThunderMusicPlayer
//
//  Created by 14ACaputo on 5/15/14.
//  Copyright __MyCompanyName__ 2014. All rights reserved.
//

#import "ThunderMusicPlayerViewController.h"
#import "ThunderMusicPlayerAppDelegate.h"

@implementation ThunderMusicPlayerViewController

@synthesize playMusicButton;
@synthesize skipForwardButton;
@synthesize skipBackwardButton;
@synthesize albumArt;
@synthesize shouldPlayMusic;

int i = 0;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
		
    }
    return self;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	srandom(time(0));
	
	songFilenames = [[NSMutableArray alloc] init];
	
	NSMutableArray *paths = [[[NSBundle mainBundle] pathsForResourcesOfType:@"mp3" inDirectory:nil] mutableCopy];
	for (NSString *filename in paths) {
		[songFilenames addObject:filename];}
	[paths release];	
	
	int i = 0;
	NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
	NSString* mp3File = [songFilenames objectAtIndex:i];
	NSURL* musicURL = [NSURL fileURLWithPath:mp3File];
	NSError* error;
	musicPlayer = [AVAudioPlayer alloc];
	[musicPlayer initWithContentsOfURL:musicURL error:&error];
	musicPlayer.numberOfLoops = -1;
	[musicPlayer retain];	
	[defaults registerDefaults:[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:FALSE], @"shouldPlayMusic", nil]];
	self.shouldPlayMusic = [defaults boolForKey:@"shouldPlayMusic"];
	
}

- (void)setShouldPlayMusic:(BOOL)play {
	shouldPlayMusic = play;
	if (play == TRUE) {
		if (![musicPlayer isPlaying]) [musicPlayer play];
	}
	else {
		[musicPlayer stop];}}

- (void)loadNextSong {
	i ++;
	if (i >= [songFilenames count]) {
		i = 0;}
	[musicPlayer dealloc];
	NSString* mp3File = [songFilenames objectAtIndex:i];
	NSURL* musicURL = [NSURL fileURLWithPath:mp3File];
	NSError* error;
	musicPlayer = [AVAudioPlayer alloc];
	[musicPlayer initWithContentsOfURL:musicURL error:&error];
	musicPlayer.numberOfLoops = -1;
	[musicPlayer retain];
	
	if (shouldPlayMusic == TRUE) {
		[musicPlayer play];}
	[songTitle setText:mp3File];
}

- (void)loadPreviousSong {
	i --;
	if (i < 0) {
		i = [songFilenames count]-1;}
	[musicPlayer dealloc];
	NSString* mp3File = [songFilenames objectAtIndex:i];
	NSURL* musicURL = [NSURL fileURLWithPath:mp3File];
	NSError* error;
	musicPlayer = [AVAudioPlayer alloc];
	[musicPlayer initWithContentsOfURL:musicURL error:&error];
	musicPlayer.numberOfLoops = -1;
	[musicPlayer retain];
	
	if (shouldPlayMusic == TRUE) {
		[musicPlayer play];}
	[songTitle setText:mp3File];
}

- (IBAction)playMusic:(UIButton*)sender {
	
	if ([playMusicButton.titleLabel.text isEqualToString:@"Play"]) {
		[playMusicButton setTitle:@"Pause" forState:UIControlStateNormal];
		shouldPlayMusic = TRUE;
		[self setShouldPlayMusic:shouldPlayMusic];}
	else {
		[playMusicButton setTitle:@"Play" forState:UIControlStateNormal];
		shouldPlayMusic = FALSE;
		[self setShouldPlayMusic:shouldPlayMusic];}
	[songTitle setText:mp3File];
	
}

- (IBAction)skipForward:(id)sender {
	[self loadNextSong];
}

- (IBAction)skipBackward:(id)sender {
	[self loadPreviousSong];
}

- (void)setAlbumArt {
	
	/*NSURL *u = [NSURL fileURLWithPath:path];
	 AVURLAsset *a = [AVURLAsset URLAssetWithURL:u options:nil];
	 NSArray *k = [NSArray arrayWithObjects:@"commonMetadata", nil];
	 
	 [a loadValuesAsynchronouslyForKeys:k completionHandler: ^{
	 NSArray *artworks = [AVMetadataItem metadataItemsFromArray:a.commonMetadata
	 withKey:AVMetadataCommonKeyArtwork keySpace:AVMetadataKeySpaceCommon];
	 
	 NSMutableArray *artworkImages = [NSMutableArray array];
	 for (AVMetadataItem *i in artworks)
	 {
	 NSString *keySpace = i.keySpace;
	 UIImage *im = nil;
	 
	 if ([keySpace isEqualToString:AVMetadataKeySpaceID3])
	 {
	 NSDictionary *d = [i.value copyWithZone:nil];
	 im = [UIImage imageWithData:[d objectForKey:@"data"]];
	 }
	 else if ([keySpace isEqualToString:AVMetadataKeySpaceiTunes])
	 im = [UIImage imageWithData:[i.value copyWithZone:nil]];
	 
	 if (im)
	 [artworkImages addObject:im];
	 }
	 
	 completion(artworkImages);
	 }];*/
	
}

/*- (NSDictionary *)songID3Tags
 {   
 AudioFileID fileID = nil;
 OSStatus error = noErr;
 error = AudioFileOpenURL((CFURLRef)self.filePath, kAudioFileReadPermission, 0, &fileID);
 if (error != noErr) {
 NSLog(@"AudioFileOpenURL failed");
 }
 UInt32 id3DataSize  = 0;
 char *rawID3Tag    = NULL;
 
 error = AudioFileGetPropertyInfo(fileID, kAudioFilePropertyID3Tag, &id3DataSize, NULL);
 if (error != noErr)
 NSLog(@"AudioFileGetPropertyInfo failed for ID3 tag");
 
 rawID3Tag = (char *)malloc(id3DataSize);
 if (rawID3Tag == NULL)
 NSLog(@"could not allocate %lu bytes of memory for ID3 tag", id3DataSize);
 
 error = AudioFileGetProperty(fileID, kAudioFilePropertyID3Tag, &id3DataSize, rawID3Tag);
 if( error != noErr )
 NSLog(@"AudioFileGetPropertyID3Tag failed");
 
 UInt32 id3TagSize = 0;
 UInt32 id3TagSizeLength = 0;
 
 error = AudioFormatGetProperty(kAudioFormatProperty_ID3TagSize, id3DataSize, rawID3Tag, &id3TagSizeLength, &id3TagSize);
 
 if (error != noErr) {
 NSLog( @"AudioFormatGetProperty_ID3TagSize failed" );
 switch(error) {
 case kAudioFormatUnspecifiedError:
 NSLog( @"Error: audio format unspecified error" ); 
 break;
 case kAudioFormatUnsupportedPropertyError:
 NSLog( @"Error: audio format unsupported property error" ); 
 break;
 case kAudioFormatBadPropertySizeError:
 NSLog( @"Error: audio format bad property size error" ); 
 break;
 case kAudioFormatBadSpecifierSizeError:
 NSLog( @"Error: audio format bad specifier size error" ); 
 break;
 case kAudioFormatUnsupportedDataFormatError:
 NSLog( @"Error: audio format unsupported data format error" ); 
 break;
 case kAudioFormatUnknownFormatError:
 NSLog( @"Error: audio format unknown format error" ); 
 break;
 default:
 NSLog( @"Error: unknown audio format error" ); 
 break;
 }
 }   
 
 CFDictionaryRef piDict = nil;
 UInt32 piDataSize = sizeof(piDict);
 
 error = AudioFileGetProperty(fileID, kAudioFilePropertyInfoDictionary, &piDataSize, &piDict);
 if (error != noErr)
 NSLog(@"AudioFileGetProperty failed for property info dictionary");
 
 free(rawID3Tag);
 
 return (NSDictionary*)piDict;
 }*/

/*- (NSArray *)artworksForFileAtPath:(NSString *)path {
 NSMutableArray *artworkImages = [NSMutableArray array];
 NSURL *u = [NSURL fileURLWithPath:path];
 AVURLAsset *a = [AVURLAsset URLAssetWithURL:u options:nil];
 NSArray *artworks = [AVMetadataItem metadataItemsFromArray:a.commonMetadata  withKey:AVMetadataCommonKeyArtwork keySpace:AVMetadataKeySpaceCommon];
 
 for (AVMetadataItem *i in artworks)
 {
 NSString *keySpace = i.keySpace;
 UIImage *im = nil;
 
 if ([keySpace isEqualToString:AVMetadataKeySpaceID3])
 {
 NSDictionary *d = [i.value copyWithZone:nil];
 im = [UIImage imageWithData:[d objectForKey:@"data"]];
 }
 else if ([keySpace isEqualToString:AVMetadataKeySpaceiTunes])
 im = [UIImage imageWithData:[i.value copyWithZone:nil]];
 
 if (im)
 [artworkImages addObject:im];
 }
 NSLog(@"array description is %@", [artworkImages description]);
 return artworkImages; }
 
 - (NSMutableDictionary *)artists {
 return artists;}*/


/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end

@implementation NSString (displayName)
- (NSString *)convertToDisplayName
{
	// get the name from the end of the string after the hyphen
	NSString *name = [[self componentsSeparatedByString:@"-"]
					  objectAtIndex:1];
	
	// get a mutable copy of the name for editing
	NSMutableString *displayName = [[name mutableCopy] autorelease];
	
	// remove the .mp3 from the end of the name
	[displayName replaceOccurrencesOfString:@".mp3" withString:@""
									options:NSLiteralSearch range:NSMakeRange(0, displayName.length)];
	
	// replace all underscores with spaces
	[displayName replaceOccurrencesOfString:@"_" withString:@" "
									options:NSLiteralSearch range:NSMakeRange(0, displayName.length)];
	
	return displayName;
} // end method convertToDisplayName
@end // end implementation of NSString