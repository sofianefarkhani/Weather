class Weather {
  Weather({this.name});

  String? name;

  static Weather fromJSON(Map<String, dynamic> json) =>
      Weather(name: json['name']);

  static Weather fromFirestore(Object data) {
    final Map<String, dynamic> dataMap = data as Map<String, dynamic>;
    return Weather.fromJSON(dataMap);
  }
}
