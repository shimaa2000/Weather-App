class Weather {
  final String cityName;
  final String main;
  final String description;
  final int humidity;
  final String icon;

  Weather({
    required this.cityName,
    required this.main,
    required this.icon,
    required this.description,
    required this.humidity,
  });
}
