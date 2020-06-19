// ignore_for_file: public_member_api_docs
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: MultiProvider(
            providers: [ChangeNotifierProvider(builder: (_) => Counter())],
            child: Center(child: CounterLabel()),
          ),
        ),
      ),
    ));

class Counter with ChangeNotifier {
  int _count = 0;

  int get count => _count;

  void increment() {
    _count++;
    notifyListeners();
  }
}

class CounterLabel extends StatelessWidget {
  CounterLabel({Key key}) : super(key: key);

  Future beginFight(BuildContext context) async {
    while(true) {
      Provider.of<Counter>(context, listen: false).increment();
      await new Future.delayed(const Duration(milliseconds: 1000));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Text(
          'You have pushed the button this many times:',
        ),
        Consumer<Counter>(builder: (context, counter, _) {
          return Text(
            '${counter.count}',
            style: Theme.of(context).textTheme.display1,
          );
        }),
        FloatingActionButton(
          onPressed: () {
            beginFight(context);
          },
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
      ],
    );
  }
}
