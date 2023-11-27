class Pokemon {
  var id;
  var idPokedex;
  var name;
  var img;

  Pokemon({this.id, this.idPokedex, this.name, this.img});

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      id: json['id'],
      idPokedex: json['idPokedex'],
      name: json['name'],
      img: json['img']);
  }
}