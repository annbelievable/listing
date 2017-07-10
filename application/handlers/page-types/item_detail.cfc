component {

	property name="UserService" inject="UserService";

	private function index( event, rc, prc, args={} ) {
		args.item = UserService.getItem( id=rc.id );
		rc.savedData.owner_id = args.item.website_user;
		rc.savedData.item_id  = args.item.id;
		return renderView(
			  view          = 'page-types/item_detail/index'
			, presideObject = 'item_detail'
			, id            = event.getCurrentPageId()
			, args          = args
		);
	}

	public function submitBookingInfoForm( event, rc, prc, args={} ) {
		var formName         = "custom.bookingInfo";
		var formData         = event.getCollectionForForm( formName );
		var validationResult = validateForm( formName, formData );
		if( validationResult.validated() ) {
			formData.label       = "Booking Detail";
			formData.borrower_id = UserService.getLoggedInUserId();
			var result           = UserService.saveBooking( data=formData );
			//comment: redirect back to a success page
            setNextEvent(
            	  url           = event.buildLink( page="item_detail", queryString="id=#( formData.item_id ?: '' )#" )
                , persistStruct = {
                    statusCode  = result.statusCode
                }
            );
        }
        //comment: redirect back to the form
        setNextEvent(
        	  url           = event.buildLink( page="item_detail", queryString="id=#( formData.item_id ?: '' )#" )
        	, persistStruct = {
                  validationResult = validationResult
                , savedData        = formData
                , errorMessage     = result.statusCodeMessage
            }
        );
	}

}