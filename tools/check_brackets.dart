import 'dart:io';

void main(List<String> args) {
  if (args.isEmpty) {
    print('Usage: dart check_brackets.dart <file>');
    exit(2);
  }
  final path = args[0];
  final text = File(path).readAsStringSync();
  final stack = <Map<String, dynamic>>[];
  final pairs = {'(': ')', '{': '}', '[': ']'};
  for (var i = 0; i < text.length; i++) {
    final ch = text[i];
    if (pairs.containsKey(ch)) {
      stack.add({'char': ch, 'pos': i});
    } else if (pairs.containsValue(ch)) {
      if (stack.isEmpty) {
        print('Unmatched closing $ch at index $i');
        exit(1);
      }
      final last = stack.removeLast();
      final expected = pairs[last['char']];
      if (expected != ch) {
        print('Mismatched: expected $expected but found $ch at index $i');
        print(
          'Last opened ${last['char']} at ${last['pos']} expected $expected',
        );
        print('Current stack (top last):');
        for (var s in stack) {
          print('  ${s['char']} at ${s['pos']}');
        }
        exit(1);
      }
    }
  }
  if (stack.isNotEmpty) {
    for (var item in stack) {
      final pos = item['pos'];
      print('Unclosed ${item['char']} at index $pos');
    }
    exit(1);
  }
  print('All balanced');
}
