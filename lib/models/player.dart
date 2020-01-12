class Player {
  int id;
  String name;
  int game;

  Player();

  void fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.name = map['name'];
    this.game = map['game'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'name': this.name,
      'game': this.game
    };
    if(id != null) {
      map['id'] = this.id;
    }
    return map;
  }
}