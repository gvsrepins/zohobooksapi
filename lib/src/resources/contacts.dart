import 'package:zohobooks_api/zohoboks_api.dart';
import 'package:http/http.dart' as http;

class Contacts extends BaseResource {
  Contacts(super.httpClient, super.organizationId);

  @override
  String get resourceName => 'contacts';

  // POST /contacts
  Future<http.Response> create(ContactDTO contact) async {
    var uri = super.prepareUrl();
    return post(uri, contact.toJson());
  }

  // PUT /contacts
  // Future<http.Response> updateBulk(List<ContactDTO> contacts) async {
  //   var uri = super.prepareUrl();
  //   return put(uri, contacts.map((c) => c.toJson()).toList());
  // }

  // GET /contacts
  Future<http.Response> all({Map<String, dynamic> queryParameters = const {}}) async {
    var uri = super.prepareUrl(queryParameters: queryParameters);
    return get(uri);
  }

  // PUT /contacts/{contact_id}
  Future<http.Response> update(String contactId, ContactDTO contact) async {
    var uri = super.prepareUrl(pathSegment: contactId);
    return put(uri, contact.toJson());
  }

  // GET /contacts/{contact_id}
  Future<http.Response> find(String contactId) async {
    var uri = super.prepareUrl(pathSegment: contactId);
    return get(uri);
  }

  // DELETE /contacts/{contact_id}
  Future<http.Response> destroy(String contactId) async {
    var uri = super.prepareUrl(pathSegment: contactId);
    return delete(uri);
  }

  // POST /contacts/{contact_id}/active
  Future<http.Response> activate(String contactId) async {
    var uri = super.prepareUrl(pathSegment: '$contactId/active');
    return post(uri, {});
  }

  // POST /contacts/{contact_id}/inactive
  Future<http.Response> inactivate(String contactId) async {
    var uri = super.prepareUrl(pathSegment: '$contactId/inactive');
    return post(uri, {});
  }

  // POST /contacts/{contact_id}/portal/enable
  Future<http.Response> enablePortal(String contactId) async {
    var uri = super.prepareUrl(pathSegment: '$contactId/portal/enable');
    return post(uri, {});
  }

  // POST /contacts/{contact_id}/paymentreminder/enable
  Future<http.Response> enablePaymentReminder(String contactId) async {
    var uri = super.prepareUrl(pathSegment: '$contactId/paymentreminder/enable');
    return post(uri, {});
  }

  // POST /contacts/{contact_id}/paymentreminder/disable
  Future<http.Response> disablePaymentReminder(String contactId) async {
    var uri = super.prepareUrl(pathSegment: '$contactId/paymentreminder/disable');
    return post(uri, {});
  }

  // POST /contacts/{contact_id}/statements/email
  Future<http.Response> emailStatements(String contactId, Map<String, dynamic> data) async {
    var uri = super.prepareUrl(pathSegment: '$contactId/statements/email');
    return post(uri, data);
  }

  // GET /contacts/{contact_id}/statements/email
  Future<http.Response> getStatementEmails(String contactId) async {
    var uri = super.prepareUrl(pathSegment: '$contactId/statements/email');
    return get(uri);
  }

  // POST /contacts/{contact_id}/email
  Future<http.Response> email(String contactId, Map<String, dynamic> data) async {
    var uri = super.prepareUrl(pathSegment: '$contactId/email');
    return post(uri, data);
  }

  // GET /contacts/{contact_id}/comments
  Future<http.Response> getComments(String contactId) async {
    var uri = super.prepareUrl(pathSegment: '$contactId/comments');
    return get(uri);
  }

  // POST /contacts/{contact_id}/address
  Future<http.Response> addAddress(String contactId, Map<String, dynamic> data) async {
    var uri = super.prepareUrl(pathSegment: '$contactId/address');
    return post(uri, data);
  }

  // GET /contacts/{contact_id}/address
  Future<http.Response> getAddresses(String contactId) async {
    var uri = super.prepareUrl(pathSegment: '$contactId/address');
    return get(uri);
  }

  // PUT /contacts/{contact_id}/address/{address_id}
  Future<http.Response> updateAddress(String contactId, String addressId, Map<String, dynamic> data) async {
    var uri = super.prepareUrl(pathSegment: '$contactId/address/$addressId');
    return put(uri, data);
  }

  // DELETE /contacts/{contact_id}/address/{address_id}
  Future<http.Response> deleteAddress(String contactId, String addressId) async {
    var uri = super.prepareUrl(pathSegment: '$contactId/address/$addressId');
    return delete(uri);
  }

  // GET /contacts/{contact_id}/refunds
  Future<http.Response> getRefunds(String contactId) async {
    var uri = super.prepareUrl(pathSegment: '$contactId/refunds');
    return get(uri);
  }

  // POST /contacts/{contact_id}/track1099
  Future<http.Response> track1099(String contactId) async {
    var uri = super.prepareUrl(pathSegment: '$contactId/track1099');
    return post(uri, {});
  }

  // POST /contacts/{contact_id}/untrack1099
  Future<http.Response> untrack1099(String contactId) async {
    var uri = super.prepareUrl(pathSegment: '$contactId/untrack1099');
    return post(uri, {});
  }
}
