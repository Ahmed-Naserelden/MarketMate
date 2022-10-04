// ignore_for_file: avoid_print

void printFullText(String text){
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach((ele) => print(ele.group(0)));
}

String token = '';