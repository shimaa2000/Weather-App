class Weather {
  final int id;
  final String cityName;
  final String main;
  final String description;
  final int pressure;
  final int humidity;
  final double temp;
  final String icon;
  final double windSpeed;

  Weather({
    required this.id,
    required this.cityName,
    required this.main,
    required this.icon,
    required this.description,
    required this.pressure,
    required this.humidity,
    required this.temp,
    required this.windSpeed,
  });
}
