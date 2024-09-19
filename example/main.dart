import 'package:dotenv/dotenv.dart';
import 'package:zohobooks_api/zoho_books_api.dart';
import 'package:http/http.dart' as http;

Future<void> main() async {
  var env = DotEnv(includePlatformEnvironment: true)..load();

  final String identifier = env['ZOHO_API_IDENTIFIER']!;
  final String secret = env['ZOHO_API_SECRET']!;
  final String organizationId = env['ORGANIZATION_ID']!;

  var oauthProvider = OauthClientProvider(
      identifier: identifier,
      secret: secret,
      region: Region.US,
      scopes: ['ZohoBooks.fullaccess.all']);

  var oauthClient = await oauthProvider.init();

  var zohoBooks = ZohoBooks(
    oauthClient: oauthClient,
    organizationId: organizationId
  );

  var project = ProjectDTO({
    'project_name': "New Project Name",
    'customer_id': "5546603000000100003",
    'currency_code': "USD",
    'description':
        "A simple algorithm is to be tested with vehicle detection application.",
    'billing_type': "fixed_cost_for_project",
    'rate': "500",
    'cost_budget_amount': '600.00',
    'user_id': "INV-00003",
  });

  print(project.toJson());

  // Clone project
  //http.Response response = await zohoBooks.projects.create(project);
  //http.Response response = await zohoBooks.contacts.all();
  http.Response response = await zohoBooks.contacts.all(queryParameters: {
    'sort_column': 'contact_name',
    'sort_order': 'D',
    'filter_by': 'Status.All',
  });

  // Clone project
  // var response = await zohoBooks.projects.clone(
  //   '5546603000000108003',
  //   ProjectCloneDTO(projectName: 'REAL TIME TRAFFIC FLUX COPY')
  // );

  print(response.statusCode);
  print(response.body);
}
