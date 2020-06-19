import 'package:sanguoheroes/sanguo/models/fighter.dart';
import "package:xml/xml.dart" as xml;

class Npc extends Fighter{
  final String id;
  final String name;
  final String type;
  final List<String> actions;
  final String alias;
  final String property;
  final String level;
  final String desc;
  final String shortDesc;
  final String stunt;

  Npc._internal(this.id, this.name, this.type, this.actions, this.alias,
      this.property, this.level, this.desc, this.shortDesc, this.stunt);

  factory Npc(xml.XmlElement element) {
    return Npc._internal(
        element.getAttribute("id"),
        element.getAttribute("name"),
        element.getAttribute("type"),
        element.getAttribute("action").split("|"),
        element.getAttribute("alias"),
        element.getAttribute("property"),
        element.getAttribute("level"),
        element.getAttribute("desc"),
        element.getAttribute("shortDesc"),
        element.getAttribute("stunt"));
  }

  @override
  String toString() {
    return 'Npc{id: $id, name: $name, type: $type, action: $actions}';
  }
}
