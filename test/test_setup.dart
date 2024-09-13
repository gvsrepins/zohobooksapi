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
  // Code that runs once before all tests
  setUpAll(() {
    var env = DotEnv(includePlatformEnvironment: true)..load(['test/.env']);

    identifier = String.fromEnvironment('ZOHO_API_IDENTIFIER').isEmpty
        ? env['ZOHO_API_IDENTIFIER']
        : String.fromEnvironment('ZOHO_API_IDENTIFIER');

    secret =
        String.fromEnvironment('ZOHO_API_SECRET').isEmpty
            ? env['ZOHO_API_SECRET']
            : String.fromEnvironment('ZOHO_API_SECRET');
            
    organizationId =
        String.fromEnvironment('ORGANIZATION_ID').isEmpty
            ? env['ORGANIZATION_ID']
            : String.fromEnvironment('ORGANIZATION_ID');

    region = Region.US;
    scopes = ['ZohoBooks.fullaccess.all'];

    // Create a cassette to handle HTTP interactions
    var cassette = Cassette("test/cassettes", "zoho_books");
    // create an DartVCRClient using the cassette
    clientVCR = DartVCRClient(cassette, Mode.auto);

    oauthClientProvider = OauthClientProvider(
      identifier: identifier!,
      secret: secret!,
      region: region,
      scopes: scopes,
      httpClient: clientVCR,
    );
  });

  // Common setup code that runs before each test
  setUp(() {});

  // Common teardown code that runs after each test
  tearDown(() {});

  // Code that runs once after all tests
  tearDownAll(() {});
}
