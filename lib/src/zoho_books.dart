import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:oauth2/oauth2.dart' as oauth2;

class ZohoBooks {
  
  // The authorization server's endpoint.
  final Uri authorizationEndpoint =
      Uri.parse('https://accounts.zoho.com/oauth/v2/token');
 
  final String identifier;
  final String secret;

  final List<String> scopes = <String>['ZohoBooks.fullaccess.all'];

  oauth2.Client? oauthClient;

  /// A file in which the users credentials are stored persistently. If the server
  /// issues a refresh token allowing the client to refresh outdated credentials
  final credentialsFile = File('./credentials.json');

  // Constructor
  ZohoBooks({required this.identifier, required this.secret}) {
    createOauthClient();
  }

  // Setup the Oauth client
  Future<oauth2.Client?> createOauthClient() async {
    
    if (oauthClient != null) {
      return oauthClient;
    }

    oauthClient =  await oauth2.clientCredentialsGrant(
      authorizationEndpoint, 
      identifier, 
      secret, 
      scopes: scopes
    );

    writeCredentialsToFile(oauthClient!.credentials);

    return oauthClient;
  }
  
  //Get the client
  Future<oauth2.Client?> getOauthClient() async{
      return createOauthClient();
  }

    // Load the client's credentials from the file
    reloadCredentialsFromFile() {
          
      var exists = credentialsFile.existsSync();

      if (exists) {
        var credentials = oauth2.Credentials.fromJson(
          json.decode(credentialsFile.readAsStringSync())
        );

        return oauthClient = oauth2.Client(credentials, identifier: identifier, secret: secret);  
      }
    }

  // Write the client's credentials to the file
  Future<void> writeCredentialsToFile(oauth2.Credentials credentials) async {
    try {
      await credentialsFile.writeAsString(credentials.toJson());
    } catch (e) {
      print('Error writing credentials to file: $e');
    }
  }

}