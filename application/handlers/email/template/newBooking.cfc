component {

  private struct function prepareParameters() {
    return {
        display_name           = arguments.display_name           ?: ""
      , borrower_first_name    = arguments.borrower_first_name    ?: ""
      , borrower_last_name     = arguments.borrower_last_name     ?: ""
      , borrower_phone_number  = arguments.borrower_phone_number  ?: ""
      , borrower_email_address = arguments.borrower_email_address ?: ""
      , item_id                = arguments.item_id                ?: ""
      , booking_detail_id      = arguments.booking_detail_id      ?: ""
      , start_date             = arguments.start_date             ?: ""
      , end_date               = arguments.end_date               ?: ""
      , sidenote               = arguments.sidenote               ?: ""
    };
  }

  private struct function getPreviewParameters() {
    return {
        display_name           = "piglet little"
      , borrower_first_name    = "brad"
      , borrower_last_name     = "pug"
      , borrower_phone_number  = "80808"
      , borrower_email_address = "jijji"
      , item_id                = "123"
      , booking_detail_id      = "321"
      , start_date             = "day"
      , end_date               = "night"
      , sidenote               = "hohohaha"
    };
  }

  private string function defaultSubject() {
    return "You've a new booking";
  }

}

