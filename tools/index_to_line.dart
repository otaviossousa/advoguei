import 'dart:io';

void main(List<String> args) {
  if (args.length < 2) {
    print('Usage: dart index_to_line.dart <file> <index>');
    exit(2);
  }
  final path = args[0];
  final index = int.parse(args[1]);
  final text = File(path).readAsStringSync();
  if (index < 0 || index >= text.length) {
    print('Index out of range');
    exit(2);
  }
  final before = text.substring(index - 40 < 0 ? 0 : index - 40, index);
  final at = text[index];
  final after = text.substring(
    index + 1,
    (index + 1 + 40).clamp(0, text.length),
  );
  final lines = text.substring(0, index).split('\n');
  final lineNum = lines.length;
  final col = lines.last.length + 1;
  print('Index: $index -> line $lineNum, column $col');
  print('Context:');
  print(before.replaceAll('\n', '\n'));
  print('>>>$at<<<');
  print(after.replaceAll('\n', '\n'));
}
