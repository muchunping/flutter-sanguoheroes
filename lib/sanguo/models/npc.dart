import "package:xml/xml.dart" as xml;

class Npc {
  final String id;
  final String name;
  final String type;
  final String action;

  Npc(this.id, this.name, this.type, this.action);

  Npc.fromXml(xml.XmlElement element)
      : id = element.attributes.firstWhere((attribute) {
          return attribute.name.local == "id";
        }).value,
        name = element.attributes.firstWhere((attribute) {
          return attribute.name.local == "name";
        }).value,
        type = element.attributes.firstWhere((attribute) {
          return attribute.name.local == "type";
        }).value,
        action = element.attributes.firstWhere((attribute) {
          return attribute.name.local == "action";
        }).value;

  @override
  String toString() {
    return 'Npc{id: $id, name: $name, type: $type, action: $action}';
  }

}
