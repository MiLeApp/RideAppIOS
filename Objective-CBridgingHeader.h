//
//  Objective-CBridgingHeader.h
//  RideApp
//
//  Created by Yan Futerman on 16/06/2017.
//  Copyright © 2017 Yan Futerman. All rights reserved.
//

#ifndef Objective_CBridgingHeader_h
#define Objective_CBridgingHeader_h

#import <MessageUI/MessageUI.h>

#ifdef USES_IASK_STATIC_LIBRARY
#import "InAppSettingsKit/IASKSettingsReader.h"
#else
#import "IASKSettingsReader.h"
#endif

//#import "CustomViewCell.h"

#if USES_IASK_STATIC_LIBRARY
#import "InAppSettingsKit/IASKAppSettingsViewController.h"
#else
#import "IASKAppSettingsViewController.h"
#endif


#endif /* Objective_CBridgingHeader_h */
