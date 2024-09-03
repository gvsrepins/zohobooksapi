import 'dart:convert';
import 'package:oauth2/oauth2.dart' as oauth2;
import 'package:http/http.dart' as http;

// A project is a series of tasks performed over a period of time,
// to achieve certain targets. There can be many number of people
// working on a single project and a project may consist of single
// or multiple tasks. A project is billed and charged upon a customer
// whom the project was taken up for.
// Ref: https://www.zoho.com/books/api/v3/projects/#overview
class BaseResource {
  final oauth2.Client httpClient;
  final String baseUrl;
  final String organizationId;

  final String resourceName = '';
  final String resourcPath = '';

  BaseResource(this.httpClient, this.organizationId,
      {this.baseUrl = 'https://www.zohoapis.com/books/v3'});

  Uri prepareUrl({String? pathSegments = ""}) {
    var resourcPath = pathSegments ?? this.resourcPath;
    return Uri.parse(
        '$baseUrl/$resourceName/$resourcPath?organization_id=$organizationId');
  }

  // Helper methods for HTTP requests
  Future<http.Response> post(Map<String, dynamic> data,
      {String? pathSegments = ''}) async {
    final uri = prepareUrl(pathSegments: pathSegments);
    return await httpClient.post(uri, body: json.encoder.convert(data));
  }

  Future<http.Response> put(Map<String, dynamic> data,
      {String? pathSegments = ''}) async {
    final uri = prepareUrl(pathSegments: pathSegments);
    return await httpClient.put(uri);
  }

  Future<http.Response> get({String? pathSegments = ''}) async {
    final uri = prepareUrl(pathSegments: pathSegments);
    return await httpClient.get(uri);
  }

  Future<http.Response> delete({String? pathSegments = ''}) async {
    final uri = prepareUrl(pathSegments: pathSegments);
    return await httpClient.delete(uri);
  }
}
