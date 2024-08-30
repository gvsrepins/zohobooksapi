import 'dart:async';
import 'package:oauth2/oauth2.dart' as oauth2;
import 'package:zohobooks_api/src/enums/region.dart';

class OauthClientProvider {
  
  // The authorization server's endpoint.
  final Uri authorizationEndpoint =
      Uri.parse('https://accounts.zoho.com/oauth/v2/token');
 
  final String identifier;
  final String secret;
  final Region region;

  late final oauth2.Client oauthClient;
  List<String> _scopes = <String>['ZohoBooks.fullaccess.all'];

  // Instantiate the OauthClient
  OauthClientProvider({
    required this.identifier,
    required this.secret,
    this.region=Region.US,
    List<String>? scopes
  });

  // Setup the Oauth2 client
  Future<oauth2.Client> _init() async {
    return await oauth2.clientCredentialsGrant(
      authorizationEndpoint, 
      identifier, 
      secret, 
      scopes: _scopes,
    );
  }
  
  //Get the Oauth client
  Future<oauth2.Client> init() async {
      return _init();
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