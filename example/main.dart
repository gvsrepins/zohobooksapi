import 'package:zoho_api/src/enums/region.dart';
import 'package:dotenv/dotenv.dart';
import 'package:zoho_api/zoho_api.dart';

Future<void> main() async {
  var env = DotEnv(includePlatformEnvironment: true)..load();

  final String identifier = env['ZOHO_API_IDENTIFIER']!;
  final String secret = env['ZOHO_API_SECRET']!;
  final String organizationId = env['ORGANIZATION_ID']!;

  var oauthClient = OauthClient(
    identifier: identifier,
    secret: secret,
    region: Region.US,
    scopes: ['ZohoBooks.fullaccess.all']
  );

  var zohoBooks =  ZohoBooks(oauthClient: oauthClient, organizationId: organizationId);
  zohoBooks.getContacts();

}