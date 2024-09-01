import 'package:zohobooks_api/src/enums/region.dart';
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
    scopes: ['ZohoBooks.fullaccess.all']
  );

  var oauthClient = await oauthProvider.init();

  var zohoBooks =  ZohoBooks(
    oauthClient: oauthClient, 
    organizationId: organizationId
  );

  //zohoBooks.getContacts();

  zohoBooks.projects.create(
      projectName: "REAL TIME TRAFFIC FLUX",
      customerId: "460000000044001",
      currencyCode: "USD",
      description: "A simple algorithm is to be tested with vehicle detection application.",
      billingType: "fixed_cost_for_project",
      rate: "5000",
      costBudgetAmount: 1000.00,
      userId: "INV-00003",
      // tasks: [
      //   {
      //     "task_name": "Distribution Analysis",
      //     "description": "A simple algorithm is to be tested with vehicle detection application.",
      //     "rate": "5000",
      //     "budget_hours": "0"
      //   }
      // ],
      // users: [
      //   {
      //     "user_id": "460000000024003",
      //     "is_current_user": true,
      //     "user_name": "John David",
      //     "email": "johndavid@zilliuminc.com",
      //     "user_role": "admin",
      //     "status": "active",
      //     "rate": "5000",
      //     "budget_hours": "0",
      //     "cost_rate": "10.00"
      //   }
      // ],
    );
}