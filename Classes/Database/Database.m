
#import "Database.h"

#define DATABASE @"throga"

@implementation Database

-(id)init {
	
    if ((self = [super init])) {
    }
    return self;
}

-(void)setupDatabase {

	NSError *error;

	NSString *dbName = [NSString stringWithFormat:@"%@", DATABASE];
	
	NSString *bundlePath = [[NSBundle mainBundle] pathForResource:dbName ofType:@"db"];

	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentPath = [documentPaths objectAtIndex:0];

	NSString *dbPath = [documentPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.db", dbName]];

	NSFileManager *fileManager = [NSFileManager defaultManager];
	
	if ([fileManager fileExistsAtPath:dbPath] == NO) {
		[fileManager copyItemAtPath:bundlePath toPath:dbPath error:&error];
	}
	
	if (sqlite3_open([dbPath UTF8String], &_database) != SQLITE_OK) {
		NSLog(@"ERROR : Failed to open database!");
	}
}

-(NSArray *)exerciseByTypeID:(NSInteger)typeID {

    sqlite3_stmt *statement;

    NSMutableArray *result = [[NSMutableArray alloc] init];

	NSString *query = @"SELECT exercise.id, exercise.name, formant, feature, pattern, volume, tempo, variable, flexibility, breathing, intonation, range, tone, articulation, strength"
	" FROM exercise, exercise_type, exercise_exercise_type"
	" WHERE exercise_type.id = ?"
	" AND exercise.id = exercise_exercise_type.exercise_id"
	" AND exercise_type.id = exercise_exercise_type.exercise_type_id"
	" ORDER BY flexibility DESC, strength DESC";

//	NSLog(@"%@", query);
	
	int success = sqlite3_prepare_v2(_database, [query UTF8String], -1, &statement, nil);
	sqlite3_bind_int(statement, 1, (int)typeID);

	if (success == SQLITE_OK) {

        while (sqlite3_step(statement) == SQLITE_ROW)  {
		
			Exercise *exercise = [[Exercise alloc]init];

			NSInteger field = 0;

			exercise.id = sqlite3_column_int(statement, field++);
			
			exercise.name = [[NSString alloc] initWithUTF8String:(char *) sqlite3_column_text(statement, field++)];
			exercise.formant = [[NSString alloc] initWithUTF8String:(char *) sqlite3_column_text(statement, field++)];
			exercise.feature = [[NSString alloc] initWithUTF8String:(char *) sqlite3_column_text(statement, field++)];
			exercise.pattern = [[NSString alloc] initWithUTF8String:(char *) sqlite3_column_text(statement, field++)];
			exercise.volume = [[NSString alloc] initWithUTF8String:(char *) sqlite3_column_text(statement, field++)];
			exercise.tempo = [[NSString alloc] initWithUTF8String:(char *) sqlite3_column_text(statement, field++)];
			exercise.variable = [[NSString alloc] initWithUTF8String:(char *) sqlite3_column_text(statement, field++)];

			exercise.flexibility = sqlite3_column_int(statement, field++);
			exercise.breathing = sqlite3_column_int(statement, field++);
			exercise.intonation = sqlite3_column_int(statement, field++);
			exercise.range = sqlite3_column_int(statement, field++);
			exercise.tone = sqlite3_column_int(statement, field++);
			exercise.articulation = sqlite3_column_int(statement, field++);
			exercise.strength = sqlite3_column_int(statement, field++);
			
			[result addObject:exercise];
		}
		sqlite3_finalize(statement);
    }
    else {
        NSLog(@"Error code : %d in %s in %s at line %d", success, __PRETTY_FUNCTION__, __FILE__, __LINE__);
    }
    return result;
}

//-(Topic *)topicByTopicID:(NSInteger)topicID {
//
//    sqlite3_stmt *statement;
//	Topic *data = [[Topic alloc] init];
//	
//	NSString *query = @"SELECT id, title, subtitle, questioncount FROM topic WHERE id = ?";
//	
//    int success = sqlite3_prepare_v2(_database, [query UTF8String], -1, &statement, nil);
//	sqlite3_bind_int(statement, 1, (int)topicID);
//	
//    if (success == SQLITE_OK) {
//		
//        while (sqlite3_step(statement) == SQLITE_ROW) {
//			
//			NSInteger field = 0;
//			
//			data.id            = sqlite3_column_int(statement, field++);
//			data.title          = [[NSString alloc] initWithUTF8String:(char *) sqlite3_column_text(statement, field++)];
//			data.subtitle          = [[NSString alloc] initWithUTF8String:(char *) sqlite3_column_text(statement, field++)];
//			data.questioncount = sqlite3_column_int(statement, field++);
//        }
//        sqlite3_finalize(statement);
//    }
//    else {
//        NSLog(@"Error code : %d in %s in %s at line %d", success, __PRETTY_FUNCTION__, __FILE__, __LINE__);
//    }
//    return data;
//}

@end
