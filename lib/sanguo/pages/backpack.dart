import 'package:flutter/material.dart';

import '../index.dart';

main() => runApp(MaterialApp(home: BackpackPage(amount: 50)));

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
                    Padding(
                      padding: EdgeInsets.all(10 * scaleX),
                      child: Text(
                        "背包",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
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
                    )
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
  final bool isEmpty;

  _LootInBackpack(this.isEmpty);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.green, border: Border.all(color: Colors.blue)),
      child: !isEmpty ? null : Image.asset("images/email.png"),
    );
  }
}
