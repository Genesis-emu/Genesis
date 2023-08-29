//
//  PVDosBoxCore+Audio.m
//  PVDosBox
//
//  Created by Joseph Mattiello on 11/1/18.
//  Copyright © 2021 Genesis. All rights reserved.
//

#import "PVDosBoxCore+Audio.h"

@implementation PVDosBoxCore (Audio)

- (NSTimeInterval)frameInterval {
    return 60;
}

- (NSUInteger)channelCount {
    return 2;
}

- (double)audioSampleRate {
    return 44100;
}

@end
