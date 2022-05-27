import '../../domain/entities/forcast_entities.dart';

class ForcastModel extends Forcast {
  final CurrentForcastModel currentForcastModel;
  final List<HourlyForcastModel> hourlyForcastModel;
  final List<DailyForcastModel> dailyForcastModel;
  const ForcastModel({
    required String message,
    required String code,
    required this.currentForcastModel,
    required this.dailyForcastModel,
    required this.hourlyForcastModel,
  }) : super(
          currentForcast: currentForcastModel,
          hourlyForcast: hourlyForcastModel,
          dailyForcast: dailyForcastModel,
          message: message,
          code: code,
        );
  factory ForcastModel.fromJson(Map<String, dynamic> json) {
    List<HourlyForcastModel> hFData = [];
    List<DailyForcastModel> dFData = [];
    if (json['hourly'] != null) {
      for (int i = 0; i < 4; i++) {
        hFData.add(HourlyForcastModel.fromJson(json['hourly'][i]));
      }
    } else if (json['hourly'] == null) {
      hFData.add(const HourlyForcastModel(
        dateTime: 0,
        icon: '',
        temp: 0,
        windSpeed: 0,
      ));
    }
    if (json['daily'] != null) {
      for (int i = 0; i < 5; i++) {
        dFData.add(DailyForcastModel.fromJson(json['daily'][i]));
      }
    } else if (json['daily'] == null) {
      dFData.add(const DailyForcastModel(
        dateTime: 0,
        icon: '',
        mainTitle: '',
        mornTemp: 0,
        nightTemp: 0,
        sunrise: 0,
        sunset: 0,
        temp: 0,
      ));
    }
    return ForcastModel(
      currentForcastModel: json['current'] != null
          ? CurrentForcastModel.fromJson(json['current'])
          : const CurrentForcastModel(
              dateTime: 0,
              description: '',
              feelsLike: 0,
              humidity: 0,
              icon: '',
              mainTitle: '',
              pressure: 0,
              sunrise: 0,
              sunset: 0,
              temp: 0,
              uvi: 0,
              windSpeed: 0,
            ),
      hourlyForcastModel: hFData,
      dailyForcastModel: dFData,
      message: json['message'] ?? '',
      code: json['code'] ?? '200',
    );
  }
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {
      'current': currentForcastModel.toJson(),
      'daily': dailyForcastModel.map((v) => v.toJson()).toList(),
      'hourly': hourlyForcastModel.map((v) => v.toJson()).toList(),
    };
    return json;
  }
}

class CurrentForcastModel extends CurrentForcast {
  const CurrentForcastModel({
    required String icon,
    required int dateTime,
    required int windSpeed,
    required int temp,
    required int sunrise,
    required int sunset,
    required int feelsLike,
    required int pressure,
    required int humidity,
    required int uvi,
    required String mainTitle,
    required String description,
  }) : super(
          dateTime: dateTime,
          icon: icon,
          windSpeed: windSpeed,
          temp: temp,
          sunrise: sunrise,
          sunset: sunset,
          feelsLike: feelsLike,
          pressure: pressure,
          humidity: humidity,
          uvi: uvi,
          mainTitle: mainTitle,
          description: description,
        );

  factory CurrentForcastModel.fromJson(Map<String, dynamic> json) {
    return CurrentForcastModel(
      dateTime: json['dt'] ?? 0,
      sunrise: json['sunrise'] ?? 0,
      sunset: json['sunset'] ?? 0,
      temp: json['temp'] != null ? (json['temp'] as num).toInt() : 0,
      feelsLike:
          json['feels_like'] != null ? (json['feels_like'] as num).toInt() : 0,
      pressure:
          json['pressure'] != null ? (json['pressure'] as num).toInt() : 0,
      humidity: json['humidity'] ?? 0,
      uvi: json['uvi'] != null ? (json['uvi'] as num).toInt() : 0,
      windSpeed:
          json['wind_speed'] != null ? (json['wind_speed'] as num).toInt() : 0,
      description: json['weather'][0]['description'] ?? '',
      mainTitle: json['weather'][0]['main'] ?? '',
      icon: json['weather'][0]['icon'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {
      'dt': dateTime,
      'sunrise': sunrise,
      'sunset': sunset,
      'temp': temp,
      'feels_like': feelsLike,
      'pressure': pressure,
      'humidity': humidity,
      'uvi': uvi,
      'wind_speed': windSpeed,
      'weather': [
        {'main': mainTitle, 'description': description, 'icon': icon}
      ]
    };
    return json;
  }
}

class HourlyForcastModel extends HourlyForcast {
  const HourlyForcastModel({
    required int dateTime,
    required int temp,
    required int windSpeed,
    required String icon,
  }) : super(
          dateTime: dateTime,
          icon: icon,
          windSpeed: windSpeed,
          temp: temp,
        );

  factory HourlyForcastModel.fromJson(Map<String, dynamic> json) {
    return HourlyForcastModel(
      dateTime: json['dt'] ?? '',
      temp: json['temp'] != null ? (json['temp'] as num).toInt() : 0,
      windSpeed:
          json['wind_speed'] != null ? (json['wind_speed'] as num).toInt() : 0,
      icon: json['weather'][0]['icon'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {
      'dt': dateTime,
      'temp': temp,
      'wind_speed': windSpeed,
      'weather': [
        {'icon': icon}
      ]
    };
    return json;
  }
}

class DailyForcastModel extends DailyForcast {
  const DailyForcastModel({
    required int dateTime,
    required int sunrise,
    required int sunset,
    required int temp,
    required int nightTemp,
    required int mornTemp,
    required String mainTitle,
    required String icon,
  }) : super(
          dateTime: dateTime,
          sunrise: sunrise,
          sunset: sunset,
          temp: temp,
          nightTemp: nightTemp,
          mornTemp: mornTemp,
          mainTitle: mainTitle,
          icon: icon,
        );

  factory DailyForcastModel.fromJson(Map<String, dynamic> json) {
    return DailyForcastModel(
      dateTime: json['dt'] ?? 0,
      temp: json['temp']['day'] != null
          ? (json['temp']['day'] as num).toInt()
          : 0,
      nightTemp: json['temp']['min'] != null
          ? (json['temp']['min'] as num).toInt()
          : 0,
      mornTemp: json['temp']['max'] != null
          ? (json['temp']['max'] as num).toInt()
          : 0,
      mainTitle: json['weather'][0]['main'] ?? '',
      sunrise: json['sunrise'] ?? 0,
      sunset: json['sunset'] ?? 0,
      icon: json['weather'][0]['icon'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {
      'dt': dateTime,
      'sunrise': sunrise,
      'sunset': sunset,
      'temp': {
        'min': nightTemp,
        'max': mornTemp,
        'day': temp,
      },
      'weather': [
        {'main': mainTitle, 'icon': icon}
      ]
    };
    return json;
  }
}
