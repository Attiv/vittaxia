import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// 轻量系统音效反馈，避免引入额外音频资源和依赖。
class GameAudio {
  GameAudio._();

  static const _enabledKey = 'settings.sound_enabled';
  static bool _enabled = true;
  static bool _initialized = false;
  static DateTime? _lastTapAt;
  static const _tapIntervalMs = 60;
  static DateTime? _lastActionAt;
  static const _actionIntervalMs = 45;

  static bool get enabled => _enabled;

  static Future<void> ensureInitialized() async {
    if (_initialized) return;
    final prefs = await SharedPreferences.getInstance();
    _enabled = prefs.getBool(_enabledKey) ?? true;
    _initialized = true;
  }

  static Future<void> setEnabled(bool value) async {
    _enabled = value;
    _initialized = true;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_enabledKey, value);
  }

  static void tap() {
    if (!_enabled) return;
    final now = DateTime.now();
    if (_lastTapAt != null &&
        now.difference(_lastTapAt!).inMilliseconds < _tapIntervalMs) {
      return;
    }
    _lastTapAt = now;
    SystemSound.play(SystemSoundType.click);
  }

  static void success() {
    if (!_enabled) return;
    SystemSound.play(SystemSoundType.click);
  }

  static void warning() {
    if (!_enabled) return;
    SystemSound.play(SystemSoundType.alert);
  }

  static void battleHit() {
    if (!_allowActionSound()) return;
    SystemSound.play(SystemSoundType.click);
  }

  static void battleCrit() {
    if (!_allowActionSound()) return;
    SystemSound.play(SystemSoundType.alert);
  }

  static void battleDodge() {
    if (!_allowActionSound()) return;
    SystemSound.play(SystemSoundType.click);
  }

  static void battleWin() {
    if (!_enabled) return;
    SystemSound.play(SystemSoundType.click);
  }

  static void battleLose() {
    if (!_enabled) return;
    SystemSound.play(SystemSoundType.alert);
  }

  static void rareDrop() {
    if (!_enabled) return;
    SystemSound.play(SystemSoundType.alert);
  }

  static bool _allowActionSound() {
    if (!_enabled) return false;
    final now = DateTime.now();
    if (_lastActionAt != null &&
        now.difference(_lastActionAt!).inMilliseconds < _actionIntervalMs) {
      return false;
    }
    _lastActionAt = now;
    return true;
  }
}
