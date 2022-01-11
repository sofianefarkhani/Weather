class WeatherUser {
  WeatherUser({this.name});

  String? name;

  factory WeatherUser.fromJSON(Map<String, dynamic> json) => WeatherUser(
        name: json['name'],
      );

  static WeatherUser fromFirestore(Object data) {
    final Map<String, dynamic> dataMap = data as Map<String, dynamic>;
    return WeatherUser.fromJSON(dataMap);
  }
}
