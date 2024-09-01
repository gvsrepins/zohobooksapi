import 'package:test/test.dart';
import 'package:oauth2/oauth2.dart' as oauth2;
import 'package:zohobooks_api/src/enums/region.dart';
import 'package:zohobooks_api/src/oauth_client.dart';
import 'package:dotenv/dotenv.dart';

void main() {
  //var env = DotEnv(includePlatformEnvironment: true)..load(['test/.env']);

  late String identifier;
  late String secret;
  late Region region;
  late List<String> scopes;

  setUp(() async {
    identifier = env['ZOHO_API_IDENTIFIER']!;
    secret = env['ZOHO_API_SECRET']!;   
    region = Region.US;
    scopes = ['ZohoBooks.fullaccess.all']; 
  });

  group('OauthClient', () {

    test('should create an instance of OauthClient', () {
      final oauthClient = OauthClientProvider(
        identifier: identifier,
        secret: secret,
        region: region,
        scopes: scopes,
      );

      expect(oauthClient, isA<OauthClientProvider>());
      expect(oauthClient.identifier, identifier);
      expect(oauthClient.secret, secret);
      expect(oauthClient.region, region);      
    });

    test('should set scopes', () {
      final oauthClient = OauthClientProvider(
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
      final oauthClient = OauthClientProvider(
        identifier: identifier,
        secret: secret,
        region: region,
        scopes: scopes,
      );

      final client = await oauthClient.init();    
      expect(client, isA<oauth2.Client>()); 

    });
  });
}