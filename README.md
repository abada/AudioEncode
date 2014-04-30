
## About this Plugin ##

This plugin lets you easily convert WAV audio into M4A audio. It is useful when using Phonegap's audio capture or media recording functionality. Uploading WAV files on via cellular connections is not advised. M4A encoded files are 1/4 to 1/10 the size.

## Using the Plugin ##

The plugin creates a function at window.encodeAudio(originalSrc, success, fail) method.
 * originalSrc: (required) This is a string path to the local file to encode. This is typically the fullPath property of the entry passed to the success of a fileSystem.root.getFile call
 * success: (required) This function is called when the encoding has completed successfully. It will be called with the new m4ASource 
 * fail: (required) This function is called on encode failure and will be passed a statusCode.

Example:
  //file_path wav file
  
  
  window.abadaencode(file_path, function(echoValue) {
        
        console.log(echoValue);
    });

See demo code for more details

## Adding the Plugin to your project ##

 IOS Only
 
using cordova CLI
 
cordova plugin add https://github.com/abada/AudioEncode.git