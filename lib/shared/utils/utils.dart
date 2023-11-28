String formatCurrency(double? amount) {
  if (amount == null) return "R\$ 0,00";
  return "R\$ ${(amount ?? 0).toStringAsFixed(2).replaceAll(".", ",")}";
}
