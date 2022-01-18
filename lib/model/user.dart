class WeatherUser {
  WeatherUser({this.name, this.villes});

  String? name;
  List<String>? villes;

  static WeatherUser fromFirestore(Object data) {
    //on récupère l'objet et on le map 
    final Map<dynamic, dynamic> dataMap = data as Map<dynamic, dynamic>;
    //créé l'user avec son nom et la liste des villes qui sont contenue dans la bdd firestore
    WeatherUser user = WeatherUser(name: dataMap["name"], villes: List.from(dataMap["ville"]));
    return user;
  }
}
