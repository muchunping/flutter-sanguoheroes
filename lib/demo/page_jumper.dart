import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import "package:xml/xml.dart" as xml;

///parse xml's content to a list
///show list
///click to jump page enter next node

main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHome(),
    );
  }
}

class MyHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<MyHome> {
  var list = ["xmls/npcs.xml", "xmls/items.xml"];

  final Widget divider1 = Divider(color: Colors.blue);
  final Widget divider2 = Divider(color: Colors.green);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Title"),
      ),
      body: ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            child: ListTile(
              title: Text(list[index]),
            ),
            onTap: () {
              Navigator.push(context, new CupertinoPageRoute(builder: (c) {
                return NpcListPage(list[index]);
              }));
            },
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return index % 2 == 0 ? divider1 : divider2;
        },
        itemCount: list.length,
      ),
    );
  }
}

class NpcListPage extends StatefulWidget {
  final String fileName;

  NpcListPage(this.fileName);

  @override
  State<StatefulWidget> createState() {
    return NpcListState();
  }
}

class NpcListState extends State<NpcListPage> {
  XmlNode node;

  @override
  void initState() {
    super.initState();
    loadXml(widget.fileName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(node?.name ?? widget.fileName),
      ),
      body: node == null
          ? Text("Loading..")
          : ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  child: _buildChild(node.children[index]),
                  onTap: () {
                    Navigator.push(context, new PageRouteBuilder(pageBuilder:
                        (BuildContext context, Animation animation,
                            Animation secondaryAnimation) {
                      return FadeTransition(
                        opacity: animation,
                        child: DetailPage(node.children[index]),
                      );
                    }, transitionDuration: Duration(milliseconds: 500)));
                  },
                );
              },
              itemCount: node.children.length,
            ),
    );
  }

  Widget _buildChild(XmlNode child) {
    return new Row(
      children: <Widget>[
        Expanded(
          child: new ListTile(
            title: Text("${[child.attributes.keys.elementAt(0)]}"),
            subtitle:
                Text("${child.attributes[child.attributes.keys.elementAt(0)]}"),
          ),
        ),
        Expanded(
          child: new ListTile(
            title: Text("${[child.attributes.keys.elementAt(1)]}"),
            subtitle: Hero(
              tag: "${child.attributes[child.attributes.keys.elementAt(1)]}",
              child: Text(
                  "${child.attributes[child.attributes.keys.elementAt(1)]}"),
            ),
          ),
        ),
        Expanded(
          child: new ListTile(
            title: Text("${[child.attributes.keys.elementAt(2)]}"),
            subtitle:
                Text("${child.attributes[child.attributes.keys.elementAt(0)]}"),
          ),
        ),
      ],
    );
  }

  loadXml(String fileName) async {
    var node = XmlNode();
    var parserNPC = (String content) {
      var parse = xml.parse(content);
//      parse.children.where((it) {
//        return it is xml.XmlElement;
//      }).map((e) {
//        node.name = (e as xml.XmlElement).name.local;
//        e.children.where((it) => it is xml.XmlElement).map((f) {
//          var childNode = XmlNode();
//          childNode.name = (f as xml.XmlElement).name.local;
//          f.attributes.forEach((attr) {
//            childNode.attributes.putIfAbsent(attr.name.local, () {
//              return attr.value;
//            });
//          });
//        });
//      });
      for (var v in parse.children) {
        if (v is xml.XmlElement) {
          node.name = v.name.local;
          for (var t in v.children) {
            if (t is xml.XmlElement) {
              var childNode = XmlNode();
              childNode.name = t.name.local;
              for (var n in t.attributes) {
                childNode.attributes.putIfAbsent(n.name.local, () {
                  return n.value;
                });
              }
              node.children.add(childNode);
            }
          }
        }
      }
      return node;
    };

    await DefaultAssetBundle.of(context)
        .loadString(fileName)
        .then(parserNPC)
        .then((node) {
      setState(() {
        this.node = node;
      });
    });
  }
}

class XmlNode {
  String name;
  Map<String, Object> attributes = {};
  List<XmlNode> children = [];
}

class DetailPage extends StatelessWidget {
  final XmlNode node;

  DetailPage(this.node);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(node.name),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Image.asset(
                "images/${node.attributes["pic"] ?? "ic_launcher.png"}"),
            Hero(
                tag: "${node.name}",
                child: Text(
                  node.attributes["name"],
                  style: TextStyle(
                      inherit: false, color: Colors.black, fontSize: 24),
                )),
            Text("标记: ${node.attributes["id"]}"),
            Text("介绍: ${node.attributes["descprition"]}"),
          ],
        ),
      ),
    );
  }
}
