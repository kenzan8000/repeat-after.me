var audio_context = null;
var recorder = null;

var NOW_IS_FREE = 0;
var NOW_IS_RECORDING = 1;
var NOW_IS_CONVERTING_MP3 = 2;
var recordingStatus = NOW_IS_FREE;
var NOW_IS_POSTING = 1;

window.onload = function () {
    $("#post_button").addClass("disable");

    // initialize recoding
    try {
        window.AudioContext = window.AudioContext || window.webkitAudioContext;
        navigator.getUserMedia = (navigator.getUserMedia || navigator.webkitGetUserMedia || navigator.mozGetUserMedia || navigator.msGetUserMedia);
        window.URL = window.URL || window.webkitURL;
        audio_context = new AudioContext;
    }
    catch (e) { }

    navigator.getUserMedia({audio: true, video: false},
                           function(stream) {
                               var input = audio_context.createMediaStreamSource(stream);
                               recorder = new Recorder(input);
                           },
                           function(e) { });
};

var toggleRecording = function() {
    if (recorder == null || recordingStatus == NOW_IS_CONVERTING_MP3) { return; }

    // start recording
    var startRecording = function() {
        recorder && recorder.record();
    };

    // stop recording
    var stopRecording = function() {
        recorder && recorder.stop();
        recorder && recorder.exportWAV(function(blob) { });
        recorder.clear();
    };

    if (recordingStatus == false) {
        startRecording();
        recordingStatus = NOW_IS_RECORDING;
        $("#record_button").removeClass("record-start-button").removeClass("record-indicator-button").addClass("record-stop-button");
        $("#record_icon").removeClass("fa-circle-o-notch").removeClass("fa-spin").removeClass("fa-microphone").addClass("fa-stop");
        $("#record_icon").text(" 停止");
    }
    else {
        stopRecording();
        recordingStatus = NOW_IS_CONVERTING_MP3;
        $("#record_button").removeClass("record-start-button").removeClass("record-stop-button").addClass("record-indicator-button");
        $("#record_icon").removeClass("fa-microphone").removeClass("fa-stop").addClass("fa-circle-o-notch").addClass("fa-spin");
        $("#record_icon").text("");
    }
};

// post MP3
var postMp3 = function() {
    var postButton = $("#post_button");
    // can post or not
    if (postButton.hasClass("disable")) {
        return;
    }
    // post now
    if (postButton.hasClass("record-indicator-button")) {
        return;
    }

    function dataURItoBlob(dataURI) {
        // convert base64/URLEncoded data component to raw binary data held in a string
        var byteString;
        if (dataURI.split(',')[0].indexOf('base64') >= 0) {
            byteString = atob(dataURI.split(',')[1]);
        }
        else {
            byteString = unescape(dataURI.split(',')[1]);
        }

        // separate out the mime component
        var mimeString = dataURI.split(',')[0].split(':')[1].split(';')[0]

        // write the bytes of the string to a typed array
        var ia = new Uint8Array(byteString.length);
        for (var i = 0; i < byteString.length; i++) {
            ia[i] = byteString.charCodeAt(i);
        }

        return new Blob([ia], {type:mimeString});
    }
    var file = dataURItoBlob($("#recorded_voice_player").attr("src"));
    if (file.size > 1024 * 1024) { // over 1MB
        alert("録音した音声ファイルのサイズが1MBを超えました。録音時間を1分以内に抑えてください");
        return;
    }

    // design
    postButton.removeClass("post-button").addClass("record-indicator-button");
    $("#post_icon").removeClass("fa-check").addClass("fa-circle-o-notch").addClass("fa-spin").addClass("fa-microphone");
    $("#post_icon").text("");

    // post
    var request = new FormData();
    request.append("file", file);
    $.ajax({
         url: location.href,
        type: "POST",
        data: request,
       cache: false,
 processData: false,
 contentType: false,
     success: function(data, status, xhr) {
        var json = $.parseJSON(data);
        window.location = json["redirect_url"];
     },
       error: function(xhr, exception) {
        var json = $.parseJSON(data);

        postButton.removeClass("record-indicator-button").addClass("post-button");
        $("#post_icon").removeClass("fa-circle-o-notch").removeClass("fa-spin").removeClass("fa-microphone").addClass("fa-check");
        $("#post_icon").text(" 投稿");

        alert("投稿に失敗しました");
       }
    });

};

// play Text to Speech
var playTTS = function(url) {
    $("#tts_player").remove();
    var ttsPlayer = $("<iframe><iframe/>");
    ttsPlayer.attr("src", url);
    ttsPlayer.css("width","0").css("height","0").css("left","-999").css("position","absolute");
    ttsPlayer.frameborder = "0";
    ttsPlayer.marginheight = "0";
    ttsPlayer.scrolling = "no";
    ttsPlayer.attr("id", "tts_player");
    $("body").append(ttsPlayer);
};



(function(window) {
    var WORKER_PATH = '/js/recorder_worker.js';
    var encoderWorker = new Worker('/js/mp3_worker.js');

    var Recorder = function(source, cfg) {
        var config = cfg || {};
        var bufferLen = config.bufferLen || 4096;
        this.context = source.context;
        this.node = (this.context.createScriptProcessor || this.context.createJavaScriptNode).call(this.context, bufferLen, 2, 2);
        var worker = new Worker(config.workerPath || WORKER_PATH);
        worker.postMessage({command: 'init', config: {sampleRate: this.context.sampleRate}});
        var recording = false;
        var currCallback;

        this.node.onaudioprocess = function(e) {
            if (!recording) { return; }
            worker.postMessage({ command: 'record', buffer: [e.inputBuffer.getChannelData(0)]});
        }

        this.configure = function(cfg){
            for (var prop in cfg) {
                if (cfg.hasOwnProperty(prop)) { config[prop] = cfg[prop]; }
            }
        }

        this.record = function(){
            recording = true;
        }

        this.stop = function(){
            recording = false;
        }

        this.clear = function(){
            worker.postMessage({ command: 'clear' });
        }

        this.getBuffer = function(cb) {
            currCallback = cb || config.callback;
            worker.postMessage({ command: 'getBuffer' })
        }

        this.exportWAV = function(cb, type){
            currCallback = cb || config.callback;
            type = type || config.type || 'audio/wav';
            if (!currCallback) throw new Error('Callback not set');
            worker.postMessage({
                command: 'exportWAV',
                type: type
            });
        }

        //Mp3 conversion
        worker.onmessage = function(e) {
            var blob = e.data;
            var arrayBuffer;
            var fileReader = new FileReader();

            fileReader.onload = function() {
                //Converting to Mp3
                $("#post_button").addClass("disable");

                arrayBuffer = this.result;
                var buffer = new Uint8Array(arrayBuffer),
                data = parseWav(buffer);

                encoderWorker.postMessage({cmd: 'init', config:{mode : 3, channels:1, samplerate: data.sampleRate, bitrate: data.bitsPerSample}});
                encoderWorker.postMessage({cmd: 'encode', buf: Uint8ArrayToFloat32Array(data.samples)});
                encoderWorker.postMessage({cmd: 'finish'});
                encoderWorker.onmessage = function(e) {
                    if (e.data.cmd == 'data') {
                        //Done converting to Mp3
                        var player = $("#recorded_voice_player");
                        src = 'data:audio/mp3;base64,'+encode64(e.data.buf);
                        player.attr("src", src);
                        $("#post_button").removeClass("disable");
                        $("#record_button").removeClass("record-stop-button").removeClass("record-indicator-button").addClass("record-start-button");
                        $("#record_icon").removeClass("fa-circle-o-notch").removeClass("fa-spin").removeClass("fa-stop").addClass("fa-microphone");
                        $("#record_icon").text(" 録音");
                        recordingStatus = NOW_IS_FREE;
                    }
                };
            };

            fileReader.readAsArrayBuffer(blob);
            currCallback(blob);
        };

        function encode64(buffer) {
            var binary = '';
            var bytes = new Uint8Array(buffer);
            var len = bytes.byteLength / 2;
            for (var i = 0; i < len; i++) {
                binary += String.fromCharCode( bytes[ i ] );
            }
            return window.btoa( binary );
        }

        function parseWav(wav) {
            function readInt(i, bytes) {
                var ret = 0;
                var shft = 0;
                while (bytes) {
                    ret += wav[i] << shft;
                    shft += 8;
                    i++;
                    bytes--;
                }
                return ret;
            }
            if (readInt(20, 2) != 1) { throw 'Invalid compression code, not PCM'; }
            if (readInt(22, 2) != 1) { throw 'Invalid number of channels, not 1'; }
            return {sampleRate: readInt(24, 4), bitsPerSample: readInt(34, 2), samples: wav.subarray(44)};
        }

        function Uint8ArrayToFloat32Array(u8a) {
            var f32Buffer = new Float32Array(u8a.length);
            for (var i = 0; i < u8a.length; i++) {
                var value = u8a[i<<1] + (u8a[(i<<1)+1]<<8);
                if (value >= 0x8000) { value |= ~0x7FFF; }
                f32Buffer[i] = value / 0x8000;
            }
            return f32Buffer;
        }

        source.connect(this.node);
        this.node.connect(this.context.destination);
    };

    window.Recorder = Recorder;
})(window);
