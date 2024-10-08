// ignore_for_file: constant_identifier_names

enum Region {
  EU('EU'),
  US('US'),
  CN('CN'),
  IN('IN'),
  AU('AU'),
  JP('JP'),
  SA('SA');

  final String value;

  const Region(this.value);
}