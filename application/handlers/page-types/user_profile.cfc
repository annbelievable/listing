component {

	property name="UserService"      inject="UserService";

	private function index( event, rc, prc, args={} ) {
		var id = rc.id ?: "";
		if( len(id) ) {
			//for users to look at others profile
			args.userDetails = UserService.getUserByIdOrEmail( id=id );
			args.userId      = UserService.getLoggedInUserId() ?: "";
		} else {
			//for logged in users to look at their own profile
			args.userDetails = UserService.getLoggedInUserDetails();
			args.userId      = UserService.getLoggedInUserId();
			args.items		 = UserService.getUserItems( user_id=args.userId );
			args.bookings    = UserService.getUserBookings( user_id=args.userId );
		}
		if ( StructIsEmpty(args.userDetails) ) {
			relocate( event.buildLink(page="homepage") );
		}

		return renderView(
			  view          = 'page-types/user_profile/index'
			, presideObject = 'user_profile'
			, id            = event.getCurrentPageId()
			, args          = args
		);
	}

}
