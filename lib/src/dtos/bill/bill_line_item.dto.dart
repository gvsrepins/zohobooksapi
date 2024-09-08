class BillLineItemDTO {
  String itemId;
  String name;
  double quantity;
  double rate;

  BillLineItemDTO({
    required this.itemId,
    required this.name,
    required this.quantity,
    required this.rate,
  });

  Map<String, dynamic> toJson() {
    return {
      'item_id': itemId,
      'name': name,
      'quantity': quantity,
      'rate': rate,
    };
  }
}