class BillTaxDTO {
  String taxName;
  double taxPercentage;

  BillTaxDTO({
    required this.taxName,
    required this.taxPercentage,
  });

  Map<String, dynamic> toJson() {
    return {
      'tax_name': taxName,
      'tax_percentage': taxPercentage,
    };
  }
}