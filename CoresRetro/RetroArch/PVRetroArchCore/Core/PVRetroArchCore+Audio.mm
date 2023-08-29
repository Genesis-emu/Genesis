//
//  PVRetroArchCore+Audio.m
//  PVRetroArch
//
//  Created by Joseph Mattiello on 11/1/18.
//  Copyright © 2021 Genesis. All rights reserved.
//

#import "PVRetroArchCore+Audio.h"

@implementation PVRetroArchCore (Audio)

- (NSTimeInterval)frameInterval {
	return isNTSC ? 60 : 50;
}

- (NSUInteger)channelCount {
	return 2;
}

- (double)audioSampleRate {
	return sampleRate;
}

@end
