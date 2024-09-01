import 'package:oauth2/oauth2.dart' as oauth2;
import 'package:zohobooks_api/zohoboks_api.dart';

class ZohoBooks {
  late final oauth2.Client oauthClient;
  final String organizationId;

  //modules
  late Project projects;

  ZohoBooks({required this.oauthClient, required this.organizationId}){
    projects = Project(oauthClient, organizationId);
  }

  Future<void> getContacts() async {
    // Once you have a Client, you can use it just like any other HTTP client.
    print(await oauthClient.read(Uri.parse('https://www.zohoapis.com/books/v3/contacts?organization_id=$organizationId')));
  }

}