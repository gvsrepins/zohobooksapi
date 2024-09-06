import 'dart:convert';
import 'package:oauth2/oauth2.dart' as oauth2;
import 'package:http/http.dart' as http;

class BaseResource {

  final oauth2.Client httpClient;
  final String organizationId;

  Map<String,dynamic> pageContextQueryParameters = {
    'page': '1',
    'per_page': '100',
  };

  final String resourceName = '';
  final String resourcPath = '';
  final String baseUrl = 'https://www.zohoapis.com/books/v3';

  BaseResource(this.httpClient, this.organizationId);

  // Helper method for preparing the URL
  Uri prepareUrl({
    String resourcePath = '',
    Map<String, dynamic>? queryParameters,
  }) {
    
    var finalResourcePath =
        resourcePath.isNotEmpty ? resourcePath : this.resourcPath;

    Uri baseUri = Uri.parse(baseUrl);
    
    List<String> pathSegments = [
      ...baseUri.pathSegments,
      resourceName,
      finalResourcePath
    ];

    queryParameters ??= {};
    queryParameters['organization_id'] = organizationId;
    queryParameters.addAll(pageContextQueryParameters);

    return baseUri.replace(
      pathSegments: pathSegments,
      queryParameters: queryParameters,
    );
  }

  Future<http.Response> post(uri, Map<String, dynamic> data) async {
    return await httpClient.post(uri, body: json.encoder.convert(data));
  }

  Future<http.Response> put(uri, Map<String, dynamic> data) async {
    return await httpClient.put(uri, body: json.encoder.convert(data));
  }

  Future<http.Response> get(uri) async {
    return await httpClient.get(uri);
  }

  Future<http.Response> delete(uri) async {
    return await httpClient.delete(uri);
  }
}
