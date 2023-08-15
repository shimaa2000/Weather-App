class AppImages {
  static String backgroundImage = DateTime.now().hour < 18 && DateTime.now().hour > 6
      ? 'assets/images/day.jpg'
      : 'assets/images/night.jpg';
}
