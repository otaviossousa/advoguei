import 'dart:io';

void main(List<String> args) {
  if (args.length < 3) {
    print('Usage: dart print_lines.dart <file> <startLine> <endLine>');
    exit(2);
  }
  final path = args[0];
  final start = int.parse(args[1]);
  final end = int.parse(args[2]);
  final lines = File(path).readAsLinesSync();
  for (var i = start; i <= end && i <= lines.length; i++) {
    final num = i.toString().padLeft(4);
    print('$num: ${lines[i - 1]}');
  }
}
