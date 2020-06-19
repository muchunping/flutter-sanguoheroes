import 'package:flutter/material.dart';

import '../index.dart';

main() => runApp(MaterialApp(home: BackpackPage(amount: 100)));

class BackpackPage extends StatelessWidget {
  final int amount;
  final int crossAxisCount;

  BackpackPage({Key key, this.amount, this.crossAxisCount = 6})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Container(
            color: Colors.yellow,
            padding: EdgeInsets.all(10 * scaleX),
            child: GestureDetector(
              onTap: () {},
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.blue,
                    border: Border.all(color: Colors.brown)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(10 * scaleX),
                      color: Colors.green,
                      child: Text(
                        "背包",
                        style: TextStyle(color: Colors.white, fontSize: 22),
                      ),
                    ),
                    Padding(padding: EdgeInsets.all(2 * scaleX)),
                    Expanded(
                      child: Container(
                        child: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    mainAxisSpacing: 2 * scaleX,
                                    crossAxisSpacing: 2 * scaleX,
                                    crossAxisCount: crossAxisCount),
                            itemCount: amount +
                                (amount % crossAxisCount > 0
                                    ? crossAxisCount - amount % crossAxisCount
                                    : 0),
                            itemBuilder: (c, i) {
                              return _LootInBackpack(i < amount);
                            }),
                      ),
                    ),
                    Padding(padding: EdgeInsets.all(2 * scaleX)),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _LootInBackpack extends StatelessWidget {
  final bool isNotEmpty;

  _LootInBackpack(this.isNotEmpty);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.green, border: Border.all(color: Colors.blue)),
      child: Stack(
        children: isNotEmpty
            ? <Widget>[
                Image.asset("images/email.png"),
                Positioned(
                  child: Text(
                    "9999",
                    style: TextStyle(color: Colors.white),
                  ),
                  right: 2 * scaleX,
                  bottom: 2 * scaleX,
                )
              ]
            : [],
      ),
    );
  }
}
