
component {

	property name="UserService"          inject="UserService";
	property name="EmailService"         inject="EmailService";

	private function index( event, rc, prc, args={} ) {
		rc.id                 = rc.id ?: "";
		args.user_id          = UserService.getLoggedInUserId() ?: "";
		args.item             = UserService.getItem( id=rc.id );
		rc.savedData.owner_id = args.item.website_user;
		rc.savedData.item_id  = args.item.id;
		if( rc.id=="" ) {
			setNextEvent( url=event.buildLink( page="item_listings" ) );
		}
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
			if( result.statusCode=="SUCCESS" ) {

				var owner    = UserService.getUserByIdOrEmail( id=formData.owner_id );
				var borrower = UserService.getUserByIdOrEmail( id=formData.borrower_id );

				//send to owner
	            EmailService.send(
	                  template = "newBooking"
	                , to       = [ owner.email_address ]
	                , args     = {
	                  	  display_name           = owner.display_name
	                	, borrower_first_name    = borrower.first_name
	                	, borrower_last_name     = borrower.last_name
	                	, borrower_phone_number  = borrower.phone_number
	                	, borrower_email_address = borrower.email_address
	                	, item_id                = formData.item_id
	                	, booking_detail_id      = result.id
	                	, start_date             = formData.start_date
	                	, end_date               = formData.end_date
	                	, sidenote               = formData.sidenote
	                 }
	            );

	            //sent to borrower
	            EmailService.send(
	                  template = "bookingSuccessful"
	                , to       = [ borrower.email_address ]
	                , args     = {
	                	  display_name           = borrower.display_name
	                	, owner_first_name       = owner.first_name
	                	, owner_last_name        = owner.last_name
	                	, owner_phone_number     = owner.phone_number
	                	, owner_email_address    = owner.email_address
	                	, item_id                = formData.item_id
	                	, booking_detail_id      = result.id
	                	, start_date             = formData.start_date
	                	, end_date               = formData.end_date
	                	, sidenote               = formData.sidenote
	                }
	            );

				setNextEvent(
	            	  url           = event.buildLink( page="item_detail", queryString="id=#( formData.item_id ?: '' )#" )
	                , persistStruct = {
	                    statusCode  = result.statusCode
	                }
            	);
			}

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