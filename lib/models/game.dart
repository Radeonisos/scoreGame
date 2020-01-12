class Game {

  int id;
  String name;
  String image;

  Game();


  void fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.name = map['name'];
    this.image = map['image'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'name': this.name,
      'image': this.image
    };
    if(id != null) {
      map['id'] = this.id;
    }
    return map;
  }
}