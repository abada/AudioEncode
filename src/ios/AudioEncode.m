
#import "AudioEncode.h"
#import <Cordova/CDV.h>

@implementation AudioEncode




- (void)encodeAudio:(CDVInvokedUrlCommand*)command
{
    self->_command = command;
    
    NSString* audioPath = [command.arguments objectAtIndex:0];
    
    
    NSString *rand=[self genRandStringLength:10];
    
    
    
    if (audioPath == nil && [audioPath length] <= 0) {
        // [self performSelectorOnMainThread:@selector(doFailCallback:) withObject:@"wav file required !" waitUntilDone:NO];
    }
    
    NSURL* audioURL = [NSURL fileURLWithPath:audioPath];
    NSLog(@"   audioURL : %@", audioURL);
    
    AVURLAsset* audioAsset = [[AVURLAsset alloc] initWithURL:audioURL options:nil];
    AVAssetExportSession* exportSession = [[AVAssetExportSession alloc] initWithAsset:audioAsset presetName:AVAssetExportPresetAppleM4A];
    NSURL* exportURL = [NSURL fileURLWithPath:[[audioPath componentsSeparatedByString:@".wav"] objectAtIndex:0]];
    
    NSString *new_name = [rand stringByAppendingString:@".m4a"];
    
    NSURL* destinationURL = [exportURL    URLByAppendingPathExtension:new_name];
    
    /* NSString *exportURL_string = [exportURL absoluteString];
     NSString *test_utl = [exportURL_string stringByAppendingString:@"test"];
     NSURL* dest_new = [NSURL fileURLWithPath:test_utl];
     NSURL* destinationURL = [dest_new    URLByAppendingPathExtension:@"m4a"];
     NSLog(@"   destinationURL : %@", destinationURL);*/
    
    
    exportSession.outputURL = destinationURL;
	exportSession.outputFileType = AVFileTypeAppleM4A;
    
    [exportSession exportAsynchronouslyWithCompletionHandler:^{
        if (AVAssetExportSessionStatusCompleted == exportSession.status) {
            NSLog(@"AVAssetExportSessionStatusCompleted");
            //doSuccessCallback
            [self performSelectorOnMainThread:@selector(doSuccessCallback:) withObject:[exportSession.outputURL path] waitUntilDone:NO];
        } else if (AVAssetExportSessionStatusFailed == exportSession.status) {
            // a failure may happen because of an event out of your control
            // for example, an interruption like a phone call comming in
            // make sure and handle this case appropriately
            NSLog(@"AVAssetExportSessionStatusFailed");
            NSLog(@"   error: %@", exportSession.error);
            
            [self performSelectorOnMainThread:@selector(doFailCallback:) withObject:[NSString stringWithFormat:@"%i", exportSession.status] waitUntilDone:NO];
            
        } else {
            NSLog(@"Export Session Status: %d", exportSession.status);
        }
        
        
        NSFileManager *fileMgr = [NSFileManager defaultManager];
        NSError *error = noErr;
        if ([fileMgr removeItemAtPath:audioPath error:&error] != YES) {
            NSLog(@"Unable to delete file: %@", [error localizedDescription]);
            [self performSelectorOnMainThread:@selector(doFailCallback:) withObject:[error localizedDescription] waitUntilDone:NO];
        }
        
    }];
    
    
    
}

-(void) doSuccessCallback:(NSString*)path {
    NSLog(@"doing success callback");
    
    CDVPluginResult* pluginResult = nil;
    
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:path];
    [self.commandDelegate sendPluginResult:pluginResult callbackId: self->_command.callbackId];
}

-(void) doFailCallback:(NSString*)status {
    NSLog(@"doing fail callback");
    
    CDVPluginResult* pluginResult = nil;
    
    
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:status];
    [self.commandDelegate sendPluginResult:pluginResult callbackId: self->_command.callbackId];
    
}


// Generates alpha-numeric-random string
- (NSString *)genRandStringLength:(int)len {
    static NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];
    for (int i=0; i<len; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random() % [letters length]]];
    }
    return randomString;
}

@end
