class ContactDTO {
  Map<String, dynamic> _attributes = {
    'contact_id': '',
    'contact_name': '',
    'company_name': '',
    'has_transaction': false,
    'contact_type': '',
    'customer_sub_type': '',
    'credit_limit': 0.0,
    'is_portal_enabled': false,
    'language_code': '',
    'is_taxable': false,
    'tax_id': '',
    'tds_tax_id': '',
    'tax_name': '',
    'tax_percentage': 0.0,
    'tax_authority_id': '',
    'tax_exemption_id': '',
    'tax_authority_name': '',
    'tax_exemption_code': '',
    'place_of_contact': '',
    //TODO: Add non-US fields later
    //'gst_no': '',
    //'vat_treatment': '',
    //'tax_treatment': '',
    //'tax_regime': '',
    //'legal_name': '',
    //'is_tds_registered': false,
    //'gst_treatment': '',
    'is_linked_with_zohocrm': false,
    'website': '',
    'owner_id': '',
    'primary_contact_id': '',
    'payment_terms': 0,
    'payment_terms_label': '',
    'currency_id': '',
    'currency_code': '',
    'currency_symbol': '',
    'opening_balance_amount': 0.0,
    'exchange_rate': 0.0,
    'outstanding_receivable_amount': 0,
    'outstanding_receivable_amount_bcy': 0,
    'unused_credits_receivable_amount': 0,
    'unused_credits_receivable_amount_bcy': 0,
    'status': '',
    'payment_reminder_enabled': false,
    'custom_fields': [],
    'billing_address': {},
    'shipping_address': {},
    'facebook': '',
    'twitter': '',
    'contact_persons': [],
    // 'default_templates': {
    //   'invoice_template_id': '',
    //   'estimate_template_id': '',
    //   'creditnote_template_id': '',
    //   'purchaseorder_template_id': '',
    //   'salesorder_template_id': '',
    //   'retainerinvoice_template_id': '',
    //   'paymentthankyou_template_id': '',
    //   'retainerinvoice_paymentthankyou_template_id': '',
    //   'invoice_email_template_id': '',
    //   'estimate_email_template_id': '',
    //   'creditnote_email_template_id': '',
    //   'purchaseorder_email_template_id': '',
    //   'salesorder_email_template_id': '',
    //   'retainerinvoice_email_template_id': '',
    //   'paymentthankyou_email_template_id': '',
    //   'retainerinvoice_paymentthankyou_email_template_id': '',
    // },
    'notes': '',
    'created_time': '',
    'last_modified_time': '',
  };

  ContactDTO(Map<String, dynamic> json) {
    // Merge attributes with json
    _attributes = {..._attributes, ...json};

    // Validate required fields
    _validateRequiredAttributes(json);

    // Validate attributes
    _validateStringLength('contact_name', 200);
    _validateStringLength('company_name', 200);
    _validateStringLength('facebook', 100);
    _validateStringLength('twitter', 100);
    _validateNotesLength(json['notes']);
  }

  void _validateRequiredAttributes(Map<String, dynamic> json) {
    // Add any required field validations here
    // For example:
    // if (json['contact_name'] == null) {
    //   throw ArgumentError('Contact name is required.');
    // }
  }

  void _validateStringLength(String field, int maxLength) {
    String? value = _attributes[field] as String?;
    if (value != null && value.length > maxLength) {
      throw ArgumentError('$field must be at most $maxLength characters long.');
    }
  }

  void _validateNotesLength(String? notes) {
    if (notes == null) return;

    if (notes.length > 1000) {  // Assuming a max length of 1000 characters for notes
      throw ArgumentError('Notes must be at most 1000 characters long.');
    }
  }

  // Convert a ContactDTO instance to a JSON object
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    _attributes.forEach((key, value) {
      if (value != null && value != '' && value != 0.0 && value != false) {
        data[key] = value;
      }
    });

    return data;
  }

  dynamic getAttribute(String name) {
    if (_attributes[name] == null || _attributes[name] == '' || _attributes[name] == 0.0) {
      return null;
    }

    return _attributes[name];
  }

  void setAttribute(String name, dynamic value) {
    if (_attributes.containsKey(name)) {
      _attributes[name] = value;
    } else {
      throw ArgumentError('Invalid attribute name: $name');
    }
  }
}
