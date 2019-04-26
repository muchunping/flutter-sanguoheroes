void main() {
  final List<String> a = ["b", "a"];
  a.add("c");
  print(a);

  var gifts = {
    'first': 'partridge',
    'second': 'turtledoves',
    'fifth': 'golden rings',
    "a": "true",
    1: 3
  };
  print(gifts["a"]);

  //可选命名参数
  enableFlag({bool a, bool b}) {}
  enableFlag();
  enableFlag(a: true, b: false);

  //可选位置参数
  enableFlag2([bool a, bool b]) {}
  enableFlag2();
  enableFlag2(true, false);

  Function makeAdder(num addBy) {
    return (num i) => addBy + i;
  }

  print(makeAdder(2)(3));

  int i = 0;
  print(i++);
  i = 1;
  print(++i);

  switch (i) {
    case 0:
      break;
    case 2:
      print(">>");
      continue a;
    a:
    case 1:
      print(1);
      break;
  }

  var emp = new Employee.fromJson({});

  // Prints:
  // in Person
  // in Employee
  if (emp is Person) {
    // Type check
    emp.firstName = 'Bob';
  }
  print(emp.firstName);

  var rect = new Rectangle(3, 4, 20, 15);
  assert(rect.left == 3);
  rect.right = 12;
  assert(rect.left == -8);

  Color aColor = Color.blue;
  switch (aColor) {
    case Color.red:
      print('Red as roses!');
      break;
    case Color.green:
      print('Green as grass!');
      break;
    default: // Without this, you see a WARNING.
      print(aColor);  // 'Color.blue'
  }

  new Person("mu")("", "");

  var sort = (Object a, Object b) => 0;
  SortedCollection coll = new SortedCollection(sort);
  print(coll.compare is Sor2t);

  print(Folder.temp().name);

  waitForDate() async {
    return 0;
  }

  var result = waitForDate();
  result.then(print);
  print("waitForDate");
  var number;
  for(int i = 0; i < 1000000000; i ++){
    number = i << 2;
  }
  print(number);
}


typedef int Sort(Object a, b);
typedef int Sor2t(Object a, Object b);

class SortedCollection {
  Function compare;

  SortedCollection(int f(Object a, Object b)) {
    compare = f;
  }
}

class Folder {
  final String name;
  final List<String> contents;

  Folder(this.name):contents = [];
  Folder.temp() : name = 'temporary', contents= [];
}

class Person {
  String firstName;

  Person(this.firstName);

  Person.fromJson(Map data) {
    print('in Person');
  }

  @override
  noSuchMethod(Invocation invocation) {
    print(invocation);
  }

  num call(String s1, String s2){
    return 0;
  }
}

enum Color {
  red,
  green,
  blue
}

class Employee extends Person {
  Employee() : super("");

  // Person does not have a default constructor;
  // you must call super.fromJson(data).
  Employee.fromJson(Map data) : super.fromJson(data) {
    print('in Employee');
  }

  @override
  call(String s1, String s2) {
    return 1;
  }
}

class Point implements Logger{
  num x;
  num y;

  Point(this.x, this.y);

  // Initializer list sets instance variables before
  // the constructor body runs.
  Point.fromJson(Map jsonMap)
      : this.x = jsonMap['x'],
        this.y = jsonMap['y'] {
    print('In Point.fromJson(): ($x, $y)');
  }

  static const ImmutablePoint point = const ImmutablePoint(3, 4);
  static final ImmutablePoint zero = ImmutablePoint.origin;

  @override
  bool mute;

  @override
  void log(String msg) {
  }

  @override
  String get name => null;
}

class ImmutablePoint {
  final num x;
  final num y;

  const ImmutablePoint(this.x, this.y);

  static const ImmutablePoint origin = const ImmutablePoint(0, 0);
}

class Logger {
  final String name;
  bool mute = false;

  // _cache is library-private, thanks to the _ in front
  // of its name.
  static final Map<String, Logger> _cache = <String, Logger>{};

  factory Logger(String name) {
    if (_cache.containsKey(name)) {
      return _cache[name];
    } else {
      final logger = new Logger._internal(name);
      _cache[name] = logger;
      return logger;
    }
  }

  Logger._internal(this.name);

  void log(String msg) {
    if (!mute) {
      print(msg);
    }
  }
}

class Rectangle {
  num left;
  num top;
  num width;
  num height;

  Rectangle(this.left, this.top, this.width, this.height);

  // Define two calculated properties: right and bottom.
  num get right             => left + width;
  set right(num value)  => left = value - width;
  num get bottom            => top + height;
  set bottom(num value) => top = value - height;
}
