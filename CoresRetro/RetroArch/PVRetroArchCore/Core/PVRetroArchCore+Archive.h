#import <PVRetroArch/PVRetroArchCore.h>

NS_ASSUME_NONNULL_BEGIN
@interface PVRetroArchCore (Archive)
- (NSString *)checkROM_PC98:(NSString*)romFile;
- (NSString *)checkROM:(NSString*)romFile;
- (NSString *)getExtractedRomDirectory;

- (BOOL)extractLZH:(NSString *)atPath toDestination:(NSString *)toDestination overwrite:(BOOL)overwrite;
- (BOOL)extractZIP:(NSString *)atPath toDestination:(NSString *)toDestination overwrite:(BOOL)overwrite;
- (BOOL)extractRAR:(NSString *)atPath toDestination:(NSString *)toDestination overwrite:(BOOL)overwrite;

- (BOOL)extractArchive:(NSString *)atPath toDestination:(NSString *)toDestination overwrite:(BOOL)overwrite;
@end
NS_ASSUME_NONNULL_END
