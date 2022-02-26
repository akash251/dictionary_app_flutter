class Dictionary{
  late String? type;
  late String? definition;
  late String? image_url;
  late String? example;
  late String? emoji;

  Dictionary({
    this.type,
    this.definition,
    this.emoji,
    this.example,
    this.image_url
  });

  factory Dictionary.fromJson(Map<String,dynamic> json){
    return Dictionary(
        type: json['type'],
        definition: json['definition'],
        emoji: json['emoji'],
        example: json['example'],
        image_url: json['image_url']
    );
  }
}