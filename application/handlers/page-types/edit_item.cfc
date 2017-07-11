component {

	property name="UserService"          inject="UserService";

	private function index( event, rc, prc, args={} ) {
		var id        = rc.id ?: "";
		var itemQuery = UserService.getItem( id=id );
		var itemData  = itemQuery.getRow(1);
		rc.savedData  = rc.savedData ?: itemData;
		return renderView(
			  view          = 'page-types/edit_item/index'
			, presideObject = 'edit_item'
			, id            = event.getCurrentPageId()
			, args          = args
		);
	}

	public function updateItemInfo( event, rc, prc, args={} ){
		var id               = rc.id ?: "";
		var formName         = "custom.item";
		var formData         = event.getCollectionForForm( formName );
		var validationResult = validateForm( formName, formData );
		if( validationResult.validated() ) {
			formData.website_user = UserService.getLoggedInUserId();
			var result = UserService.updateItemInfo( id=id, data=formData );
		}
		if(result.statusCode=="SUCCESS" ) {
			setNextEvent( url=event.buildLink( page="item_detail", id=id ) );
		}
		setNextEvent( url=event.buildLink( page="edit_item", id=id )
			, persistStruct = {
				savedData    = formData,
				errorMessage = result.statusCodeMessage
			}
		);
	}

}
