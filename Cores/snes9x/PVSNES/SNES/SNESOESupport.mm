/*
 Copyright (c) 2009, OpenEmu Team
 
 
 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions are met:
     * Redistributions of source code must retain the above copyright
       notice, this list of conditions and the following disclaimer.
     * Redistributions in binary form must reproduce the above copyright
       notice, this list of conditions and the following disclaimer in the
       documentation and/or other materials provided with the distribution.
     * Neither the name of the OpenEmu Team nor the
       names of its contributors may be used to endorse or promote products
       derived from this software without specific prior written permission.
 
 THIS SOFTWARE IS PROVIDED BY OpenEmu Team ''AS IS'' AND ANY
 EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 DISCLAIMED. IN NO EVENT SHALL OpenEmu Team BE LIABLE FOR ANY
 DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#include <Foundation/Foundation.h>
#import <PVLogging/PVLogging.h>
#include "snes9x.h"
#include "memmap.h"
#include "gfx.h"
#include "display.h"
#include "ppu.h"
#include "conffile.h"
#include "apu.h"
#include "controls.h"
#include "movie.h"
#include "screenshot.h"

const char *S9xBasename (const char *filename)
{
    //DLOG(@"basename %s",filename);
    return NULL;
}

void _splitpath(const char *path, char *drive, char *dir, char *fname, char *ext)
{
    NSString *nsPath = [NSString stringWithUTF8String:path];
    
    drive[0] = '\0';
    
    NSString *extension = [nsPath pathExtension];
    NSArray *components = [nsPath pathComponents];
    NSArray *dirComponents = [[nsPath pathComponents] subarrayWithRange:NSMakeRange(0, [components count] - 1)];
    NSString *fileName = [[nsPath lastPathComponent] stringByDeletingPathExtension];
    NSString *directory = [NSString pathWithComponents:dirComponents];
    
    strcpy(dir, [directory UTF8String]);
    strcpy(fname, [fileName UTF8String]);
    strcpy(ext, [extension UTF8String]);
}

void _makepath(char *path, const char *drive, const char *dir, const char *fname, const char *ext)
{
#pragma unused (drive)
    
    NSString *directory = [NSString stringWithUTF8String:dir];
    NSString *fileName = [NSString stringWithUTF8String:fname];
    NSString *extension = [NSString stringWithUTF8String:ext];
    
    fileName = [fileName stringByAppendingPathExtension:extension];
    
    NSString *fullPath = [directory stringByAppendingPathComponent:fileName];
    
    strcpy(path, [fullPath UTF8String]);
}

void S9xExit ()
{
    DLOG(@"exit");
}

void S9xHandlePortCommand(s9xcommand_t cmd, int16 data1, int16 data2)
{
    
    DLOG(@"Port command");
}


void S9xGenerateSound ()
{
    DLOG(@"Gen sound");
}


void S9xSetPalette ()
{
    //DLOG(@"Set pallette");
}
const char * S9xGetSPC7110Directory(void)
{
    DLOG(@"7110 dir");
    return NULL;
}
const char *S9xGetDirectory (enum s9x_getdirtype dirtype)
{
    NSString *biosPath = [[[[NSHomeDirectory() stringByAppendingPathComponent:@"Library"]
                                  stringByAppendingPathComponent:@"Application Support"]
                                 stringByAppendingPathComponent:@"OpenEmu"]
                                stringByAppendingPathComponent:@"BIOS"];
    
    DLOG(@"Get dir");
	switch (dirtype)
	{
        case SRAM_DIR:			return [NSHomeDirectory() UTF8String];	break;
		case BIOS_DIR:			return [biosPath UTF8String];	break;
		default:				return NULL;	break;
	}
}

const char *S9xChooseFilename (bool8 read_only)
{
    DLOG(@"Choose fname");
    return NULL;
}
void S9xLoadSDD1Data ()
{
    DLOG(@"Load SDD1");
}

void S9xAutoSaveSRAM (void)
{
    DLOG(@"Auto save SRAM");
}

void S9xToggleSoundChannel (int channel)
{
    DLOG(@"Toggle channel");
}

extern "C" char *osd_GetPackDir()
{
    DLOG(@"Get pack dir");
    return NULL;
}

void S9xSyncSpeed ()
{
    IPPU.RenderThisFrame = true;
    ///DLOG(@"Sync");
}

const char *S9xStringInput(const char *message)
{
    DLOG(@"String input");
    return NULL;
}

bool8 S9xInitUpdate (void)
{
    //DLOG(@"Init update");
    return true;
}

unsigned char S9xContinueUpdate(int width, int height)
{
    return true;
}


const char *S9xGetFilename (const char *extension, enum s9x_getdirtype dirtype)
{
    DLOG(@"Get filename");
    return NULL;
}

void SetInfoDlgColor(unsigned char, unsigned char, unsigned char)
{
    DLOG(@"Set info dlg");
}
const char *S9xGetFilenameInc (const char *, enum s9x_getdirtype)
{
    DLOG(@"Get filenameinc");
    return NULL;
}


bool8 S9xDoScreenshot(int width, int height)
{
    DLOG(@"Do screenshot");
    return false;
}

bool8 S9xOpenSnapshotFile (const char *base, bool8 read_only, STREAM *file)
{
    if((*file = OPEN_STREAM(base, (read_only ? "r" : "w"))) != 0)
        return true;
    
    return false;
}

void S9xCloseSnapshotFile (STREAM file)
{
    CLOSE_STREAM(file);
}

bool S9xPollButton(uint32 id, bool *pressed)
{
    DLOG(@"Poll button");
    return true;
}
bool S9xPollPointer(uint32 id, int16 *x, int16 *y)
{
    DLOG(@"Poll Pointer");
    return true;
}

bool S9xPollAxis(uint32 id, int16 *value)
{
    DLOG(@"Poll axis");
    return true;
}

void S9xMessage (int type, int number, const char *message)
{
    if( type == S9X_ERROR ) {
            // TODO: Set a variable for last error message so we can return an NSError to save/load
        ELOG(@"%s", message);
    } else {
        DLOG(@"%s", message);
    }
}

const char *S9xChooseMovieFilename(bool8 read_only)
{
    DLOG(@"Movie filename");
    return NULL;
}

void S9xExtraUsage()
{
    DLOG(@"Extra usage");
}

void S9xParseArg(char**, int&, int)
{
    
}

void S9xParsePortConfig(ConfigFile&, int)
{
    
}

bool8 S9xDeinitUpdate(int width, int height)
{
    return true;
}
