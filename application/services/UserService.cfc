/**
* @presideService
* @singleton true
*/
component output=false{
  // CONSTRUCTOR
	/**
   * @presideObjectService.inject      presideObjectService
   */

  public any function init(
        required any presideObjectService
  ) {
      _setPresideObjectService( arguments.presideObjectService );
      return this;
  }



  //users
	public string function getLoggedInUserId() {
		return $getWebsiteLoggedInUserId();
	}

	public function getLoggedInUserDetails() {
		return $getWebsiteLoggedInUserDetails();
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

  query function getAllItems() {
    return $getPresideObject( "item" ).selectData();
  }

  query function getAllCategories() {
    return $getPresideObject( "category" ).selectData();
  }

  query function getItem( require string id, array selectFields=[] ) {
    var filter             = "id = :id";
    var filterParams["id"] = arguments.id;
    var selectFields       = arguments.selectFields;
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



  //getter and setter
  private function _setPresideObjectService( required any presideObjectService ) {
    _presideObjectService = arguments.presideObjectService;
  }

  private function _getPresideObjectService() {
    return _presideObjectService;
  }
}

//why do you need inject presideObjectService to use the preside service in this case?
