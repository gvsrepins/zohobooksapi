import 'package:test/test.dart';
import 'package:oauth2/oauth2.dart' as oauth2;
import 'package:zoho_api/src/enums/region.dart';
import 'package:zoho_api/src/oauth_client.dart';
import 'package:dotenv/dotenv.dart';

void main() {
  var env = DotEnv(includePlatformEnvironment: true)..load(['test/.env']);

  late String identifier;
  late String secret;
  late Region region;
  late List<String> scopes;

  setUp(() async {
    env = DotEnv(includePlatformEnvironment: true)..load(['test/.env']);
    identifier = env['ZOHO_API_IDENTIFIER']!;
    secret = env['ZOHO_API_SECRET']!;   
    region = Region.US;
    scopes = ['ZohoBooks.fullaccess.all']; 
  });

  group('OauthClient', () {

    test('should create an instance of OauthClient', () {
      final oauthClient = OauthClient(
        identifier: identifier,
        secret: secret,
        region: region,
        scopes: scopes,
      );

      expect(oauthClient, isA<OauthClient>());
      expect(oauthClient.identifier, identifier);
      expect(oauthClient.secret, secret);
      expect(oauthClient.region, region);      
    });

    test('should set scopes', () {
      final oauthClient = OauthClient(
        identifier: identifier,
        secret: secret,
        region: region,
        scopes: scopes,
      );

      final newScopes = ['scope1', 'scope2'];
      oauthClient.scopes = newScopes;

      expect(oauthClient.scopes, newScopes);
    });

    test('should create oauth2 client', () async {
      final oauthClient = OauthClient(
        identifier: identifier,
        secret: secret,
        region: region,
        scopes: scopes,
      );

      final client = await oauthClient.getClient();    
      expect(client, isA<oauth2.Client>()); 

    });
  });
}