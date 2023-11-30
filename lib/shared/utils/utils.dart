import 'package:intl/intl.dart';

String formatCurrency(double? amount) {
  if (amount == null) return "R\$ 0,00";

  final currencyFormatter =
      NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');
  return currencyFormatter.format(amount);
}
