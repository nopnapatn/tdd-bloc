import 'package:shared_preferences/shared_preferences.dart';
import 'package:tdd_bloc/core/errors/exceptions.dart';

const kFirstTimerKey = 'first_timer';

abstract class OnBoardingLocalDataSource {
  const OnBoardingLocalDataSource();

  Future<void> cacheFirstTimer();
  Future<bool> checkIfUserIsFirstTimer();
}

class OnBaordingLocalDataSourceImpl extends OnBoardingLocalDataSource {
  const OnBaordingLocalDataSourceImpl(
    this._prefs,
  );

  final SharedPreferences _prefs;

  @override
  Future<void> cacheFirstTimer() async {
    try {
      await _prefs.setBool(kFirstTimerKey, false);
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }

  @override
  Future<bool> checkIfUserIsFirstTimer() async {
    try {
      return _prefs.getBool(kFirstTimerKey) ?? true;
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }
}
