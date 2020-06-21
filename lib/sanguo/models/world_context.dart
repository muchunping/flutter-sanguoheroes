import 'package:flutter/services.dart';
import 'package:sanguoheroes/sanguo/models/equipment.dart';
import 'package:sanguoheroes/sanguo/models/item.dart';
import 'package:sanguoheroes/sanguo/models/npc.dart';
import 'package:sanguoheroes/sanguo/models/player.dart' as p;
import 'package:sanguoheroes/sanguo/models/scene.dart';
import "package:xml/xml.dart" as xml;

class WorldContext {
  Map<String, Scene> sceneMap;
  Map<String, Npc> npcMap;
  List<Item> itemList;
  Map<String, Item> itemMap;
  Map<String, Equipment> equipmentMap;

  Scene currentScene;
  p.Player player;

  void loadResource(AssetBundle assetBundle, void f(progress)) async {
    var progress = 0.0;
    var sceneList = await assetBundle
        .loadStructuredData<List<Scene>>("xmls/scenes.xml", (data) {
      return parseXml<Scene>(data, (element) {
        return Scene.fromXml(element);
      });
    });
    sceneMap = Map<String, Scene>.fromIterable(sceneList,
        key: (item) => (item as Scene).id, value: (item) => item);
    print("sceneMap=$sceneMap");
    f(progress += 10);
    for (var i = 0; i < 20; i++) {
      await new Future.delayed(const Duration(milliseconds: 50));
      f(progress += 1);
    }
    var npcList = await assetBundle
        .loadStructuredData<List<Npc>>("xmls/npcs.xml", (data) {
      return parseXml<Npc>(data, (element) {
        return Npc(element);
      });
    });
    npcMap = Map<String, Npc>.fromIterable(npcList,
        key: (item) => (item as Npc).id, value: (item) => item);
    print("npcMap=$npcMap");
    f(progress += 10);
    for (var i = 0; i < 20; i++) {
      await new Future.delayed(const Duration(milliseconds: 50));
      f(progress += 1);
    }
    var itemList = await assetBundle
        .loadStructuredData<List<Item>>("xmls/items.xml", (data) {
      return parseXml<Item>(data, (element) {
        return Item.fromXml(element);
      });
    });
    itemMap = Map<String, Item>.fromIterable(itemList,
        key: (item) => (item as Item).id, value: (item) => item);
    print("itemMap=$itemMap");
    f(progress += 20);
    initConfig();
    for (var i = 0; i < 20; i++) {
      await new Future.delayed(const Duration(milliseconds: 100));
      f(progress += 1);
    }
  }

  Future<List<E>> parseXml<E>(String data, E f(xml.XmlElement element)) {
    var list = <E>[];
    var document = xml.parse(data);
    document.children
        .where((node) => node is xml.XmlElement)
        .map<xml.XmlElement>((node) => node as xml.XmlElement)
        .forEach((element) {
      print(element.name.local);
      element.children
          .where((node) => node is xml.XmlElement)
          .map<xml.XmlElement>((node) => node as xml.XmlElement)
          .forEach((element) => list.add(f(element)));
    });
    return Future.value(list);
  }

  void initConfig() {
    player = new p.Player();
    currentScene = sceneMap["01"];
  }
}
