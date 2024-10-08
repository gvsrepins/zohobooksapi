# Zoho Books API Dart Package

This Dart package provides an interface to interact with [Zoho Books API](https://www.zoho.com/books/api/v3/introduction/#overview) in server side communications.

It handles OAuth2 using [Client Credentials Flow](https://www.zoho.com/accounts/protocol/oauth/self-client/client-credentials-flow.html) authentication and provides methods to access various Zoho Books services.

## Features

- OAuth2 authentication with Zoho
- Easy-to-use interface for Zoho APIs

## Installation

Add the following to your `pubspec.yaml` file:

```yaml
dependencies:
  zohobooks_api:
    git: https://github.com/gvsrepins/zohobooksapi.git
```

Then run:

```bash
dart pub get
```

## Zoho Books Setup

### Self client

If you want your app to fetch data from your own Zoho account, or set up app-to-app communication in the backend without any user interaction, you can use the Self Client option. In this situation, you will be the resource owner and there will be no end-user authorization required. The client will request access permission on behalf of itself and not any end-user.

Follow the steps to set up Self Client:

#### Create a self client in API console

1. Go to the [Zoho API console](http://api-console.zoho.com/).
1. Click **GET STARTED**.
1. Hover over the *Self Client* option and click **CREATE NOW**.
1. Click **CREATE**, then click **OK**. A Client ID and Client Secret will be created and shown under the Client Secret tab. You can copy these.

## Usage

To use the Zoho Books API package, follow these steps:

1. Import the package:

   ```dart
   import 'package:zohobooks_api/zohoboks_api.dart';
   ```

1. Set up the OAuth client provider:

   ```dart
   var oauthProvider = OauthClientProvider(
      identifier: 'YOUR_CLIENT_ID',
      secret: 'YOUR_CLIENT_SECRET',
      region: Region.US,
      scopes: ['ZohoBooks.contacts.READ', 'ZohoBooks.contacts.WRITE']
   );
   ```

1. Initialize the ZohoBooks client:

   ```dart
   var zohoBooks = ZohoBooks(
      oauthClient: oauthProvider.getClient(),
      organizationId: 'YOUR_ORGANIZATION_ID'
   );
   ```

1. Use the API to interact with Zoho Books resources:

   ```dart
   //create a project
   var project = await zohoBooks.projects.create(ProjectDTO({
      'project_name': 'New Project Name',
      'customer_id': '5546603000000100003',
      'currency_code': 'USD',
      'description': 'A simple algorithm is to be tested with vehicle detection application.',
      'billing_type': 'fixed_cost_for_project',
      'rate': '500',
      'cost_budget_amount': '600.00',
      'user_id': 'INV-00003'
   }));

   //get all projects
   var response = await zohoBooks.projects.all(queryParameters: {
      'sort_column': 'project_name',
      'sort_order': 'A',
      'filter_by': 'Status.All',
   });      
   ```

### Running Tests

To run tests, use the following command:

```bash
dart test
```

## Roadmap

- [x] OAuth2
- [x] Base resources
- [x] Projects resources
- [x] Bills resources
- [x] Contacts resources
- [ ] Estimates resources
- [ ] Sales orders resources
- [ ] Invoices resources
- [ ] Recurring invoices resources
- [ ] Credit notes resources
- [ ] Customer payments resources
- [ ] Expenses resources
- [ ] Recurring expenses resources
- [ ] Purchase orders resources
- [ ] Vendor credits resources
- [ ] Vendor payments resources
- [ ] Bank accounts resources
- [ ] Bank transactions resources
- [ ] Bank rules resources
- [ ] Chart of accounts resources
- [ ] Journals resources
- [ ] Base currency adjustment resources
- [ ] Settings resources
- [ ] Organizations resources
- [ ] Items resources
- [ ] Users resources
- [ ] Import resources

## Contributing

We welcome contributions from developers of all skill levels! Here's how you can contribute to this project:

1. **Fork the Repository**: Click the 'Fork' button at the top right of this page and clone your fork to your local machine.

1. **Set Up the Project**:
   - Install Dart on your machine if you haven't already.
   - Run `dart pub get` to install dependencies.

1. **Create a New Branch**: Create a new branch for your feature or bug fix:

   ```shell
   git checkout -b your-branch-name
   ```

1. **Make Your Changes**: Implement your feature or fix the bug. Don't forget to add or update tests if necessary.

1. **Run Tests**: Ensure all tests pass by running:

   ```shell
   dart test
   ```

1. **Commit Your Changes**: Use clear and descriptive commit messages:

   ```shell
   git commit -m 'Add a brief description of your changes'
   ```

1. **Push to Your Fork**:

   ```shell
      git push origin your-branch-name
   ```

1. **Open a Pull Request**: Go to the original repository on GitHub and click 'New Pull Request'. Provide a clear description of your changes.

1. **Code Review**: Wait for a maintainer to review your changes. They may ask for some modifications.

If you're new to open source or have any questions, feel free to open an issue for guidance. We're here to help you get started!

Remember, no contribution is too small. Even fixing a typo is valuable!

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
