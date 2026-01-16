enum OperationTypeEnum {
  addition(symbol: '+'),
  subtration(symbol: '-'),
  multiplication(symbol: 'x'),
  division(symbol: '÷');

  final String symbol;
  const OperationTypeEnum({required this.symbol});
}