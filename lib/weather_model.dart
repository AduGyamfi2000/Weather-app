class Weather {
  final String location;
  final String description;
  final double temperature;
  final double feelsLike;
  final int humidity;
  final int pressure;
  final double windSpeed;
  final double latitude;
  final double longitude;

  Weather({
    required this.location,
    required this.description,
    required this.temperature,
    required this.feelsLike,
    required this.humidity,
    required this.pressure,
    required this.windSpeed,
    required this.latitude,
    required this.longitude,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    final weatherData = json['weather'] as List<dynamic>;
    final mainData = json['main'] as Map<String, dynamic>;
    final windData = json['wind'] as Map<String, dynamic>;
    final coordData = json['coord'] as Map<String, dynamic>;

    return Weather(
      location: '${json['name']}, ${json['sys']['country']}',
      description: weatherData.first['description'] as String,
      temperature: (mainData['temp'] as num).toDouble(),
      feelsLike: (mainData['feels_like'] as num).toDouble(),
      humidity: mainData['humidity'] as int,
      pressure: mainData['pressure'] as int,
      windSpeed: (windData['speed'] as num).toDouble(),
      latitude: (coordData['lat'] as num).toDouble(),
      longitude: (coordData['lon'] as num).toDouble(),
    );
  }
}
