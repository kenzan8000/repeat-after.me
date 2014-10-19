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
