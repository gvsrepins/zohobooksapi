import 'package:test/test.dart';
import 'test_setup.dart' as setup;
import 'package:oauth2/oauth2.dart' as oauth2;
import 'package:zohobooks_api/zohoboks_api.dart';

void main() {
  setup.main();

  group('OauthClient', () {

    test('should create an instance of OauthClient', () {
      expect(setup.oauthClientProvider, isA<OauthClientProvider>());
      expect(setup.oauthClientProvider.identifier, setup.identifier);
      expect(setup.oauthClientProvider.secret, setup.secret);
      expect(setup.oauthClientProvider.region, setup.region);
      expect(setup.oauthClientProvider.scopes, setup.scopes);
      expect(setup.oauthClientProvider.httpClient, setup.clientVCR);
    });

    test('should set scopes', () {
      final newScopes = ['scope1', 'scope2'];
      setup.oauthClientProvider.scopes = newScopes;
      expect(setup.oauthClientProvider.scopes, newScopes);
    });

    test('should create oauth2 client', () async {

      var oauthClient = await setup.oauthClientProvider.init();
      expect(oauthClient, isA<oauth2.Client>()); 
    });
  });
}