import 'package:zohobooks_api/zohoboks_api.dart';
import 'package:http/http.dart' as http;

//TODO: Add tests for Bills resource
class Bills extends BaseResource {
  
  Map<String, dynamic> queryParameters = {
    'sort_column': 'created_time',
    'sort_order': 'D',
    'filter_by': 'Status.All',
  };

  Bills(super.httpClient, super.organizationId);

  @override
  String get resourceName => 'bills';

  // OAuth Scope: ZohoBooks.bills.CREATE
  Future<http.Response> create(BillDTO bill) async {
    if (bill.billId != null) {
      throw ArgumentError('Bill ID cannot be set while creating a bill');
    }
    var uri = super.prepareUrl();
    return post(uri, bill.toJson());
  }

  // OAuth Scope: ZohoBooks.bills.UPDATE
  Future<http.Response> update(BillDTO bill) async {
    if (bill.billId == null) {
      throw ArgumentError('Bill ID is required');
    }
    var uri = super.prepareUrl(pathSegment: bill.billId);
    return await put(uri, bill.toJson());
  }

  // OAuth Scope: ZohoBooks.bills.READ
  Future<http.Response> all({Map<String, dynamic> queryParameters = const {}}) async {
    queryParameters = this.queryParameters..addAll(queryParameters);
    var uri = super.prepareUrl(queryParameters: queryParameters);
    return await get(uri);
  }

  // OAuth Scope: ZohoBooks.bills.READ
  Future<http.Response> find(String billId) async {
    var uri = super.prepareUrl(pathSegment: billId);
    return await get(uri);
  }

  // OAuth Scope: ZohoBooks.bills.DELETE
  Future<http.Response> destroy(String billId) async {
    var uri = super.prepareUrl(pathSegment: billId);
    return await delete(uri);
  }

  // OAuth Scope: ZohoBooks.bills.UPDATE
  Future<http.Response> updateCustomFields(String billId, Map<String, dynamic> data) async {
    var uri = super.prepareUrl(pathSegment: '$billId/customfields');
    return await put(uri, data);
  }

  // OAuth Scope: ZohoBooks.bills.UPDATE
  Future<http.Response> markAsVoid(String billId) async {
    var uri = super.prepareUrl(pathSegment: '$billId/status/void');
    return await post(uri, {});
  }

  // OAuth Scope: ZohoBooks.bills.UPDATE
  Future<http.Response> markAsOpen(String billId) async {
    var uri = super.prepareUrl(pathSegment: '$billId/status/open');
    return await post(uri, {});
  }

  // OAuth Scope: ZohoBooks.bills.UPDATE
  Future<http.Response> submit(String billId) async {
    var uri = super.prepareUrl(pathSegment: '$billId/submit');
    return await post(uri, {});
  }

  // OAuth Scope: ZohoBooks.bills.UPDATE
  Future<http.Response> approve(String billId) async {
    var uri = super.prepareUrl(pathSegment: '$billId/approve');
    return await post(uri, {});
  }

  // OAuth Scope: ZohoBooks.bills.UPDATE
  Future<http.Response> updateBillingAddress(String billId, Map<String, dynamic> data) async {
    var uri = super.prepareUrl(pathSegment: '$billId/address/billing');
    return await put(uri, data);
  }

  // OAuth Scope: ZohoBooks.bills.READ
  Future<http.Response> getPayments(String billId) async {
    var uri = super.prepareUrl(pathSegment: '$billId/payments');
    return await get(uri);
  }

  // OAuth Scope: ZohoBooks.bills.CREATE
  Future<http.Response> applyCredits(String billId, Map<String, dynamic> data) async {
    var uri = super.prepareUrl(pathSegment: '$billId/credits');
    return await post(uri, data);
  }

  // OAuth Scope: ZohoBooks.bills.DELETE
  Future<http.Response> deletePayment(String billId, String billPaymentId) async {
    var uri = super.prepareUrl(pathSegment: '$billId/payments/$billPaymentId');
    return await delete(uri);
  }

  // OAuth Scope: ZohoBooks.bills.CREATE
  Future<http.Response> addAttachment(String billId, Map<String, dynamic> data) async {
    var uri = super.prepareUrl(pathSegment: '$billId/attachment');
    return await post(uri, data);
  }

  // OAuth Scope: ZohoBooks.bills.READ
  Future<http.Response> getAttachment(String billId) async {
    var uri = super.prepareUrl(pathSegment: '$billId/attachment');
    return await get(uri);
  }

  // OAuth Scope: ZohoBooks.bills.DELETE
  Future<http.Response> deleteAttachment(String billId) async {
    var uri = super.prepareUrl(pathSegment: '$billId/attachment');
    return await delete(uri);
  }

  // OAuth Scope: ZohoBooks.bills.CREATE
  Future<http.Response> addComment(String billId, Map<String, dynamic> data) async {
    var uri = super.prepareUrl(pathSegment: '$billId/comments');
    return await post(uri, data);
  }

  // OAuth Scope: ZohoBooks.bills.READ
  Future<http.Response> getComments(String billId) async {
    var uri = super.prepareUrl(pathSegment: '$billId/comments');
    return await get(uri);
  }

  // OAuth Scope: ZohoBooks.bills.DELETE
  Future<http.Response> deleteComment(String billId, String commentId) async {
    var uri = super.prepareUrl(pathSegment: '$billId/comments/$commentId');
    return await delete(uri);
  }

  // OAuth Scope: ZohoBooks.bills.READ
  Future<http.Response> getEditPageFromPurchaseOrder() async {
    var uri = super.prepareUrl(pathSegment: 'editpage/frompurchaseorder');
    return await get(uri);
  }
}
