import 'package:audioplayers/audioplayers.dart';

class SoundEffects {
  static final AudioPlayer _player = AudioPlayer();

  /// Play the "correct" sound
  static Future<void> soundOne() async {
    await _stopCurrentSound(); // Stop any currently playing sound
    await _player.play(AssetSource('sounds/correct.mp3'));
  }

  /// Play the "wrong" sound
  static Future<void> soundTwo() async {
    await _stopCurrentSound(); // Stop any currently playing sound
    await _player.play(AssetSource('sounds/wrong.mp3'));
  }

  /// Stop the currently playing sound
  static Future<void> _stopCurrentSound() async {
    if (_player.state == PlayerState.playing) {
      await _player.stop(); // Stop the current sound
    }
  }

  /// Dispose the player when no longer needed (e.g., on app exit)
  static void dispose() {
    _player.dispose();
  }
}