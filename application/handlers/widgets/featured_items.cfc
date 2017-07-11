component {

	property name="UserService"		     inject="UserService";

	private function index( event, rc, prc, args={} ) {
		var list   = args.featured_items?:"";
		args.items = UserService.getFeaturedItems( id=list, selectFields=["id","name"] );
		return renderView( view='widgets/featured_items/index', args=args );
	}

	private function placeholder( event, rc, prc, args={} ) {
		return renderView( view='widgets/featured_items/placeholder', args=args );
	}
}
