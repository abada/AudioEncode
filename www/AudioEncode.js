window.abadaencode = function(file_path,callback) {
        cordova.exec(callback, function(err) {
            callback(err);
        }, "AudioEncode", "encodeAudio", [file_path]);
    };