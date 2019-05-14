import 'package:flutter/services.dart';
import 'package:sanguo_heroes/sanguo/models/item.dart';
import 'package:sanguo_heroes/sanguo/models/npc.dart';
import 'package:sanguo_heroes/sanguo/models/scene.dart';
import "package:xml/xml.dart" as xml;

class WorldContext {
  List<Scene> sceneList;
  List<Npc> npcList;
  List<Item> itemList;

  void loadResource(AssetBundle assetBundle, void f(progress)) async {
    var progress = 0.0;
    sceneList = await assetBundle
        .loadStructuredData<List<Scene>>("xmls/scenes.xml", (data) {
      return parseXml<Scene>(data, (element) {
        return Scene.fromXml(element);
      });
    });
    f(progress += 10);
    for (var i = 0; i < 20; i++) {
      await new Future.delayed(const Duration(milliseconds: 50));
      f(progress += 1);
    }
    npcList = await assetBundle.loadStructuredData<List<Npc>>("xmls/npcs.xml",
        (data) {
      return parseXml<Npc>(data, (element) {
        return Npc.fromXml(element);
      });
    });
    f(progress += 10);
    for (var i = 0; i < 20; i++) {
      await new Future.delayed(const Duration(milliseconds: 50));
      f(progress += 1);
    }
    itemList = await assetBundle
        .loadStructuredData<List<Item>>("xmls/items.xml", (data) {
      return parseXml<Item>(data, (element) {
        return Item.fromXml(element);
      });
    });
    f(progress += 20);
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
}
