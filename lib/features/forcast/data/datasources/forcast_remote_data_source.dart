
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../../core/error/exception.dart';
import '../../../../core/network/location.dart';
import '../models/forcast_model.dart';

abstract class ForcastRemoteDataSources {
  /// Calls the https://api.openweathermap.org/data/2.5/onecall?lat=33.44&lon=-94.04&exclude=,minutely&appid=6ff048a453fc48c976b7351aac7e6b32&units=metric endpoint
  /// Throws a [ServerException] for all error codes.
  Future<ForcastModel> getForcastByCurrentLocation();

  /// Calls the https://api.openweathermap.org/data/2.5/forecast?q=london&appid=6ff048a453fc48c976b7351aac7e6b32&units=metric endpoint
  /// Throws a [ServerException] for all error codes.
  Future<ForcastModel> getForcastByCityName(String cityName);
}

class ForcastRemoteDataSourcesImpl implements ForcastRemoteDataSources {
  final http.Client client;
  final GeolocatorPlatform geolocator;
  ForcastRemoteDataSourcesImpl({
    required this.client,
    required this.geolocator,
  });
  @override
  Future<ForcastModel> getForcastByCurrentLocation() async {
    Location location = Location(geolocator);
    await location.getCurrentLocation();
    final response = await client.get(
      Uri.parse('https://api.openweathermap.org/data/2.5/onecall?lat=${location.latitude}&lon=${location.longitude}&exclude=,minutely&appid=6ff048a453fc48c976b7351aac7e6b32&units=metric'),
    );
    if(response.statusCode == 200) {
      return ForcastModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<ForcastModel> getForcastByCityName(String cityName) async {
    final cooResponse = await client .get(
      Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=6ff048a453fc48c976b7351aac7e6b32&units=metric')
    );
    // if(cooResponse.statusCode != 200) {
    //   throw ServerException();
    // }
    final response = await client.get(
      Uri.parse('https://api.openweathermap.org/data/2.5/onecall?lat=${json.decode(cooResponse.body)['coord'] != null ? json.decode(cooResponse.body)['coord']['lat'] : 'r'}&lon=${json.decode(cooResponse.body)['coord'] != null ? json.decode(cooResponse.body)['coord']['lon'] : 'r'}&exclude=,minutely&appid=6ff048a453fc48c976b7351aac7e6b32&units=metric'),
    );
    if(response.statusCode == 200 || response.statusCode == 400) {
      return ForcastModel.fromJson(json.decode(response.body));
    } 
     else {
      throw ServerException();
    }
  }
}
