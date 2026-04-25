import 'package:flutter/material.dart';
import 'weather_model.dart';
import 'weather_service.dart';

void main() {
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Global Weather',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const WeatherHomePage(),
    );
  }
}

class WeatherHomePage extends StatefulWidget {
  const WeatherHomePage({super.key});

  @override
  State<WeatherHomePage> createState() => _WeatherHomePageState();
}

class _WeatherHomePageState extends State<WeatherHomePage> {
  final TextEditingController _cityController = TextEditingController();
  final WeatherService _weatherService = WeatherService();
  Weather? _weather;
  String? _error;
  bool _isLoading = false;
  final List<String> _favoriteCities = [
    'New York',
    'London',
    'Tokyo',
    'Sydney',
    'Cairo',
    'São Paulo',
    'Moscow',
  ];

  Future<void> _searchWeather(String city) async {
    if (city.isEmpty) {
      setState(() {
        _error = 'Enter a city name to search global weather.';
        _weather = null;
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _error = null;
      _weather = null;
    });

    try {
      final weather = await _weatherService.fetchWeather(city);
      setState(() {
        _weather = weather;
      });
    } catch (error) {
      setState(() {
        _error = error.toString();
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _cityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Global Weather'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Search weather for any city worldwide',
              style: TextStyle(fontSize: 18.0),
            ),
            const SizedBox(height: 16.0),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _cityController,
                    textInputAction: TextInputAction.search,
                    onSubmitted: _searchWeather,
                    decoration: const InputDecoration(
                      labelText: 'City name',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.public),
                    ),
                  ),
                ),
                const SizedBox(width: 12.0),
                FilledButton(
                  onPressed: () => _searchWeather(_cityController.text.trim()),
                  child: const Text('Search'),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: _favoriteCities.map((city) {
                return ActionChip(
                  label: Text(city),
                  onPressed: () {
                    _cityController.text = city;
                    _searchWeather(city);
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 20.0),
            Expanded(
              child: Center(
                child: _isLoading
                    ? const CircularProgressIndicator()
                    : _error != null
                        ? Text(
                            _error!,
                            style: const TextStyle(color: Colors.red, fontSize: 16.0),
                            textAlign: TextAlign.center,
                          )
                        : _weather != null
                            ? WeatherCard(weather: _weather!)
                            : const Text(
                                'Enter a city and tap Search to view weather details.',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 16.0),
                              ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WeatherCard extends StatelessWidget {
  final Weather weather;

  const WeatherCard({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              weather.location,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 12.0),
            Text(
              weather.description,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _WeatherStat(label: 'Temp', value: '${weather.temperature.toStringAsFixed(1)} °C'),
                _WeatherStat(label: 'Humidity', value: '${weather.humidity}%'),
                _WeatherStat(label: 'Wind', value: '${weather.windSpeed.toStringAsFixed(1)} m/s'),
              ],
            ),
            const SizedBox(height: 16.0),
            Text('Feels like ${weather.feelsLike.toStringAsFixed(1)} °C'),
            const SizedBox(height: 8.0),
            Text('Pressure ${weather.pressure} hPa'),
            const SizedBox(height: 8.0),
            Text('Coordinates: ${weather.latitude.toStringAsFixed(2)}, ${weather.longitude.toStringAsFixed(2)}'),
          ],
        ),
      ),
    );
  }
}

class _WeatherStat extends StatelessWidget {
  final String label;
  final String value;

  const _WeatherStat({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.labelLarge),
        const SizedBox(height: 4.0),
        Text(value, style: Theme.of(context).textTheme.titleMedium),
      ],
    );
  }
}
