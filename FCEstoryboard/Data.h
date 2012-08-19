//
//  Data.h
//  FuhrerscheinAuto
//
//  Created by User on 1/10/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "sqlite3.h"
#import "FfBookmark.h"
#import "FfMultiple.h"
#import "FfWF.h"
#import "FfPV.h"
#import "FfWFList.h"


@interface Data : NSObject {
	NSMutableArray *lista;
	NSString *pathDB;
    NSString *pathLibrary;
    FfBookmark* bookmark;
    
    
}
@property(nonatomic, retain) NSMutableArray *lista;
@property(nonatomic,retain) FfBookmark* bookmark;


-(void) checkAndCopyDB;

-(void) loadLista:(NSString *) keysql;


-(void) loadBookmark:(NSString *) tipo;

-(void)saveBookmark:(FfBookmark *) bookmark;
-(void)resetFehler:(NSString *) filter;

-(void)insertError:(NSString *) question yourAnswer:(NSString *) youranswer rightAnswer:(NSString *)rightAnswer type:(NSString *) type;





@end
