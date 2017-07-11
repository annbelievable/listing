component {

	property name="UserService"		     inject="UserService";

	public function index( event, rc, prc, args={} ) {
		rc.category        = rc.category ?: "";
		args.filteredItems = UserService.filterItemsByCategory( category=rc.category, selectFields=["id","name"] );
		args.categories    = UserService.getAllCategories();
		return renderView(
			  view          = 'page-types/item_listings/index'
			, presideObject = 'item_listings'
			, id            = event.getCurrentPageId()
			, args          = args
		);
	}

}