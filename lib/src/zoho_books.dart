import 'dart:mirrors';

import 'package:oauth2/oauth2.dart' as oauth2;
import 'package:zohobooks_api/zohoboks_api.dart';

class ZohoBooks {
  late final oauth2.Client oauthClient;
  final String organizationId;

  //modules

  Projects get projects =>
      projects = _createModule('Projects', [oauthClient, organizationId]);

  set projects(Projects value) {}

  final Map<String, String> _availableModules = {
    'contacts': 'Contacts',
    'estimates': 'Estimates',
    'salesorders': 'SalesOrders',
    'invoices': 'Invoices',
    'recurringinvoices': 'RecurringInvoices',
    'creditnotes': 'CreditNotes',
    'customerpayments': 'CustomerPayments',
    'expenses': 'Expenses',
    'recurringexpenses': 'RecurringExpenses',
    'purchaseorders': 'PurchaseOrders',
    'bills': 'Bills',
    'vendorcredits': 'VendorCredits',
    'vendorpayments': 'VendorPayments',
    'bankaccounts': 'BankAccounts',
    'banktransactions': 'BankTransactions',
    'bankrules': 'BankRules',
    'chartofaccounts': 'ChartOfAccounts',
    'journals': 'Journals',
    'basecurrencyadjustment': 'BaseCurrencyAdjustment',
    'projects': 'Projects',
    'settings': 'Settings',
    'organizations': 'Organizations',
    'items': 'Items',
    'users': 'Users',
    'import': 'Import',
  };

  ZohoBooks({required this.oauthClient, required this.organizationId});

  // Factory function to create instances based on a type string using reflection
  dynamic _createModule(String module, List<dynamic> args) {
    // Get the current mirror system
    MirrorSystem mirrorSystem = currentMirrorSystem();

    if (_availableModules[module.toLowerCase()] == null) {
      throw ArgumentError('Module "$module" not found in modules map.');
    }

    // Retrieve the library URI from the map using the type as the key
    String libraryUri = '$module.dart'.toLowerCase();

    // Find the specific library by its URI
    LibraryMirror libraryMirror = mirrorSystem.libraries.values.firstWhere(
      (lib) => lib.uri.toString().contains(libraryUri),
      orElse: () =>
          throw ArgumentError('Module with URI "$libraryUri" not found.'),
    );

    // Check if the class exists in this library
    if (libraryMirror.declarations.containsKey(Symbol(module))) {
      // Get the class mirror by the class name (type)
      ClassMirror classMirror =
          libraryMirror.declarations[Symbol(module)] as ClassMirror;

      // Dynamically create the instance using the class mirror and the provided arguments
      return classMirror.newInstance(Symbol(''), args).reflectee;
    }

    throw ArgumentError('Class "$module" not found in library "$libraryUri".');
  }

  // Define a custom getter using noSuchMethod
  @override
  dynamic noSuchMethod(Invocation invocation) {
    if (invocation.isGetter) {
      var memberName = _getMemberName(invocation.memberName);

      if (_availableModules[memberName] != null) {
        return _createModule(memberName, [oauthClient, organizationId]);
      }
    }

    super.noSuchMethod(invocation);
  }

  // Helper method to extract the member name as a string
  String _getMemberName(Symbol symbol) {
    return symbol.toString().split('"')[1];
  }
}
