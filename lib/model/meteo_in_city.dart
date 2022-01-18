class MeteoInCity {
  const MeteoInCity(
      {this.ville, this.description, this.icon, this.temperature});

  final String? ville;
  final String? temperature;
  final String? icon;
  final String? description;

  factory MeteoInCity.fromJson(Map<String, dynamic> json) {
    //on récupère les infos contenu dans la partie weather
    var weatherobj = json['weather'];
    //description de la météo
    var descrip = weatherobj[0]['description'];
    //l'icon à aller télécharger sur internet qui vas avec la description
    var ico = weatherobj[0]['icon'];

    //on récupère les infos de la partie main 
    var weathervalues = json['main'];
    //on prend la température en temp réelle
    var temp = weathervalues['temp'];

    //on récupère le nom de la ville
    var villeName = json['name'];

    //on retourne notre objet MeteoInCity
    return MeteoInCity(
        ville: villeName,
        description: descrip,
        icon: ico,
        temperature: temp.toString());
  }
}
