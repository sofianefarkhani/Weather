class WeatherUser {
  WeatherUser({this.name,this.villes});

  String? name;
  List<String>? villes;

  
  static WeatherUser fromFirestore(Object data) {
    
    final Map<dynamic, dynamic> dataMap = data as Map<dynamic, dynamic>;
    WeatherUser user =  WeatherUser(name: dataMap["name"],villes: List.from(dataMap["ville"]));
    return user;
  }


}

