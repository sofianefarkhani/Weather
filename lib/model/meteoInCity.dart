class MeteoInCity {
   const MeteoInCity({
    this.ville,
    this.description,
    this.icon,
    this.temperature
  });

  final String? ville;
  final String? temperature;
  final String? icon;
  final String? description;

/*
  factory Crypto.fromJson(Map<String, dynamic> json)=>
      Crypto(
        symbol: json['symbol'] as String?,
        priceChangePercent: json['priceChangePercent'] as String?,

      );
*/

  factory MeteoInCity.fromJson(Map<String, dynamic> json){

    var weatherobj = json['weather'];
    var descrip = weatherobj[0]['description'];
    var ico = weatherobj[0]['icon'];

    var weathervalues = json['main'];
    var temp = weathervalues['temp'];

    var villeName = json['name'];

    return MeteoInCity(
      ville: villeName,
      description: descrip,
      icon: ico,
      temperature: temp.toString());
  }

}