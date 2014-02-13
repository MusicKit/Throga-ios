
#import <Foundation/Foundation.h>

@interface Exercise : NSObject {
	
    NSInteger _id;
	
	NSString *_name;
	NSString *_formant;
	NSString *_feature;
	NSString *_pattern;
	NSString *_volume;
	NSString *_tempo;
	NSString *_variable;
	
	NSInteger _flexibility;
	NSInteger _breathing;
	NSInteger _intonation;
	NSInteger _range;
	NSInteger _tone;
	NSInteger _articulation;
	NSInteger _strength;
}
@property NSInteger id;

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *formant;
@property (nonatomic, strong) NSString *feature;
@property (nonatomic, strong) NSString *pattern;
@property (nonatomic, strong) NSString *volume;
@property (nonatomic, strong) NSString *tempo;
@property (nonatomic, strong) NSString *variable;

@property NSInteger flexibility;
@property NSInteger breathing;
@property NSInteger intonation;
@property NSInteger range;
@property NSInteger tone;
@property NSInteger articulation;
@property NSInteger strength;


@end
