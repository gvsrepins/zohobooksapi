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
  final String baseUrl = 'https://www.zohoapis.com/books/v3';

  BaseResource(this.httpClient, this.organizationId);

  // Helper method for preparing the URL
  Uri prepareUrl({
    String? pathSegment = '',
    Map<String, dynamic>? queryParameters,
  }) {
    
    Uri baseUri = Uri.parse(baseUrl);

    return baseUri.replace(
      pathSegments: _preparePathSegments(pathSegment, baseUri),
      queryParameters: _prepareQueryParameters(queryParameters)
    );
  }

  List<String> _preparePathSegments(String? pathSegment, Uri baseUri) {
  
    List<String> pathSegments = [
      ...baseUri.pathSegments,
      resourceName,
      pathSegment??''
    ];

    return pathSegments;
  }

  Map<String, dynamic>? _prepareQueryParameters(Map<String, dynamic>? queryParameters) {
    queryParameters ??= {};
    queryParameters['organization_id'] = organizationId;
    queryParameters.addAll(pageContextQueryParameters);
    return queryParameters;
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
