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
  zohobooks_api: ^1.0.0
```

Then run:

```bash
dart pub get
```

## Zoho Books Setup

#### Self client
If you want your app to fetch data from your own Zoho account, or set up app-to-app communication in the backend without any user interaction, you can use the Self Client option. In this situation, you will be the resource owner and there will be no end-user authorization required. The client will request access permission on behalf of itself and not any end-user.

Follow the steps to set up Self Client:

#### Create a self client in API console
1. Go to the [Zoho API console](http://api-console.zoho.com/). 
1. Click **GET STARTED**. 
1. Hover over the *Self Client* option and click **CREATE NOW**. 
1. Click **CREATE**, then click **OK**. A Client ID and Client Secret will be created and shown under the Client Secret tab. You can copy these.


## Usage

### Running Tests

To run tests, use the following command:

```bash
dart test
```

### Contributing

Contributions are welcome! Please open an issue or submit a pull request on GitHub.

### License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.