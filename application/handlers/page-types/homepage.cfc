component {

	property name="UserService"		     inject="UserService";

	public function index( event, rc, prc, args={} ) {
		args.categories = UserService.getAllCategories();
		return renderView(
			  view          = 'page-types/homepage/index'
			, presideObject = 'homepage'
			, id            = event.getCurrentPageId()
			, args          = args
		);
	}

	public function filterItemsByCategory( event, rc, prc, args={} ) {
		args.filteredItems = UserService.filterItemsByCategory( category=args.category, selectFields=["id","name"] );
		return renderView(
			  view          = 'page-types/homepage/_items'
			, presideObject = 'homepage'
			, id            = event.getCurrentPageId()
			, args          = args
		);
	}

}