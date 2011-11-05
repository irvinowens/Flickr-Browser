//
//  PBAuthor.h
//  PhotoBrowser
//
//  Created by Irvin Owens on 11/4/11.
//  Copyright (c) 2011 Owensperformance. All rights reserved.
//

#import "PBModel.h"
#import "PBConsts.h"

/**
 * The PBAuthor object encapsulates metadata about the author of a
 * given photo
 */

@interface PBAuthor : PBModel{
    NSString *name;
    NSString *profileUri;
    NSString *buddyIcon;
    NSString *profilePhoto;
}

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *profileUri;
@property (nonatomic, strong) NSString *buddyIcon;
@property (nonatomic, strong) NSString *profilePhoto;

@end
