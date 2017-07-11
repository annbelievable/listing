component {

  private struct function prepareParameters() {
    return {
        display_name           = arguments.display_name           ?: ""
      , owner_first_name       = arguments.owner_first_name       ?: ""
      , owner_last_name        = arguments.owner_last_name        ?: ""
      , owner_phone_number     = arguments.owner_phone_number     ?: ""
      , owner_email_address    = arguments.owner_email_address    ?: ""
      , item_id                = arguments.item_id                ?: ""
      , booking_detail_id      = arguments.booking_detail_id      ?: ""
      , start_date             = arguments.start_date             ?: ""
      , end_date               = arguments.end_date               ?: ""
      , sidenote               = arguments.sidenote               ?: ""
    };
  }

  private struct function getPreviewParameters() {
    return {
        display_name           = "kraken dude"
      , owner_first_name       = "munch"
      , owner_last_name        = "monster"
      , owner_phone_number     = "47474"
      , owner_email_address    = "hohoh"
      , item_id                = "4545"
      , booking_detail_id      = "654654"
      , start_date             = "hue"
      , end_date               = "euh"
      , sidenote               = "hohohaha"
    };
  }

  private string function defaultSubject() {
    return "Your Booking is Successful.";
  }

}

