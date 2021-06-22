
class Band{
  String id;
  String name;
  int votes;
  
  Band(this.id, this.name, this.votes);

  factory Band.fromMap(Map<String, dynamic> obj) => Band(obj['id'], obj['name'], obj['votes']);
  

}