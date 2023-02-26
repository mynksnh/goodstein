class BaseExpressionBig {
  final _expr = <BaseExpressionBig>[];

  BaseExpressionBig.build(BigInt n, BigInt base) {
    BigInt remainder = n % base;
    BigInt quotient = n - remainder;

    var exponents = _getExponents(quotient, base);
    for (var e in exponents) {
      _push(BaseExpressionBig.build(e, base));
    }

    if (remainder > BigInt.zero) {
      for (BigInt i = BigInt.zero; i < remainder; i = i + BigInt.one) {
        _push(BaseExpressionBig.build(BigInt.zero, base));
      }
    }
  }

  BigInt evaluate(BigInt base) {
    return _expr.fold(
        BigInt.zero,
        (previousValue, e) =>
            previousValue + _powBigInt(base, e.evaluate(base)));
  }

  String stringify(BigInt base) {
    return _expr.length == 0
        ? "0"
        : _expr.map((e) => "$base^(${e.stringify(base)})").join("+");
  }

  void _push(BaseExpressionBig be) {
    _expr.add(be);
  }

  List<BigInt> _getExponents(BigInt q, BigInt base) {
    var exponents = <BigInt>[];
    while (q != BigInt.zero) {
      var exp = BigInt.zero;
      var c = base;
      while (c <= q) {
        c = c * base;
        exp = exp + BigInt.one;
      }
      exponents.add(exp);
      q = q - _powBigInt(base, exp);
    }
    return exponents;
  }

  BigInt _powBigInt(BigInt base, BigInt exp) {
    var result = BigInt.one;
    if (exp == BigInt.zero) {
      return result;
    }
    for (BigInt i = BigInt.zero; i < exp; i = i + BigInt.one) {
      result = result * base;
    }
    return result;
  }
}
