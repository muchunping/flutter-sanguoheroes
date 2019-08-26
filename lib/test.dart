import 'package:flutter/material.dart';
import 'package:provide/provide.dart';

class Counter extends ChangeNotifier {
  int _value;

  int get value => _value;

  Counter(this._value);

  void inc() {
    _value++;
    notifyListeners();
  }
}

void main() {
  var providers = Providers()..provide(Provider.function((ctx) => Counter(0)));
  
  runApp(
    ProviderNode(child: MyApp(), providers: providers)
  );
}

class MyApp extends StatelessWidget{
  final counter = Provider.value(Counter);

  @override
  Widget build(BuildContext context) {
    return Text("${counter.get(context)}");
  }

}
