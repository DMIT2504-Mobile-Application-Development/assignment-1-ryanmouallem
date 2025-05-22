class CurrentWeather {
  late String _city;
  late String _description;
  late double _currentTemp;
  late DateTime _currentTime;
  DateTime? _sunrise;
  DateTime? _sunset;

  CurrentWeather({
    required String city,
    required String description,
    required double currentTemp,
    required DateTime currentTime,
    required DateTime sunrise,
    required DateTime sunset,
}) {
    this.city = city;
    this.description = description;
    this.currentTemp = currentTemp;
    this.currentTime = currentTime;
    this.sunset = sunset;
    this.sunrise = sunrise;
  }

  factory CurrentWeather.fromOpenWeatherData(dynamic data) {
    String city = data['name'];
    String description = data['weather'][0]['description'];
    double currentTemp = data['main']['temp'].toDouble();
    DateTime currentTime = DateTime.fromMillisecondsSinceEpoch((data['dt'] * 1000).toInt());
    DateTime sunrise = DateTime.fromMillisecondsSinceEpoch((data['sys']['sunrise'] * 1000).toInt());
    DateTime sunset = DateTime.fromMillisecondsSinceEpoch((data['sys']['sunset'] * 1000).toInt());

    return CurrentWeather(
      city: city,
      description: description,
      currentTemp: currentTemp,
      currentTime: currentTime,
      sunrise: sunrise,
      sunset: sunset,
    );
  }


  String get city => _city;

  set city(String value) {
    if (value.isEmpty) {
      throw Exception('City cannot be empty');
    }
    _city = value;
  }

  String get description => _description;

  set description(String value) {
    if (value.isEmpty) {
      throw Exception('Description cannot be empty');
    }
    _description = value;
  }

  double get currentTemp => _currentTemp;

  set currentTemp(double value) {
    if (value < -100 || value > 100) {
      throw Exception('Temperature must be between -100 and 100');
    }
    _currentTemp = value;
  }

  DateTime get currentTime => _currentTime;

  set currentTime(DateTime value) {
    if(value.isAfter(DateTime.now())) {
      throw Exception('Current time cannot be in the future');
    }
    _currentTime = value;
  }

  DateTime get sunrise => _sunrise!;

  set sunrise(DateTime value) {
    if (_currentTime.year != value.year || _currentTime.month != value.month || _currentTime.day != value.day) {
      throw Exception('Sunrise must be on the same day as current time');
    }

    if (_sunset != null && value.isAfter(_sunset!)) {
      throw Exception('Sunrise cannot be after sunset');
    }

    _sunrise = value;
  }

  DateTime get sunset => _sunset!;

  set sunset(DateTime value) {
    if (_currentTime.year != value.year || _currentTime.month != value.month || _currentTime.day != value.day) {
      throw Exception('Sunset must be on the same day as current time');
    }

    if (_sunrise != null && value.isBefore(_sunrise!)) {
      throw Exception('Sunset cannot be before sunrise');
    }

    _sunset = value;
  }

  @override
  String toString() {
    return 'City: $city, Description: $description, Current Temperature: $currentTemp, Current Time: $currentTime, Sunrise: $sunrise, Sunset: $sunset';
  }
}

