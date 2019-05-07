import "package:xml/xml.dart" as xml;

class Scene {
  final String id;
  final String name;
  final String type;
  final String description;
  final List<Gate> gates;

  Scene(this.id, this.name, this.type, this.description, this.gates);

  Scene.fromXml(xml.XmlElement element)
      : id = element.attributes.firstWhere((attribute) {
    return attribute.name.local == "id";
  }).value,
        name = element.attributes.firstWhere((attribute) {
          return attribute.name.local == "name";
        }).value,
        type = element.attributes.firstWhere((attribute) {
          return attribute.name.local == "type";
        }).value,
        description = element.attributes.firstWhere((attribute) {
          return attribute.name.local == "description";
        }).value,
        gates = element.children
            .where((node) {
          return node is xml.XmlElement;
        })
            .map<xml.XmlElement>((node) {
          return node as xml.XmlElement;
        })
            .firstWhere((element) {
          return element.name.local == "gates-list";
        })
            .children
            .where((node) {
          return node is xml.XmlElement;
        })
            .map<xml.XmlElement>((node) {
          return node as xml.XmlElement;
        })
            .map((element) {
          return Gate.fromXml(element);
        })
            .toList();

  @override
  String toString() {
    return 'Scene{id: $id, name: $name, type: $type, description: $description, gates: $gates}';
  }

}

class Gate {
  final String id;
  final bool visible;

  Gate(this.id, this.visible);

  Gate.fromXml(xml.XmlElement element)
      : id = element.attributes.firstWhere((attribute) {
    return attribute.name.local == "id";
  }).value,
        visible = element.attributes.firstWhere((attribute) {
          return attribute.name.local == "visible";
        }).value ==
            "1";

  @override
  String toString() {
    return 'Gate{id: $id, visible: $visible}';
  }

}