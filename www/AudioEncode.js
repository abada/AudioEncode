/*var exec = require('cordova/exec');

 // This class converts audio at a file path to M4A format

 window.encodeAudio = function(originalSrc, successCallback, failCallback) {

 exec(successCallback, failCallback, "AudioEncode", "encodeAudio", [originalSrc]);
 };
 */

var exec = require('cordova/exec');
/**
 * Constructor
 */
function AudioEncode() {
}

AudioEncode.prototype.convert = function(originalSrc, successCallback, failCallback) {
	exec(successCallback, failCallback, "AudioEncode", "encodeAudio", [originalSrc]);
};
var audioEncode = new AudioEncode();
module.exports = audioEncode;