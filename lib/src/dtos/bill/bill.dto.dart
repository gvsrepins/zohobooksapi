import 'package:zohobooks_api/zohoboks_api.dart';
import 'package:intl/intl.dart';


class BillDTO {
  String vendorId;  // Required
  String billNumber;  // Required

  String? billId;
  DateTime? date;  // Required
  DateTime? dueDate;  // Required
  List<String>? purchaseorderIds;
  String? vendorName;
  String? vatTreatment;
  String? vatRegNo;
  String? sourceOfSupply;
  String? destinationOfSupply;
  String? placeOfSupply;
  String? permitNumber;
  String? gstNo;
  String? gstTreatment;
  String? taxTreatment;
  bool? isPreGst;
  String? pricebookId;
  String? pricebookName;
  bool? isReverseChargeApplied;
  int? unusedCreditsPayableAmount;
  String? status;
  int? paymentTerms;
  String? paymentTermsLabel;
  DateTime? paymentExpectedDate;
  String? referenceNumber;
  String? recurringBillId;
  String? dueByDays;
  int? dueInDays;
  String? currencyId;
  String? currencyCode;
  String? currencySymbol;
  List<dynamic>? documents;
  int? pricePrecision;
  double? exchangeRate;
  double? adjustment;
  String? adjustmentDescription;
  List<dynamic>? customFields;
  bool? isTdsApplied;
  bool? isItemLevelTaxCalc;
  bool? isInclusiveTax;
  String? filedInVatReturnId;
  String? filedInVatReturnName;
  String? filedInVatReturnType;
  String? isAbnQuoted;
  List<BillLineItemDTO>? lineItems;
  int? subTotal;
  int? taxTotal;
  int? total;
  int? paymentMade;
  int? vendorCreditsApplied;
  bool? isLineItemInvoiced;
  List<dynamic>? purchaseorders;
  List<dynamic>? taxes;
  List<dynamic>? acquisitionVatSummary;
  double? acquisitionVatTotal;
  List<dynamic>? reverseChargeVatSummary;
  double? reverseChargeVatTotal;
  int? balance;
  Map<String, dynamic>? billingAddress;
  List<dynamic>? payments;
  List<dynamic>? vendorCredits;
  String? createdTime;
  String? createdById;
  String? lastModifiedTime;
  String? referenceId;
  String? notes;
  String? terms;
  String? attachmentName;
  int? openPurchaseordersCount;

  BillDTO({
    required this.vendorId,
    required this.billNumber,
    this.billId,
    this.date,
    this.dueDate,
    this.purchaseorderIds,
    this.vendorName,
    this.vatTreatment,
    this.vatRegNo,
    this.sourceOfSupply,
    this.destinationOfSupply,
    this.placeOfSupply,
    this.permitNumber,
    this.gstNo,
    this.gstTreatment,
    this.taxTreatment,
    this.isPreGst,
    this.pricebookId,
    this.pricebookName,
    this.isReverseChargeApplied,
    this.unusedCreditsPayableAmount,
    this.status,
    this.paymentTerms,
    this.paymentTermsLabel,
    this.paymentExpectedDate,
    this.referenceNumber,
    this.recurringBillId,
    this.dueByDays,
    this.dueInDays,
    this.currencyId,
    this.currencyCode,
    this.currencySymbol,
    this.documents,
    this.pricePrecision,
    this.exchangeRate,
    this.adjustment,
    this.adjustmentDescription,
    this.customFields,
    this.isTdsApplied,
    this.isItemLevelTaxCalc,
    this.isInclusiveTax,
    this.filedInVatReturnId,
    this.filedInVatReturnName,
    this.filedInVatReturnType,
    this.isAbnQuoted,
    this.lineItems,
    this.subTotal,
    this.taxTotal,
    this.total,
    this.paymentMade,
    this.vendorCreditsApplied,
    this.isLineItemInvoiced,
    this.purchaseorders,
    this.taxes,
    this.acquisitionVatSummary,
    this.acquisitionVatTotal,
    this.reverseChargeVatSummary,
    this.reverseChargeVatTotal,
    this.balance,
    this.billingAddress,
    this.payments,
    this.vendorCredits,
    this.createdTime,
    this.createdById,
    this.lastModifiedTime,
    this.referenceId,
    this.notes,
    this.terms,
    this.attachmentName,
    this.openPurchaseordersCount,
  }) {
    // Add validation checks here
    _validateBillNumberLength(billNumber);
    _validateNonNegativeValue(exchangeRate, 'exchangeRate');
    _validateNonNegativeValue(subTotal, 'subTotal');
    _validateNonNegativeValue(total, 'total');
  }

  void _validateBillNumberLength(String number) {
    if (number.length > 50) {
      throw ArgumentError('Bill number must be at most 50 characters long.');
    }
  }

  void _validateNonNegativeValue(dynamic value, String fieldName) {
    if (value == null) return;
    if (value < 0) {
      throw ArgumentError('$fieldName must be a non-negative value.');
    }
  }

  // Convert a BillDTO instance to a JSON object
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    data['vendor_id'] = vendorId;
    data['bill_number'] = billNumber;

    // Add to map only if not null
    if (date != null) data['date'] = DateFormat('yyyy-MM-d').format(date!);
    if (dueDate != null) data['due_date'] = DateFormat('yyyy-MM-d').format(dueDate!);
    
    if (billId != null) data['bill_id'] = billId;
    if (purchaseorderIds != null) data['purchaseorder_ids'] = purchaseorderIds;
    if (vendorName != null) data['vendor_name'] = vendorName;
    if (vatTreatment != null) data['vat_treatment'] = vatTreatment;
    if (vatRegNo != null) data['vat_reg_no'] = vatRegNo;
    if (sourceOfSupply != null) data['source_of_supply'] = sourceOfSupply;
    if (destinationOfSupply != null) data['destination_of_supply'] = destinationOfSupply;
    if (placeOfSupply != null) data['place_of_supply'] = placeOfSupply;
    if (permitNumber != null) data['permit_number'] = permitNumber;
    if (gstNo != null) data['gst_no'] = gstNo;
    if (gstTreatment != null) data['gst_treatment'] = gstTreatment;
    if (taxTreatment != null) data['tax_treatment'] = taxTreatment;
    if (isPreGst != null) data['is_pre_gst'] = isPreGst;
    if (pricebookId != null) data['pricebook_id'] = pricebookId;
    if (pricebookName != null) data['pricebook_name'] = pricebookName;
    if (isReverseChargeApplied != null) data['is_reverse_charge_applied'] = isReverseChargeApplied;
    if (unusedCreditsPayableAmount != null) data['unused_credits_payable_amount'] = unusedCreditsPayableAmount;
    if (status != null) data['status'] = status;
    if (paymentTerms != null) data['payment_terms'] = paymentTerms;
    if (paymentTermsLabel != null) data['payment_terms_label'] = paymentTermsLabel;
    if (paymentExpectedDate != null) data['payment_expected_date'] = DateFormat('yyyy-MM-d').format(paymentExpectedDate!);
    if (referenceNumber != null) data['reference_number'] = referenceNumber;
    if (recurringBillId != null) data['recurring_bill_id'] = recurringBillId;
    if (dueByDays != null) data['due_by_days'] = dueByDays;
    if (dueInDays != null) data['due_in_days'] = dueInDays;
    if (currencyId != null) data['currency_id'] = currencyId;
    if (currencyCode != null) data['currency_code'] = currencyCode;
    if (currencySymbol != null) data['currency_symbol'] = currencySymbol;
    if (documents != null) data['documents'] = documents;
    if (pricePrecision != null) data['price_precision'] = pricePrecision;
    if (exchangeRate != null) data['exchange_rate'] = exchangeRate;
    if (adjustment != null) data['adjustment'] = adjustment;
    if (adjustmentDescription != null) data['adjustment_description'] = adjustmentDescription;
    if (customFields != null) data['custom_fields'] = customFields;
    if (isTdsApplied != null) data['is_tds_applied'] = isTdsApplied;
    if (isItemLevelTaxCalc != null) data['is_item_level_tax_calc'] = isItemLevelTaxCalc;
    if (isInclusiveTax != null) data['is_inclusive_tax'] = isInclusiveTax;
    if (filedInVatReturnId != null) data['filed_in_vat_return_id'] = filedInVatReturnId;
    if (filedInVatReturnName != null) data['filed_in_vat_return_name'] = filedInVatReturnName;
    if (filedInVatReturnType != null) data['filed_in_vat_return_type'] = filedInVatReturnType;
    if (isAbnQuoted != null) data['is_abn_quoted'] = isAbnQuoted;
    if (lineItems != null) data['line_items'] = lineItems!.map((item) => item.toJson()).toList();
    if (subTotal != null) data['sub_total'] = subTotal;
    if (taxTotal != null) data['tax_total'] = taxTotal;
    if (total != null) data['total'] = total;
    if (paymentMade != null) data['payment_made'] = paymentMade;
    if (vendorCreditsApplied != null) data['vendor_credits_applied'] = vendorCreditsApplied;
    if (isLineItemInvoiced != null) data['is_line_item_invoiced'] = isLineItemInvoiced;
    if (purchaseorders != null) data['purchaseorders'] = purchaseorders;
    if (taxes != null) data['taxes'] = taxes;
    if (acquisitionVatSummary != null) data['acquisition_vat_summary'] = acquisitionVatSummary;
    if (acquisitionVatTotal != null) data['acquisition_vat_total'] = acquisitionVatTotal;
    if (reverseChargeVatSummary != null) data['reverse_charge_vat_summary'] = reverseChargeVatSummary;
    if (reverseChargeVatTotal != null) data['reverse_charge_vat_total'] = reverseChargeVatTotal;
    if (balance != null) data['balance'] = balance;
    if (billingAddress != null) data['billing_address'] = billingAddress;
    if (payments != null) data['payments'] = payments;
    if (vendorCredits != null) data['vendor_credits'] = vendorCredits;
    if (createdTime != null) data['created_time'] = createdTime;
    if (createdById != null) data['created_by_id'] = createdById;
    if (lastModifiedTime != null) data['last_modified_time'] = lastModifiedTime;
    if (referenceId != null) data['reference_id'] = referenceId;
    if (notes != null) data['notes'] = notes;
    if (terms != null) data['terms'] = terms;
    if (attachmentName != null) data['attachment_name'] = attachmentName;
    if (openPurchaseordersCount != null) data['open_purchaseorders_count'] = openPurchaseordersCount;
    
    return data;
  }
}
