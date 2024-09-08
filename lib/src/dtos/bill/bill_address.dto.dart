class BillingAddressDTO {
  String? address;
  String? street2;
  String? city;
  String? state;
  String? zip;
  String? country;
  String? fax;
  String? attention;

  BillingAddressDTO({
    this.address,
    this.street2,
    this.city,
    this.state,
    this.zip,
    this.country,
    this.fax,
    this.attention,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (address != null) data['address'] = address;
    if (street2 != null) data['street2'] = street2;
    if (city != null) data['city'] = city;
    if (state != null) data['state'] = state;
    if (zip != null) data['zip'] = zip;
    if (country != null) data['country'] = country;
    if (fax != null) data['fax'] = fax;
    if (attention != null) data['attention'] = attention;
    return data;
  }
}