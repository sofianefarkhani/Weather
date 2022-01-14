class WeatherUser {
  WeatherUser({this.name,this.villes});

  String? name;
  List<String>? villes;

  factory WeatherUser.fromJSON(Map<String, dynamic> json) => WeatherUser(
        name: json['name'],
        villes: json['villes'],
      );

  static WeatherUser fromFirestore(Object data) {
    final Map<String, dynamic> dataMap = data as Map<String, dynamic>;
    return WeatherUser.fromJSON(dataMap);
  }
}

