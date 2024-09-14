import 'package:test/test.dart';
import 'package:dartvcr/dartvcr.dart';
import 'package:zohobooks_api/zohoboks_api.dart';
import 'package:dotenv/dotenv.dart';

late String? identifier;
late String? secret;
late String? organizationId;

late Region region;
late List<String> scopes;
late DartVCRClient clientVCR;
late OauthClientProvider oauthClientProvider;

void main() {
  var env = DotEnv(includePlatformEnvironment: true)..load(['test/.env']);

  region = Region.US;
  clientVCR = createVCRClient("zoho_books");
  scopes = ['ZohoBooks.fullaccess.all'];
  secret = getEnvironmentVariable(env, 'ZOHO_API_SECRET');
  identifier = getEnvironmentVariable(env, 'ZOHO_API_IDENTIFIER');
  organizationId = getEnvironmentVariable(env, 'ORGANIZATION_ID');

  // Code that runs once before all tests
  setUpAll(() {});

  // Common setup code that runs before each test
  setUp(() {
    oauthClientProvider = OauthClientProvider(
      identifier: identifier!,
      secret: secret!,
      region: region,
      scopes: scopes,
      httpClient: clientVCR,
    );
  });

  // Common teardown code that runs after each test
  tearDown(() {});

  // Code that runs once after all tests
  tearDownAll(() {});
}

DartVCRClient createVCRClient(String cassetteName) {
  // Create a cassette to handle HTTP interactions
  var cassette = Cassette("test/cassettes", cassetteName);

  // Hide the Authorization header
  var censors = Censors().censorHeaderElementsByKeys(["authorization"]);
  // Hide the access_token element (case sensitive) in the request and response body
  censors
      .censorBodyElements([CensorElement("access_token", caseSensitive: true)]);

  var advancedOptions = AdvancedOptions(censors: censors);

  // create an DartVCRClient using the cassette
  return DartVCRClient(cassette, Mode.auto, advancedOptions: advancedOptions);
}

String? getEnvironmentVariable(DotEnv env, String key) {
  return String.fromEnvironment(key).isEmpty
      ? env[key]
      : String.fromEnvironment(key);
}
