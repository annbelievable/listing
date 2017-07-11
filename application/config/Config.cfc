component extends="preside.system.config.Config" {

	public void function configure() {
		super.configure();

		settings.preside_admin_path  = "admin";
		settings.system_users        = "sysadmin";
		settings.default_locale      = "en";

		settings.default_log_name    = "listing";
		settings.default_log_level   = "information";
		settings.sql_log_name        = "listing";
		settings.sql_log_level       = "information";

		settings.ckeditor.defaults.stylesheets.append( "css-bootstrap" );
		settings.ckeditor.defaults.stylesheets.append( "css-layout" );

		settings.features.websiteUsers.enabled = true;

		settings.notificationTopics.append("newUser");
		_setupEmailSettings();
	}

	private void function _setupEmailSettings() {
    	settings.email.templates.newUserWelcome = {
	          feature       = "cms"
	        , recipientType = "anonymous"
	        , parameters    = [ { id="display_name", required=false } ]
	    };

	    settings.email.templates.newBooking = {
	          feature       = "cms"
	        , recipientType = "anonymous"
	        , parameters    = [
		          { id="display_name"          , required=false }
	        	, { id="borrower_first_name"   , required=false }
	        	, { id="borrower_last_name"    , required=false }
	        	, { id="borrower_phone_number" , required=false }
	        	, { id="borrower_email_address", required=false }
	        	, { id="item_id"               , required=false }
	        	, { id="booking_detail_id"     , required=false }
	        	, { id="start_date"            , required=false }
	        	, { id="end_date"              , required=false }
	        	, { id="sidenote"              , required=false }
	        ]
	    };

	   	settings.email.templates.bookingSuccessful = {
	          feature       = "cms"
	        , recipientType = "anonymous"
	        , parameters    = [
	        	  { id="display_name"          , required=false }
	          	, { id="owner_first_name"      , required=false }
	        	, { id="owner_last_name"       , required=false }
	        	, { id="owner_phone_number"    , required=false }
	        	, { id="owner_email_address"   , required=false }
	        	, { id="item_id"               , required=false }
	        	, { id="booking_detail_id"     , required=false }
	        	, { id="start_date"            , required=false }
	        	, { id="end_date"              , required=false }
	        	, { id="sidenote"              , required=false }
	        ]
	    };
    }

}
