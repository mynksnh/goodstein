import 'dart:io';
import 'dart:math';

class BaseExpressionBig {
  final _expr = <BaseExpressionBig>[];

  BaseExpressionBig build(BigInt n, BigInt base) {
    BigInt remainder = n % base;
    BigInt quotient = n - remainder;

    var exponents = _getExponents(quotient, base);
    for (var e in exponents) {
      _push(BaseExpressionBig().build(e, base));
    }

    if (remainder > BigInt.from(0)) {
      for (BigInt i = BigInt.from(0); i < remainder; i = i + BigInt.from(1)) {
        _push(BaseExpressionBig().build(BigInt.from(0), base));
      }
    }

    return this;
  }

  BigInt evaluate(BigInt base) {
    return _expr.fold(
        BigInt.from(0),
        (previousValue, e) =>
            previousValue + _powBigInt(base, e.evaluate(base)));
  }

  String stringify(BigInt base) {
    var result = _expr.map((e) => "$base^(${e.stringify(base)})").join("+");
    return result.isEmpty ? "0" : result;
  }

  void _push(BaseExpressionBig be) {
    _expr.add(be);
  }

  List<BigInt> _getExponents(BigInt q, BigInt base) {
    var exponents = <BigInt>[];
    while (q != BigInt.from(0)) {
      var exp = BigInt.from(0);
      var c = base;
      while (c <= q) {
        c = c * base;
        exp = exp + BigInt.from(1);
      }
      exponents.add(exp);
      q = q - _powBigInt(base, exp);
    }
    return exponents;
  }

  BigInt _powBigInt(BigInt base, BigInt exp) {
    var result = BigInt.from(1);
    if (exp == BigInt.from(0)) {
      return result;
    }
    for (BigInt i = BigInt.from(0); i < exp; i = i + BigInt.from(1)) {
      result = result * base;
    }
    return result;
  }
}
