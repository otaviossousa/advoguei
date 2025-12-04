import 'dart:io';

void main(List<String> args) {
  final path = args.isNotEmpty
      ? args[0]
      : 'lib/screens/process_detail_screen.dart';
  final text = File(path).readAsStringSync();
  int paren = 0;
  int brace = 0;
  int bracket = 0;
  for (var i = 0; i < text.length; i++) {
    final ch = text[i];
    if (ch == '(') paren++;
    if (ch == ')') paren--;
    if (ch == '{') brace++;
    if (ch == '}') brace--;
    if (ch == '[') bracket++;
    if (ch == ']') bracket--;
    if (ch == '}' && paren > 0) {
      // print context
      final before = text.substring(i - 40 < 0 ? 0 : i - 40, i);
      final lines = text.substring(0, i).split('\n');
      final line = lines.length;
      final col = lines.last.length + 1;
      print('Found } at index $i (line $line,col $col) while paren=$paren');
      print('Context before:');
      print(before.replaceAll('\n', '\n'));
      break;
    }
  }
  print('Final counts paren=$paren, brace=$brace, bracket=$bracket');
}
