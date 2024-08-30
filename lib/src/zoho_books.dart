import 'package:zoho_api/zoho_api.dart';

class ZohoBooks {
  final OauthClient oauthClient;
  final String organizationId;

  ZohoBooks({required this.oauthClient, required this.organizationId});

  Future<void> getContacts() async {
    var oauthClient = await this.oauthClient.getClient();

    // Once you have a Client, you can use it just like any other HTTP client.
    print(await oauthClient!.read(Uri.parse('https://www.zohoapis.com/books/v3/contacts?organization_id=$organizationId')));
  }
}