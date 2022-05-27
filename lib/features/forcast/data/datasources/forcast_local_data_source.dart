import 'dart:convert';

import 'package:my_weather/core/error/exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/forcast_model.dart';

abstract class ForcastLocalDataSources {
  /// Gets the cached [ForcastModel] which was gotten the last time
  /// the user had an internet connection.
  ///
  /// Throws [NoLocalDataException] if no cached data is present.
  Future<ForcastModel> getLastForcast();
  Future<void> cacheForcast(ForcastModel forcastToCache);
}

const String cachedForcastKey = 'CACHED_FORCAST';

class ForcastLocalDataSourcesImpl implements ForcastLocalDataSources {
  final SharedPreferences sharedPreferences;
  ForcastLocalDataSourcesImpl(this.sharedPreferences);
  @override
  Future<void> cacheForcast(ForcastModel forcastToCache) {
    return sharedPreferences.setString(
      cachedForcastKey,
      json.encode(
        forcastToCache.toJson(),
      ),
    );
  }

  @override
  Future<ForcastModel> getLastForcast() {
    final jsonString = sharedPreferences.getString(cachedForcastKey);
    if (jsonString != null) {
      return Future.value(ForcastModel.fromJson(json.decode(jsonString)));
    } else {
      throw CacheException();
    }
  }
}
