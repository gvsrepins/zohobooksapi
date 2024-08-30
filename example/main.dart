import 'package:zoho_api/src/zoho_books.dart';
import 'package:dotenv/dotenv.dart';

Future<void> main() async {
  var env = DotEnv(includePlatformEnvironment: true)..load();

  final String identifier = env['ZOHO_API_IDENTIFIER']!;
  final String secret = env['ZOHO_API_SECRET']!;
  final String organizationId = env['ORGANIZATION_ID']!;

 
  var zohoBooks = OauthClient(identifier: identifier, secret: secret);
  zohoBooks.scopes = ['ZohoBooks.fullaccess.all'];

  var client = await zohoBooks.getOauthClient();

  // Once you have a Client, you can use it just like any other HTTP client.
  print(await client!.read(Uri.parse('https://www.zohoapis.com/books/v3/contacts?organization_id=$organizationId')));

}