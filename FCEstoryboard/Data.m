//
//  Data.m
//  FuhrerscheinAuto
//
//  Created by User on 1/10/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Data.h"



@implementation Data

static sqlite3 *database=nil;

@synthesize lista;
@synthesize bookmark;


NSString *const dbName=@"fce.db";
NSString *const version=@"v3";

-(id) init {
	  
    
//	self->pathDB=path;
   self->pathLibrary = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    //self->pathDB=[[NSBundle mainBundle] resourcePath];
	//[self caricaValoriDaDb:pathDB];
	
    self->pathDB=[NSString  stringWithFormat:@"%@/Database/db%@.db" , self->pathLibrary, version];
    
    [self checkAndCopyDB ];
  
    
    //[super init];
	return self;
	
}





-(void)saveBookmark:(FfBookmark *) bookmark {

	
	int resconn = sqlite3_open([pathDB UTF8String], &database);
	
    
	
	if (resconn == SQLITE_OK) {
        
        NSString *query = NSLocalizedStringFromTable(@"sqlupdatebookmark", @"InfoPlist", @"");
        
		//NSString * query = @"update  bookmarks set position=?  ";
		const char * sqlStatement = [query UTF8String];
		
		sqlite3_stmt * compiledStatement;
		
		if (sqlite3_prepare_v2(database, sqlStatement, -1 , &compiledStatement, NULL) == SQLITE_OK) {
			
			sqlite3_bind_int(compiledStatement, 1, bookmark.position);
            sqlite3_bind_text(compiledStatement, 2, [bookmark.tipo UTF8String] , -1, SQLITE_TRANSIENT);
			

		} 
		
		if (sqlite3_step(compiledStatement) == SQLITE_DONE) {
			
			NSLog(@"DONE");
		} else {
            NSLog(@"Update failed: %s", sqlite3_errmsg(database));
            
            
        }
        
        int rows= sqlite3_changes(database);
        
        NSLog(@"righe %d" , rows);

        
		sqlite3_finalize(compiledStatement);
		
        
	}
	
	
	sqlite3_close(database);
	
}


-(void) loadBookmark:(NSString *)tipo {
    NSMutableArray *listaTemp = [[NSMutableArray alloc] init];
	
	
	int resconn = sqlite3_open([pathDB UTF8String], &database);
	
    
	
	if (resconn == SQLITE_OK) {
        
		NSString *query = NSLocalizedStringFromTable(@"sqlsetbookmark", @"InfoPlist", @"");
       // NSString *query = @"update bookmarks set";
        
		const char *sql = [query UTF8String];
		
		sqlite3_stmt *selectstmt;
		
        
		int resprepare = sqlite3_prepare_v2(database, sql, -1, &selectstmt, NULL);
        
		
        if(resprepare == SQLITE_OK) {
        
            sqlite3_bind_text(selectstmt, 1, [tipo UTF8String], -1, SQLITE_TRANSIENT);
            
			if(sqlite3_step(selectstmt) == SQLITE_ROW) {
				
                
				bookmark = [[FfBookmark alloc] init];
                
				bookmark.tipo = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 0)
                              ];
                
				bookmark.position = sqlite3_column_int(selectstmt, 1);
                
                NSLog(@"dopo");
                
                //		[f release];
			}
            
                    
		}
        
        sqlite3_finalize(selectstmt);
		
    }
    sqlite3_close(database);
}


-(void)resetFehler:(NSString *) filter {
    
	
	int resconn = sqlite3_open([pathDB UTF8String], &database);
	  
	
	if (resconn == SQLITE_OK) {
        
        NSString *query = NSLocalizedStringFromTable(@"sqldeleteerrors", @"InfoPlist", @"");
        
	//	NSString * sql = [NSString stringWithFormat:@"delete  from errors where mode in ( %@ ) ", filter];
		const char * sqlStatement = [query UTF8String];
		
		sqlite3_stmt * compiledStatement;
		
		if (sqlite3_prepare_v2(database, sqlStatement, -1 , &compiledStatement, NULL) == SQLITE_OK) {
			
	//		sqlite3_bind_int(compiledStatement, 1, bookmark.position);
    //        sqlite3_bind_int(compiledStatement, 2, bookmark.quid);
	//		sqlite3_bind_int(compiledStatement, 3, quizmode);
            
		} 
		
		if (!sqlite3_step(compiledStatement) == SQLITE_DONE) {
			
			NSLog(@"Error @%" , sqlite3_errmsg(database));
		}
		
		sqlite3_finalize(compiledStatement);
		
        
	}
	
	
	sqlite3_close(database);
    
   
	
}

-(void)insertError:(NSString *) question yourAnswer:(NSString *) youranswer rightAnswer:(NSString *)rightAnswer type:(NSString *) type {
    

    int resconn = sqlite3_open([pathDB UTF8String], &database);
	
    
	
	if (resconn == SQLITE_OK) {
        
        NSString *query = NSLocalizedStringFromTable(@"sqlinserterror", @"InfoPlist", @"");
        
 //   NSString *query = @"INSERT INTO ERRORI (question, youranswer, rightanswer, type , data ) values ('dio porco 3', '?', '?', '?', '?' ) ";
        
	//	NSString * sql = @"update  bookmarks set position=? where tipo=? ";
		const char * sqlStatement = [query UTF8String];
		
		sqlite3_stmt * compiledStatement;
		
		if (sqlite3_prepare_v2(database, sqlStatement, -1 , &compiledStatement, NULL) == SQLITE_OK) {
			
	
            sqlite3_bind_text(compiledStatement, 1, [question UTF8String] , -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(compiledStatement, 2, [youranswer UTF8String] , -1, SQLITE_TRANSIENT);
			sqlite3_bind_text(compiledStatement, 3, [rightAnswer UTF8String] , -1, SQLITE_TRANSIENT);
            
            
            sqlite3_bind_text(compiledStatement, 4, [type UTF8String] , -1, SQLITE_TRANSIENT);
		
            NSDate * now = [NSDate date];
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"YY.MM.dd HH:mm:ss"];
            NSString * dateString =
            [dateFormatter stringFromDate:now];
            sqlite3_bind_text(compiledStatement, 5, [dateString UTF8String] , -1, SQLITE_TRANSIENT);
        }
                 int rows= sqlite3_changes(database);
		NSLog(@"righe %d" , rows);
//        			NSLog(@"Error @%" , sqlite3_errmsg(database));
		if (sqlite3_step(compiledStatement) == SQLITE_DONE) {
			
			NSLog(@"DONE");
		} else {
            NSLog(@"Insert failed: %s", sqlite3_errmsg(database));

            
        }

        
         rows= sqlite3_changes(database);
        
					NSLog(@"righe %d" , rows);
//        if (sqlite3_exec(database, sqlStatement, NULL, NULL, NULL) == SQLITE_OK) {
//            NSLog(@"errorrrrr");
//            
//        }
        
		sqlite3_finalize(compiledStatement);
		
        
	}
	
	
	sqlite3_close(database);
    

    
}




/*
 * ke
 */

-(void) loadLista:(NSString *) keysql {
    NSMutableArray *listaTemp = [[NSMutableArray alloc] init];
	
	
	int resconn = sqlite3_open([pathDB UTF8String], &database);
	
    
	
	if (resconn == SQLITE_OK) {
        
		NSString *query = NSLocalizedStringFromTable(keysql, @"InfoPlist", @"");
                           
                           
        
		const char *sql = [query UTF8String];
		
		sqlite3_stmt *selectstmt;
		
        
		int resprepare = sqlite3_prepare_v2(database, sql, -1, &selectstmt, NULL);
        
		
        if(resprepare == SQLITE_OK) {
            
            
			while(sqlite3_step(selectstmt) == SQLITE_ROW) {
				
                id fgen;
                
                if ([keysql isEqualToString:@"sqlmultiple"]) {
				FfMultiple* f = [[FfMultiple alloc] init];
                
				f.sentence = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 0)
                           ];
                
                
                f.choices = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 1)];
                
                // NSLog(@"qid %@" , f.qid);
                
				f.key = sqlite3_column_int(selectstmt, 2);
                
                    fgen = f;
                }
			
                if ([keysql isEqualToString:@"sqlwf"]) {
                    FfWF *f = [[FfWF alloc] init];
                    
                    f.sentence = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 0)
                                  ];
                    
                    
                    f.word = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 1)];
                    
                    // NSLog(@"qid %@" , f.qid);
                    
                    f.key =  [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 2)];
                
                    fgen = f;
                    
                }
                
                if ([keysql isEqualToString:@"sqlpv"]) {
                    FfPV *f = [[FfPV alloc] init];
                    
                    f.pv = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 0)
                                  ];
                    
                    
                    f.meaning = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 1)];
                    
                    
                    f.example = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 2)];
                    
                    fgen = f;
                    
                }
                
                
                if ([keysql isEqualToString:@"sqlwflist"]) {
                FfWFList *f = [[FfWFList alloc] init];
                    
                    f.word = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 0)
                            ];
                    
                    
                    f.list = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 1)];
                    
                    
            
                    
                    fgen = f;
                    
                }
                
				[listaTemp addObject:fgen];
            
                //		[f release];
			}
            
		}
        
        // NSLog(@"end loop");
        
		self.lista = listaTemp;
		//[listaTemp release];
        
        
		
    }
    
    sqlite3_close(database);

}

-(void)checkAndCopyDB
{
    BOOL success;
    
    NSFileManager * fileManager=[NSFileManager defaultManager];
    
    success=[fileManager fileExistsAtPath:pathDB];
   
    // NSLog(@"filedb %@"  , pathDB);
    
    if(success) return; // db gia' aggiornato all'ultima versione
    
    
    // se folder exists db da aggiornare
    // rimuovo folder
    if ([fileManager fileExistsAtPath:[NSString stringWithFormat:@"%@/Database" , self->pathLibrary]]) {
        
        [fileManager removeItemAtPath:[NSString stringWithFormat:@"%@/Database" , self->pathLibrary]  error:nil];
    }
    
    // create db directory
    
    [fileManager createDirectoryAtPath:[NSString stringWithFormat:@"%@/Database" , self->pathLibrary] withIntermediateDirectories:YES attributes:nil error:nil];
    
    NSString * databasepathfromapp=[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:dbName];
    
    //copy db file
    [fileManager copyItemAtPath:databasepathfromapp toPath:pathDB error:nil];
    
}

+(void)finalizeStatements {
	if(database)
		sqlite3_close(database);
}

-(void)dealloc {
	//[lista release];
	//[super dealloc];
}

@end
