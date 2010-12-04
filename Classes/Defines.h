/*
 *  Defines.h
 *  ASIHTTPRequestDemo
 *
 *  Created by okonomi on 10/12/04.
 *  Copyright 2010 __MyCompanyName__. All rights reserved.
 *
 */

// デバッグ用マクロ
#ifdef DEBUG
#  define LOG(...) NSLog(__VA_ARGS__)
#  define LOG_CURRENT_METHOD NSLog(@"%s", __FUNCTION__);
#else
#  define LOG(...) ;
#  define LOG_CURRENT_METHOD ;
#endif
