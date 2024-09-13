import 'package:dotenv/dotenv.dart';
import 'package:zohobooks_api/zohoboks_api.dart';

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

  var project = ProjectDTO(
    projectName: "New Project Name",
    customerId: "5546603000000100003",
    currencyCode: "USD",
    description:
        "A simple algorithm is to be tested with vehicle detection application.",
    billingType: "fixed_cost_for_project",
    rate: "500",
    costBudgetAmount: 600.00,
    userId: "INV-00003",
  );

  print(project.toJson());

  // Clone project
  var response = await zohoBooks.projects.create(project);

  // response = await zohoBooks.projects.all(queryParameters: {
  //   'sort_column': 'project_name',
  //   'sort_order': 'A',
  //   'filter_by': 'Status.All',
  // });

  // Clone project
  // var response = await zohoBooks.projects.clone(
  //   '5546603000000108003',
  //   ProjectCloneDTO(projectName: 'REAL TIME TRAFFIC FLUX COPY')
  // );

  print(response.statusCode);
  print(response.body);
}
