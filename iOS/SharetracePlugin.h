//
//  SharetracePlugin.h
//  HBuilder
//
//  Created by Sharetrace on 2020/8/24.
//  Copyright © 2020 Sharetrace. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "PGPlugin.h"
#include "PGMethod.h"

@interface SharetracePlugin : PGPlugin

-(void)getInstallTrace:(PGMethod*)command;

@end

