import 'dart:io';
import 'dart:math';

import 'base_expression.dart';

void main() {
  try {
    stdout.writeln('Enter a natural number n > 0:');
    int n = int.parse(stdin.readLineSync() ?? "1");
    int b = 2;
    var be = BaseExpression().build(n, b);
    stdout.writeln('$n expressed in powers of $b:');
    stdout.writeln(be.stringify(b));
    stdout.writeln('Hit enter for next sequnce ("exit" to exit):');
    stdout.writeln(pow(2, 63) + 1);
    while (stdin.readLineSync() != "exit" && n != 0) {
      b = b + 1;
      stdout.writeln('Increase base by 1');
      n = be.evaluate(b);
      stdout.writeln("n = ${be.stringify(b)} = $n");
      stdout.writeln("subtract 1 from n");
      n = n - 1;
      be = BaseExpression().build(n, b);
      stdout.writeln("n = ${be.stringify(b)} = $n");
      n != 0
          ? stdout.writeln('Hit enter for next sequnce ("exit" to exit):')
          : stdout.writeln('Sequence terminated at 0. Hit enter to exit');
    }
  } catch (e) {
    stdout.write(e.toString());
  }
}
