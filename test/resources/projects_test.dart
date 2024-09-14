import 'dart:convert';

import 'package:test/test.dart';
import 'package:faker/faker.dart';
import '../test_setup.dart' as setup;
import 'package:http/http.dart' as http;
import 'package:oauth2/oauth2.dart' as oauth2;
import 'package:zohobooks_api/zohoboks_api.dart';

void main() {
  setup.main();
  late Projects projects;
  late oauth2.Client client;
  setup.clientVCR = setup.createVCRClient("projects");

  setUp(() async {
    client = await setup.oauthClientProvider.init();
    projects = Projects(client, setup.organizationId!);
  });

  group('Projects', () {
    test('should create a project', () async {
      final response = await createNewProject(projects);
      expect(response, isA<http.Response>());
      expect(response.statusCode, equals(201));
    });

    test('should get all projects', () async {
      final response = await projects.all(queryParameters: {
        'sort_column': 'project_name',
        'sort_order': 'A',
        'filter_by': 'Status.All',
      });

      expect(response, isA<http.Response>());
      expect(response.statusCode, equals(200));
    });

    test('should update project', () async {
      http.Response createResponse = await createNewProject(projects);
      var projectId =
          json.decode(createResponse.body)['project']['project_id'].toString();

      final project = ProjectDTO(
        projectId: projectId,
        projectName: "Project for ${faker.company.name()}",
        customerId: "5546603000000100003",
        currencyCode: "USD",
        description: faker.lorem.sentence(),
        billingType: "fixed_cost_for_project",
        rate: faker.randomGenerator.integer(5000).toString(),
        costBudgetAmount: faker.randomGenerator.decimal(scale: 2).toDouble(),
        userId: "5546603000000088001",
      );

      final response = await projects.update(project);
      expect(response, isA<http.Response>());
      expect(response.statusCode, equals(200));
    });

    test('should find one project', () async {
      http.Response createResponse = await createNewProject(projects);
      var projectId =
          json.decode(createResponse.body)['project']['project_id'].toString();

      final response = await projects.find(projectId);
      expect(response, isA<http.Response>());
      expect(response.statusCode, equals(200));
    });

    test('destroy', () async {
      http.Response createResponse = await createNewProject(projects);
      var projectId =
          json.decode(createResponse.body)['project']['project_id'].toString();

      final response = await projects.destroy(projectId);
      expect(response, isA<http.Response>());
      expect(response.statusCode, equals(200));
    });

    test('activate', () async {
      http.Response createResponse = await createNewProject(projects);
      var projectId =
          json.decode(createResponse.body)['project']['project_id'].toString();

      final response = await projects.activate(projectId);
      expect(response, isA<http.Response>());
      expect(response.statusCode, equals(200));
    });

    test('inactivate', () async {
      http.Response createResponse = await createNewProject(projects);
      var projectId =
          json.decode(createResponse.body)['project']['project_id'].toString();

      final response = await projects.inactivate(projectId);
      expect(response, isA<http.Response>());
      expect(response.statusCode, equals(200));
    });

    test('clone', () async {
      http.Response createResponse = await createNewProject(projects);
      var projectId =
          json.decode(createResponse.body)['project']['project_id'].toString();

      final project = ProjectCloneDTO(
          projectName: 'Cloned project for ${faker.company.name()}');
      final response = await projects.clone(projectId, project);
      expect(response, isA<http.Response>());
      expect(response.statusCode, equals(201));
    });
  });
}

Future<http.Response> createNewProject(Projects projects) async {
  var project = ProjectDTO(
    projectName: "Project for ${faker.company.name()}",
    customerId: "5546603000000100003",
    currencyCode: "USD",
    description: faker.lorem.sentence(),
    billingType: "fixed_cost_for_project",
    rate: faker.randomGenerator.integer(5000).toString(),
    costBudgetAmount: faker.randomGenerator.decimal(scale: 2).toDouble(),
    userId: "5546603000000088001",
    users: [
      ProjectUserDTO(
        userId: "5546603000000088001",
        userRole: "admin",
      ),
    ],
  );

  final createResponse = await projects.create(project);
  return createResponse;
}
