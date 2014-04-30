

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <Cordova/CDV.h>

@interface AudioEncode : CDVPlugin{
@private
    CDVInvokedUrlCommand* _command;
}

- (NSString *)genRandStringLength:(int)len;
- (void)encodeAudio:(CDVInvokedUrlCommand*)command;
@end
