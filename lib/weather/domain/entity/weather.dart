class Weather {
  final String cityName;
  final String main;
  final String description;
  final int pressure;
  final int humidity;
  final double temp;
  final String icon;

  Weather({
    required this.cityName,
    required this.main,
    required this.icon,
    required this.description,
    required this.pressure,
    required this.humidity,
    required this.temp,
  });
}
