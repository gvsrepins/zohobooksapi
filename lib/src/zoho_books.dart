import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:oauth2/oauth2.dart' as oauth2;

class OauthClient {
  
  // The authorization server's endpoint.
  final Uri authorizationEndpoint =
      Uri.parse('https://accounts.zoho.com/oauth/v2/token');
 
  final String identifier;
  final String secret;

  List<String> _scopes = <String>['ZohoBooks.fullaccess.all'];

  oauth2.Client? oauthClient;

  // Instantiate the OauthClient
  OauthClient({required this.identifier, required this.secret});

  // Setup the Oauth2 client
  Future<oauth2.Client?> _createOauthClient() async {
    
    if (oauthClient != null) {
      return oauthClient;
    }

    return await oauth2.clientCredentialsGrant(
      authorizationEndpoint, 
      identifier, 
      secret, 
      scopes: _scopes
    );
  }
  
  //Get the Oauth client
  Future<oauth2.Client?> getOauthClient() async {
      return _createOauthClient();
  }

  // Set the scopes
  set scopes(List<String> scopes) {
    _scopes = scopes;
  }

}