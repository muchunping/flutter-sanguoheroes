import "package:xml/xml.dart" as xml;

class Item {
  final String id;
  final String name;
  final String pic;
  final String description;

  Item(this.id, this.name, this.pic, this.description);

  Item.fromXml(xml.XmlElement element)
      : id = element.attributes.firstWhere((attribute) {
          return attribute.name.local == "id";
        }).value,
        name = element.attributes.firstWhere((attribute) {
          return attribute.name.local == "name";
        }).value,
        pic = element.attributes.firstWhere((attribute) {
          return attribute.name.local == "pic";
        }).value,
        description = element.attributes.firstWhere((attribute) {
          return attribute.name.local == "description";
        }).value;

  @override
  String toString() {
    return 'Item{id: $id, name: $name, pic: $pic, description: $description}';
  }

}
