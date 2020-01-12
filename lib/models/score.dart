class Score {
  int id;
  String point;
  int player;

  Score();

  void fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.point = map['point'];
    this.player = map['player'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'point': this.point,
      'player': this.player
    };
    if(id != null) {
      map['id'] = this.id;
    }
    return map;
  }
}