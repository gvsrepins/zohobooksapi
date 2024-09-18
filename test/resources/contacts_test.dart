import 'dart:convert';

import 'package:test/test.dart';
import 'package:faker/faker.dart';
import '../test_setup.dart' as setup;
import 'package:http/http.dart' as http;
import 'package:zohobooks_api/zohoboks_api.dart';

void main() {
  setup.main();
  setup.cassettePath = 'contacts';

  group('Contacts resource', () {
    test('should create a new contact', () async {
      //WHEN
      var contacts = await prepareContactsVCRClient('contacts_create');
      var response = await createNewContact(contacts);
      var contactCreated = json.decode(response.body);
      var contactId = contactCreated['contact']['contact_id'].toString();

      //THEN
      var decodeResponse = json.decode(response.body);
      expect(response, isA<http.Response>());
      expect(response.statusCode, equals(201));
      expect(decodeResponse['code'], 0);
      expect(decodeResponse['message'], 'The contact has been added.');

      //delete the contact
      await contacts.destroy(contactId);
    });

    test('should get a list of contacts', () async {
      //GIVEN
      var contacts = await prepareContactsVCRClient('contacts_all');
      var contactResponse = await createNewContact(contacts);
      var contactId =
          json.decode(contactResponse.body)['contact']['contact_id'].toString();

      //WHEN
      final response = await contacts.all(queryParameters: {
        'sort_column': 'contact_name',
        'sort_order': 'A',
      });

      //THEN
      expect(response, isA<http.Response>());
      expect(response.statusCode, equals(200));

      var decodeResponse = json.decode(response.body);
      expect(decodeResponse['code'], 0);
      expect(decodeResponse['message'], 'success');
      expect(decodeResponse['contacts'].length, greaterThan(0));
      expect(decodeResponse['page_context']['sort_column'], 'contact_name');
      expect(decodeResponse['page_context']['sort_order'], 'A');

      //delete the contact
      await contacts.destroy(contactId);
    });

    test('should update a contact', () async {
      //GIVEN
      var contacts = await prepareContactsVCRClient('contacts_update');
      var contactResponse = await createNewContact(contacts);
      var contactCreated = json.decode(contactResponse.body);
      var contactId = contactCreated['contact']['contact_id'].toString();

      //WHEN
      final contact = ContactDTO({
        'contact_id': contactId,
        'contact_name': 'Updated Contact Name',
        'company_name': 'Updated Company Name',
      });
      final response = await contacts.update(contactId, contact);

      //THEN
      var decodeResponse = json.decode(response.body);
      expect(response, isA<http.Response>());
      expect(response.statusCode, equals(200));
      expect(decodeResponse['code'], 0);
      expect(decodeResponse['message'], 'Contact information has been saved.');
      expect(decodeResponse['contact']['contact_name'], 'Updated Contact Name');
      expect(decodeResponse['contact']['company_name'], 'Updated Company Name');

      //delete the contact
      await contacts.destroy(contactId);
    });

    test('should find one contact', () async {
      //GIVEN
      var contacts = await prepareContactsVCRClient('contacts_find');
      var contactResponse = await createNewContact(contacts);
      var contactCreated = json.decode(contactResponse.body);
      var contactId = contactCreated['contact']['contact_id'].toString();

      //WHEN
      final response = await contacts.find(contactId);

      //THEN
      var decodeResponse = json.decode(response.body);
      expect(response, isA<http.Response>());
      expect(response.statusCode, equals(200));
      expect(decodeResponse['code'], 0);
      expect(decodeResponse['message'], 'success');
      expect(decodeResponse['contact']['contact_id'], contactId);

      //delete the contact
      await contacts.destroy(contactId);
    });

    test('should activate a contact', () async {
      //GIVEN
      var contacts = await prepareContactsVCRClient('contacts_activate');
      var contactResponse = await createNewContact(contacts);
      var contactCreated = json.decode(contactResponse.body);
      var contactId = contactCreated['contact']['contact_id'].toString();

      //WHEN
      final response = await contacts.activate(contactId);

      //THEN
      var decodeResponse = json.decode(response.body);
      expect(response, isA<http.Response>());
      expect(response.statusCode, equals(200));
      expect(decodeResponse['code'], 0);
      expect(decodeResponse['message'], 'The contact has been marked as active.');

      //delete the contact
      await contacts.destroy(contactId);
    });

    test('should inactivate a contact', () async {
      //GIVEN
      var contacts = await prepareContactsVCRClient('contacts_inactivate');
      var contactResponse = await createNewContact(contacts);
      var contactCreated = json.decode(contactResponse.body);
      var contactId = contactCreated['contact']['contact_id'].toString();

      //WHEN
      final response = await contacts.inactivate(contactId);

      //THEN
      var decodeResponse = json.decode(response.body);
      expect(response, isA<http.Response>());
      expect(response.statusCode, equals(200));
      expect(decodeResponse['code'], 0);
      expect(decodeResponse['message'], 'The contact has been marked as inactive.');

      //delete the contact
      await contacts.destroy(contactId);
    });

    test('should destroy a contact', () async {
      //GIVEN
      var contacts = await prepareContactsVCRClient('contacts_destroy');
      var contactResponse = await createNewContact(contacts);
      var contactCreated = json.decode(contactResponse.body);
      var contactId = contactCreated['contact']['contact_id'].toString();

      //WHEN
      final response = await contacts.destroy(contactId);

      //THEN
      var decodeResponse = json.decode(response.body);
      expect(response, isA<http.Response>());
      expect(response.statusCode, equals(200));
      expect(decodeResponse['code'], 0);
      expect(decodeResponse['message'], 'The customer has been deleted.');
    });
  });
}

Future<http.Response> createNewContact(contacts) async {
  var contact = ContactDTO({
    'contact_name': 'Contact for ${faker.company.name()}',
    'company_name': faker.company.name(),
    'contact_type': 'customer',
    'payment_terms': 15,
    'language_code': 'en',
  });

  return await contacts.create(contact);
}

Future<Contacts> prepareContactsVCRClient(cassetteName) async {
  setup.clientVCR = setup.createVCRClient(cassetteName);
  //authenticate
  var client =
      await setup.oauthClientProvider.init(overrideHttpClient: setup.clientVCR);
  return Contacts(client, setup.organizationId!);
}
