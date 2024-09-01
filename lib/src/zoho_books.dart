import 'package:oauth2/oauth2.dart' as oauth2;
import 'package:zohobooks_api/zohoboks_api.dart';

class ZohoBooks {
  late final oauth2.Client oauthClient;
  final String organizationId;

  //modules
  late Project _project;

  Project get project => _project;

  set project(Project value) {
    _project = value;
  }

  ZohoBooks({required this.oauthClient, required this.organizationId}){
    _project = Project(oauthClient, organizationId);
  }

  Future<void> getContacts() async {
    // Once you have a Client, you can use it just like any other HTTP client.
    print(await oauthClient.read(Uri.parse('https://www.zohoapis.com/books/v3/contacts?organization_id=$organizationId')));
  }

}