component {

	property name="UserService"          inject="UserService";
	property name="WebsiteLoginService"  inject="WebsiteLoginService";

	private function index( event, rc, prc, args={} ) {
		var user_details    = UserService.getLoggedInUserDetails() ?: {};
		rc.savedData		= rc.savedData ?: user_details;
		if( StructIsEmpty(rc.savedData) ) {
			setNextEvent( url=event.buildLink( page="login" ) );
		}
		return renderView(
			  view          = 'page-types/edit_website_user/index'
			, presideObject = 'edit_website_user'
			, id            = event.getCurrentPageId()
			, args          = args
		);
	}

	public function updatePersonalInfo( event, rc, prc, args={} ){
		var id               = UserService.getLoggedInUserId();
		var formName         = "signup.personalInfo";
		var formData         = event.getCollectionForForm( formName );
		var validationResult = validateForm( formName, formData );
		if( validationResult.validated() ) {
			var result = UserService.updatePersonalInfo( id=id, data=formData );
		}
		if(result.statusCode=="SUCCESS" ) {
			var loginId = UserService.getLoggedInUserId();
			WebsiteLoginService.updatedUserDetail( loginId=loginId );
			setNextEvent( url=event.buildLink( page="user_profile" ) );
		}
		setNextEvent( url=event.buildLink( page="edit_website_user" )
			, persistStruct = {
				savedData    = formData,
				errorMessage = result.statusCodeMessage
			}
		);
	}

}
