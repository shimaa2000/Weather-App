class ApiConstants{
  static const apiKey='e56e1f000506ebec8365f1fe83a9cad4';
  static const baseUrl='https://api.openweathermap.org/data/2.5';
  static const weatherUrl='$baseUrl/weather';
  static const forecastUrl='$baseUrl/forecast';

  static const imageBaseUrl='http://openweathermap.org/img/w/';

  static String imageUrl(String path) => '$imageBaseUrl$path.png';
}