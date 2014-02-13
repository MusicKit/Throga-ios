
#import <Foundation/Foundation.h>
#import <sqlite3.h>

#import "Exercise.h"

@interface Database : NSObject {
	
    sqlite3 *_database;
	NSMutableDictionary *_preparedStatements;
}

-(void)setupDatabase;

-(NSArray *)exerciseByTypeID:(NSInteger)typeID;

@end
