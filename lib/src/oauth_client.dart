import 'dart:async';
import 'package:oauth2/oauth2.dart' as oauth2;
import 'package:zoho_api/src/enums/region.dart';

class OauthClient {
  
  // The authorization server's endpoint.
  final Uri authorizationEndpoint =
      Uri.parse('https://accounts.zoho.com/oauth/v2/token');
 
  final String identifier;
  final String secret;
  final Region region;

  List<String> _scopes = <String>['ZohoBooks.fullaccess.all'];

  oauth2.Client? oauthClient;

  // Instantiate the OauthClient
  OauthClient({
    required this.identifier,
    required this.secret,
    this.region=Region.US,
    List<String>? scopes
  }){
    oauthClient = null;
  }

  // Setup the Oauth2 client
  Future<oauth2.Client?> _createOauthClient() async {
    
    if (_outhClientExists) {
      return oauthClient;
    }

    return await oauth2.clientCredentialsGrant(
      authorizationEndpoint, 
      identifier, 
      secret, 
      scopes: _scopes
    );
  }

  bool get _outhClientExists => oauthClient != null;
  
  //Get the Oauth client
  Future<oauth2.Client?> getClient() async {
      return _createOauthClient();
  }

  // Get the scopes
  List<String> get scopes {
    return _scopes;
  }

  // Set the scopes
  set scopes(List<String> scopes) {
    _scopes = scopes;
  }

}