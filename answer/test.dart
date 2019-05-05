// 导入模块
import 'dart:math' show Random;

// We changed 5 lines of code to make this sample nicer on
// the web (so that the execution waits for animation frame,
// the number gets updated in the DOM, and the program ends
// after 500 iterations).

main() {
  print('Happy start us coding...');
  final random = new Random();
  print(random.nextDouble());
  printNum();
  String userName = getUseName();
  print('Get Name is $userName');

  // 使用类
  var voyager = new Spacecraft('Voyager I', new DateTime(1997, 9, 5));
  voyager.describe();
  var voyager3 = new Spacecraft.unlaunched('Voyager III');
  voyager3.describe();

  var list = [1, 2, 3, 4];
  // 定义不变的常量
  var constList = const ['a', 'b', 'c', 'd'];

  // Maps
  var gifs = {
    'first' : 'partridge',
    'second': 'turtledoves',
    'fifth' : 'golden rings'
  };

  // 使用构造函数创建Map
  var gifts = new Map();
  gifts['first'] = 'num01';
  gifts[2] = 'num02';
  list.forEach((element) => {
    print(element)
  });
  print('gifts length is: ${gifts.length}');

  // 级联操作
  final casCades = [];
}

// 没有返回值
printNum (){
  for(int i = 0; i<8;i++){
    print('The Number is: ${i + 1 }');
  }
}

// 有返回值的方法
String getUseName() {
  return 'XuHang';
}


class Spacecraft {
  String name;
  DateTime launchDate;
  int launchYear;

  // 构造函数
  Spacecraft(this.name, this.launchDate) {
    launchYear = launchDate?.year;
  }

  // 已命名构造函数，该构造函数转发到默认构造函数。
  Spacecraft.unlaunched(String name) : this(name, null);

  // 方法
  void describe() {
    print('Spacecraft $name');
    if (launchDate !=null) {
      int years = new DateTime.now().difference(launchDate).inDays ~/ 365;
      print('Launched: $launchYear ($years year ago)');
    }else {
      print('Unlaunched');
    }
  }

}