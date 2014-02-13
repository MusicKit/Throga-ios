
#import "Exercise.h"

@implementation Exercise

@synthesize id = _id;

@synthesize name = _name;
@synthesize formant = _formant;
@synthesize feature = _feature;
@synthesize pattern = _pattern;
@synthesize volume = _volume;
@synthesize tempo = _tempo;
@synthesize variable = _variable;

@synthesize flexibility = _flexibility;
@synthesize breathing = _breathing;
@synthesize intonation = _intonation;
@synthesize range = _range;
@synthesize tone = _tone;
@synthesize articulation = _articulation;
@synthesize strength = _strength;

-(NSString *)description {
	NSString *string = [NSString stringWithFormat:@"%d, %@, %@, %@, %@, %@, %@, %@, %d, %d, %d, %d, %d, %d, %d",
		_id, _name, _formant, _feature, _pattern, _volume, _tempo, _variable, _flexibility, _breathing, _intonation, _range, _tone, _articulation, _strength];
	
	return string;
}

@end
