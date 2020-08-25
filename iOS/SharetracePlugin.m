//
//  SharetracePlugin.m
//  HBuilder
//
//  Created by Sharetrace on 2020/8/24.
//  Copyright © 2020 Sharetrace. All rights reserved.
//

#import "SharetracePlugin.h"
#import <SharetraceSDK/SharetraceSDK.h>

@implementation SharetracePlugin

static NSString * const key_code = @"code";
static NSString * const key_msg = @"msg";
static NSString * const key_paramsData = @"paramsData";
static NSString * const key_resumePage = @"resumePage";

-(void)getInstallTrace:(PGMethod*)command {
    
    NSString* cbId = [command.arguments objectAtIndex:0];
    
    [Sharetrace getInstallTrace:^(AppData * _Nullable appData) {
        if (appData == nil) {
            NSDictionary* dict = [self parseToResultDict:-1 :@"Extract data fail." :@"" :@""];
            [self callback:cbId :dict];
            return;
        }
        
        NSDictionary* dict = [self parseToResultDict:200 :@"Success" :appData.paramsData :appData.resumePage];
        [self callback:cbId :dict];
        
    } :^(NSInteger code, NSString * _Nonnull msg) {
        NSDictionary* dict = [self parseToResultDict:code :msg :@"" :@""];
        [self callback:cbId :dict];
    }];
}

- (void) callback:(NSString*) cbId :(NSDictionary*) ret {
    PDRPluginResult *result = [PDRPluginResult resultWithStatus:PDRCommandStatusOK messageAsDictionary:ret];
    [self toCallback:cbId withReslut:[result toJSONString]];
}

- (NSDictionary*)parseToResultDict:(NSInteger)code :(NSString*)msg :(NSString*)paramsData :(NSString*)resumePage {
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    dict[key_code] = [NSNumber numberWithInteger:code];
    dict[key_msg] = msg;
    dict[key_paramsData] = paramsData;
    dict[key_resumePage] = resumePage;
    return dict;
}

@end
