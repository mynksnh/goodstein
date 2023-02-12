import 'dart:math';

class BaseExpression {
  final _expr = <BaseExpression>[];

  BaseExpression build(int n, int base) {
    int remainder = n % base;
    int quotient = n - remainder;

    var exponents = _getExponents(quotient, base);

    for (var e in exponents) {
      _push(BaseExpression().build(e, base));
    }

    if (remainder > 0) {
      for (int i = 0; i < remainder; i++) {
        _push(BaseExpression().build(0, base));
      }
    }

    return this;
  }

  int evaluate(int base) {
    return _expr.fold(
        0,
        (previousValue, e) =>
            previousValue + pow(base, e.evaluate(base)).toInt());
  }

  String stringify(int base) {
    var result = _expr.map((e) => "$base^(${e.stringify(base)})").join("+");
    return result.isEmpty ? "0" : result;
  }

  void _push(BaseExpression be) {
    _expr.add(be);
  }

  List<int> _getExponents(int q, int base) {
    var exponents = <int>[];
    while (q != 0) {
      var exp = 0;
      var c = base;
      while (c <= q) {
        c = c * base;
        exp = exp + 1;
      }
      exponents.add(exp);
      q = q - pow(base, exp).toInt();
    }
    return exponents;
  }
}
