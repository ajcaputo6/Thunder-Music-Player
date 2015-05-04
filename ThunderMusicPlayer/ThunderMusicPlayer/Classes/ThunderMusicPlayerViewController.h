//
//  ThunderMusicPlayerViewController.h
//  ThunderMusicPlayer
//
//  Created by 14ACaputo on 5/15/14.
//  Copyright __MyCompanyName__ 2014. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface ThunderMusicPlayerViewController : UIViewController {
	
	UIButton* playMusicButton;
	UIButton* skipForwardButton;
	UIButton* skipBackwardButton;
	IBOutlet UILabel* songTitle;
	IBOutlet UIImageView* albumArt;
	NSMutableArray* artistNames;
	NSMutableDictionary* artists;
	
	BOOL shouldPlayMusic;
	AVAudioPlayer* musicPlayer;
	NSMutableArray* songFilenames;
	
}

- (void)setShouldPlayMusic:(BOOL)play;
- (void)loadNextSong;
- (void)loadPreviousSong;
- (IBAction)playMusic:(UIButton*)sender;
- (IBAction)skipForward:(id)sender;
- (IBAction)skipBackward:(id)sender;
- (void)setAlbumArt;
//- (NSMutableDictionary *)artists;
//- (NSDictionary *)songID3Tags;
//- (NSArray *)artworksForFileAtPath:(NSString *)path;

@property (nonatomic, retain)IBOutlet UIButton* playMusicButton;
@property (nonatomic, retain)IBOutlet UIButton* skipForwardButton;
@property (nonatomic, retain)IBOutlet UIButton* skipBackwardButton;
@property (nonatomic, retain)IBOutlet UIImageView* albumArt;
@property (assign) BOOL shouldPlayMusic;

@end

@interface NSString (displayName)

- (NSString *)convertToDisplayName;

@end
