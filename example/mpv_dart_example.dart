import 'package:mpv_dart/mpv_dart.dart';

const mpvSocket = '/tmp/dart-mpv.sock';

void main() async {
  try {
    MPVPlayer mpvPlayer = MPVPlayer(
      audioOnly: true,
      debug: true,
      verbose: true,
      mpvArgs: [
        "--ytdl-raw-options-set=format=140,http-chunk-size=300000",
        "--script-opts=ytdl_hook-ytdl_path=yt-dlp",
      ],
    );
    await mpvPlayer.start();
    await mpvPlayer.load("ytdl://www.youtube.com/watch?v=Fp8msa5uYsc");

    await mpvPlayer.play();

    mpvPlayer.eventstream.listen((event) {
      if (event.name == MPVEvents.started) {
        print("MPV STARTED PLAYING");
      }
      if (event.name == MPVEvents.quit) {
        print("MPV STARTED QUIT");
      }
      if (event.name == MPVEvents.crashed) {
        print("MPV STARTED CRASHED");
      }
      if (event.name == MPVEvents.status) {
        print("MPV STATUS CHANGE: ${event.data}");
      }
      if (event.name == MPVEvents.timeposition) {
        print("MPV TIMEPOSITION ${event.data}");
      }
    });
  } catch (e, stackTrace) {
    print(e);
    print(stackTrace);
  }
}
