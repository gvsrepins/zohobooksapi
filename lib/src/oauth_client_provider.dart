import 'dart:async';
import 'package:oauth2/oauth2.dart' as oauth2;
import 'package:zohobooks_api/src/enums/region.dart';
import 'package:http/http.dart' as http;

class OauthClientProvider {
  
  // The authorization server's endpoint.
  final Uri authorizationEndpoint =
      Uri.parse('https://accounts.zoho.com/oauth/v2/token');
 
  final String identifier;
  final String secret;
  final Region region;

  http.Client? httpClient;
  List<String> scopes = <String>['ZohoBooks.fullaccess.all'];

  // Instantiate the OauthClient
  OauthClientProvider({
    required this.identifier,
    required this.secret,
    this.region=Region.US,
    List<String>? scopes,
    http.Client? httpClient
  }){
    this.scopes = scopes ?? this.scopes;
    this.httpClient = httpClient ?? this.httpClient;
  }

  // Setup the Oauth2 client
  Future<oauth2.Client> _init(http.Client? overrideHttpClient) async {
    return await oauth2.clientCredentialsGrant(
      authorizationEndpoint, 
      identifier, 
      secret, 
      scopes: scopes,
      httpClient: overrideHttpClient ?? httpClient
    );
  }
  
  //Get the Oauth client
  Future<oauth2.Client> init({http.Client? overrideHttpClient}) async {    
    return _init(overrideHttpClient);
  }

}