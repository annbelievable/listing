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
    }

}
