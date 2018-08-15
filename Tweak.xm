@interface JBBulletinManager : NSObject
+(id)sharedInstance;
-(id)showBulletinWithTitle:(NSString *)title message:(NSString *)message bundleID:(NSString *)bundleID;
-(id)showBulletinWithTitle:(NSString *)title message:(NSString *)message bundleID:(NSString *)bundleID soundPath:(NSString *)soundPath;
-(id)showBulletinWithTitle:(NSString *)title message:(NSString *)message bundleID:(NSString *)bundleID soundID:(int)inSoundID;
-(id)showBulletinWithTitle:(NSString *)title message:(NSString *)message overrideBundleImage:(UIImage *)overridBundleImage;
-(id)showBulletinWithTitle:(NSString *)title message:(NSString *)message overrideBundleImage:(UIImage *)overridBundleImage soundPath:(NSString *)soundPath;
-(id)showBulletinWithTitle:(NSString *)title message:(NSString *)message overridBundleImage:(UIImage *)overridBundleImage soundID:(int)inSoundID;
-(id)showBulletinWithTitle:(NSString *)title message:(NSString *)message bundleID:(NSString *)bundleID hasSound:(BOOL)hasSound soundID:(int)soundID vibrateMode:(int)vibrate soundPath:(NSString *)soundPath attachmentImage:(UIImage
*)attachmentImage overrideBundleImage:(UIImage *)overrideBundleImage;
@end

@interface SBLockScreenManager : NSObject
+ (id)sharedInstance;
- (void)lockUIFromSource:(int)source withOptions:(id)options;
@end

%hook SBDashBoardViewController
- (void)viewDidAppear:(_Bool)arg1 {
  %orig;
    [[%c(SBLockScreenManager) sharedInstance] lockUIFromSource:1 withOptions:nil];
  dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC));
  dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
    [[objc_getClass("JBBulletinManager") sharedInstance] showBulletinWithTitle:@"Root Enabled" message:@"Root user has been enabled, operations as root can be dangerous." bundleID:@"com.apple.Preferences"];
  });
}
%end