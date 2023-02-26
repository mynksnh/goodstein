import 'dart:io';

import 'base_expression_big.dart';

void main() {
  try {
    stdout.writeln('Enter a natural number n > 0:');
    BigInt n = BigInt.from(int.parse(stdin.readLineSync() ?? "1"));
    BigInt b = BigInt.two;
    var be = BaseExpressionBig.build(n, b);
    stdout.writeln('$n expressed in powers of $b:');
    stdout.writeln(be.stringify(b));
    stdout.writeln('Hit enter for next sequence ("exit" to exit):');
    while (stdin.readLineSync() != "exit" && n != BigInt.zero) {
      b = b + BigInt.one;
      stdout.writeln('Increase base by 1');
      n = be.evaluate(b);
      stdout.writeln("n = ${be.stringify(b)} = $n");
      stdout.writeln("subtract 1 from n");
      n = n - BigInt.one;
      be = BaseExpressionBig.build(n, b);
      stdout.writeln("n = ${be.stringify(b)} = $n");
      n != BigInt.zero
          ? stdout.writeln('Hit enter for next sequence ("exit" to exit):')
          : stdout.writeln('Sequence terminated at 0. Hit enter to exit');
    }
  } catch (e) {
    stdout.write(e.toString());
  }
}
