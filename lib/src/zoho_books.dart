import 'package:oauth2/oauth2.dart' as oauth2;
import 'package:zohobooks_api/zohoboks_api.dart';

class ZohoBooks {
  late final oauth2.Client oauthClient;
  final String organizationId;

  ZohoBooks({required this.oauthClient, required this.organizationId});

  Projects get projects => Projects(oauthClient, organizationId);
  Bills get bills => Bills(oauthClient, organizationId);
  Contacts get contacts => Contacts(oauthClient, organizationId);
  //Estimates get estimates => Estimates(oauthClient, organizationId);
  //SalesOrders get salesOrders => SalesOrders(oauthClient, organizationId);
  //Invoices get invoices => Invoices(oauthClient, organizationId);
  //RecurringInvoices get recurringInvoices => RecurringInvoices(oauthClient, organizationId);
  //CreditNotes get creditNotes => CreditNotes(oauthClient, organizationId);
  //CustomerPayments get customerPayments => CustomerPayments(oauthClient, organizationId);
  //Expenses get expenses => Expenses(oauthClient, organizationId);
  //RecurringExpenses get recurringExpenses => RecurringExpenses(oauthClient, organizationId);
  //PurchaseOrders get purchaseOrders => PurchaseOrders(oauthClient, organizationId);
  //VendorCredits get vendorCredits => VendorCredits(oauthClient, organizationId);
  //VendorPayments get vendorPayments => VendorPayments(oauthClient, organizationId);
  //BankAccounts get bankAccounts => BankAccounts(oauthClient, organizationId);
  //BankTransactions get bankTransactions => BankTransactions(oauthClient, organizationId);
  //BankRules get bankRules => BankRules(oauthClient, organizationId);
  //ChartOfAccounts get chartOfAccounts => ChartOfAccounts(oauthClient, organizationId);
  //Journals get journals => Journals(oauthClient, organizationId);
  //BaseCurrencyAdjustment get baseCurrencyAdjustment => BaseCurrencyAdjustment(oauthClient, organizationId);
  //Settings get settings => Settings(oauthClient, organizationId);
  //Organizations get organizations => Organizations(oauthClient, organizationId);
  //Items get items => Items(oauthClient, organizationId);
  //Users get users => Users(oauthClient, organizationId);
  //Import get import => Import(oauthClient, organizationId);


  set projects(Projects value) {}
  set contacts(Contacts value) {}
  set bills(Bills value) {}
  //set estimates(Estimates value) {}
  //set invoices(Invoices value) {}
  //set recurringInvoices(Recurring
  //set creditNotes(CreditNotes value) {}
  //set customerPayments(CustomerPayments value) {}
  //set expenses(Expenses value) {}
  //set recurringExpenses(RecurringExpenses value) {}
  //set purchaseOrders(PurchaseOrders value) {}
  //set vendorCredits(VendorCredits value) {}
  //set vendorPayments(VendorPayments value) {}
  //set bankAccounts(BankAccounts value) {}
  //set bankTransactions(BankTransactions value) {}
  //set bankRules(BankRules value) {}
  //set chartOfAccounts(ChartOfAccounts value) {}
  //set journals(Journals value) {}
  //set baseCurrencyAdjustment(BaseCurrencyAdjustment value) {} 
  //set settings(Settings value) {}
  //set organizations(Organizations value) {}
  //set items(Items value) {}
  //set users(Users value) {}
  //set import(Import value) {}
  //set settings(Settings value) {}
  //set organizations(Organizations value) {}


}
