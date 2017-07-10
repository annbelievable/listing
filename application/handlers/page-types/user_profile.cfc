component {

	property name="UserService"      inject="UserService";

	private function index( event, rc, prc, args={} ) {
		var id = rc.id ?: "";
		if( len(id) ) {
			args.userDetails = UserService.getUserByIdOrEmail( id=id );
		} else {
			args.userDetails = UserService.getLoggedInUserDetails() ?: {};
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