/**
* @presideService
* @singleton true
*/
component output=false{
  // CONSTRUCTOR
	/**
   * @presideObjectService.inject      presideObjectService
   * @WebsiteLoginService.inject       WebsiteLoginService
   */

   //WebsiteLogin service can be removed as it is not used here

  public any function init(
      required any presideObjectService
    , required any WebsiteLoginService
  ) {
    _setPresideObjectService( arguments.presideObjectService );
    _setWebsiteLoginService( arguments.WebsiteLoginService );
    return this;
  }



  //users
	public string function getLoggedInUserId() {
		return $getWebsiteLoggedInUserId();
	}

	public struct function getLoggedInUserDetails() {
		return $getWebsiteLoggedInUserDetails();
	}

  public struct function updatePersonalInfo( required string id, struct data={} ) {
    var id     = arguments.id;
    var data   = arguments.data;
    var result = { statusCode="SUCCESS" };
    try {
      $getPresideObjectService().updateData(
          objectName = "website_user"
        , id         = id
        , data       = data
      );
    }
    catch( e ) {
        $raiseError(e);
        result.statusCode        = "FAILED";
        result.statusCodeMessage = "Failed to save the data. Please contact our web administrator";
    }
    return result;
  }

  query function getUserByIdOrEmail( string id="", string email_address="", array selectFields=[] ) {
    if( len(arguments.id) ) {
        var filter             = "id = :id";
        var filterParams["id"] = arguments.id;
    } else {
        var filter             = "email_address = :email_address";
        var filterParams["email_address"] = arguments.email_address;
    }
    var selectFields       = arguments.selectFields?:["id","email","first_name","last_name","display_name","phone_number","address1","address2","postcode","city","state"];
    return $getPresideObject( "website_user" ).selectData(
          filter           = filter
        , filterParams     = filterParams
        , selectFields     = selectFields
    );
  }



  //items
  public struct function saveItem( required struct data) {
    var data   = arguments.data;
    var result = { statusCode="SUCCESS" };
    try {
      var item = $getPresideObjectService().insertData(
          objectName = "item"
        , data       = data
        , insertManyToManyRecords=true
      );
    }
    catch( e ) {
        $raiseError(e);
        result.statusCode        = "FAILED";
        result.statusCodeMessage = "Failed to save the data. Please contact our web administrator";
    }
    return result;
  }

  public struct function updateItemInfo( required string id, struct data={} ) {
    var id     = arguments.id;
    var data   = arguments.data;
    var result = { statusCode="SUCCESS" };
    try {
      $getPresideObjectService().updateData(
          objectName = "item"
        , id         = id
        , data       = data
        , updateManyToManyRecords=true
      );
    }
    catch( e ) {
        $raiseError(e);
        result.statusCode        = "FAILED";
        result.statusCodeMessage = "Failed to save the data. Please contact our web administrator";
    }
    return result;
  }

  query function getAllItems() {
    return $getPresideObject( "item" ).selectData();
  }

  query function getAllCategories() {
    return $getPresideObject( "category" ).selectData();
  }

  query function getItem( required string id, array selectFields=[] ) {
    var filter             = "id = :id";
    var filterParams["id"] = arguments.id;
    var selectFields       = arguments.selectFields;
    return $getPresideObject( "item" ).selectData(
        filter       = filter
      , filterParams = filterParams
      , selectFields = selectFields
    );
  }

  query function getUserItems( required string user_id, array selectFields=[] ) {
    var filter                       = "website_user = :website_user";
    var filterParams["website_user"] = arguments.user_id;
    var selectFields                 = arguments.selectFields;
    return $getPresideObject( "item" ).selectData(
        filter       = filter
      , filterParams = filterParams
      , selectFields = selectFields
    );
  }

  query function filterItemsByCategory( string category=args.category, array selectFields=[] ) {
    var selectFields = arguments.selectFields;
    if( len(arguments.category) ) {
      var filter                      = "category.id = :category.id";
      var filterParams["category.id"] = arguments.category ?: "";
      return $getPresideObject( "item" ).selectData( filter=filter, filterParams=filterParams, selectFields=selectFields );
    }
    return $getPresideObject( "item" ).selectData( selectFields=selectFields );
  }



  //booking
  public struct function saveBooking( required struct data) {
    var data   = arguments.data;
    var result = { statusCode="SUCCESS" };
    try {
      var booking    = $getPresideObjectService().insertData(
          objectName = "booking_detail"
        , data       = data
        , insertManyToManyRecords=true
      );
    }
    catch( e ) {
        $raiseError(e);
        result.statusCode        = "FAILED";
        result.statusCodeMessage = "Failed to save the data. Please contact our web administrator";
    }
    return result;
  }

  query function getUserBookings( required string user_id, array selectFields=[] ) {
    var filter                      = "borrower_id = :borrower_id";
    var filterParams["borrower_id"] = arguments.user_id;
    var selectFields                = arguments.selectFields;
    return $getPresideObject( "booking_detail" ).selectData(
        filter       = filter
      , filterParams = filterParams
      , selectFields = selectFields
    );
  }



  //getter and setter
  private function _setPresideObjectService( required any presideObjectService ) {
    _presideObjectService = arguments.presideObjectService;
  }

  private function _getPresideObjectService() {
    return _presideObjectService;
  }

  private function _setWebsiteLoginService( required any WebsiteLoginService ) {
    _WebsiteLoginService = arguments.WebsiteLoginService;
  }

  private function _getWebsiteLoginService() {
    return _WebsiteLoginService;
  }


}

//why do you need inject presideObjectService to use the preside service in this case?
