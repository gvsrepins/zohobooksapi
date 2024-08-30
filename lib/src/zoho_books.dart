import 'package:zoho_api/zoho_api.dart';
import 'package:oauth2/oauth2.dart' as oauth2;

class ZohoBooks {
  final OauthClientProvider oauthProvider;
  late final oauth2.Client oauthClient;
  final String organizationId;

  ZohoBooks({required this.oauthProvider, required this.organizationId});

  Future<void> getContacts() async {
    oauthClient = await oauthProvider.init();

    // Once you have a Client, you can use it just like any other HTTP client.
    print(await oauthClient.read(Uri.parse('https://www.zohoapis.com/books/v3/contacts?organization_id=$organizationId')));
  }
}