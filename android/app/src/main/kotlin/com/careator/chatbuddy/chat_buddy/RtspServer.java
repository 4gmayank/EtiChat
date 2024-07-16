package com.careator.chatbuddy.chat_buddy;

//import android.content.Context;
//
//import org.videolan.libvlc.LibVLC;
//import org.videolan.libvlc.MediaPlayer;
//import org.videolan.libvlc.media.Media;
//
//public class RtspServer {
//    private LibVLC libVLC;
//    private MediaPlayer mediaPlayer;
//
//    public RtspServer(Context context) {
//        libVLC = new LibVLC(context);
//        mediaPlayer = new MediaPlayer(libVLC);
//    }
//
//    public void startStream(String rtspUrl) {
//        Media media = new Media(libVLC, rtspUrl);
//        mediaPlayer.setMedia(media);
//        media.release();
//        mediaPlayer.play();
//    }
//
//    public void stopStream() {
//        mediaPlayer.stop();
//    }
//}
