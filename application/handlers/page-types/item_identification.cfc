component {

	property name="UserService"		     inject="UserService";
	property name="FormsService"		 inject="FormsService";

	private function index( event, rc, prc, args={} ) {
		var id = UserService.getLoggedInUserId()?:"";
		if( id=="" ) {
			setNextEvent( url=event.buildLink( page="login" ) );
		}
		return renderView(
			  view          = 'page-types/item_identification/index'
			, presideObject = 'item_identification'
			, id            = event.getCurrentPageId()
			, args          = args
		);
	}

	public function submitItemForm( event, rc, prc, args={} ) {
		var formName         = "custom.item";
		var formData         = event.getCollectionForForm( formName );
		var validationResult = validateForm( formName, formData );
		if( validationResult.validated() ) {
			formData.website_user = UserService.getLoggedInUserId();
            var result = UserService.saveItem( data=formData );
            if( result.statusCode == "SUCCESS" ) {
            	var id = UserService.getLoggedInUserId();
                setNextEvent( url=event.buildLink( page="user_profile" ), persistStruct={ id=id } );
            }
        }
        //comment: redirect back to form
        setNextEvent(
        	  url=event.buildLink( page="signup" )
        	, persistStruct = {
                  validationResult = validationResult
                , savedData        = formData
                , errorMessage     = result.statusCodeMessage
            }
        );
	}

	public function itemDetail( event, rc, prc, args={} ) {
		var id = rc.id ?: "";
		if( len(id) ) {
			setNextEvent( url=event.buildLink( page="item_detail", id=id ) );
		}
		setNextEvent( url=event.buildLink( page="homepage" ) );
	}

}
