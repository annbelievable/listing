
component {
	property name="presideObjectService" inject="presideObjectService";

	public string function index( event, rc, prc, args={} ){

		var objectName   = args.objectName      ?: "";
		var selectFields = args.selectFields 	?: [];
		if( len(selectFields) ) {
			selectFields = listToArray(args.selectFields,",");
		}

		if( isNumeric(args.id) ) {
			var id       = args.id;
			args.records = presideObjectService.selectData( objectName=objectName, id=id, selectFields=selectFields );
		} else {
			args.records = presideObjectService.selectData( objectName=objectName, selectFields=selectFields );
		}

		args.values = ValueArray( args.records.id );
		args.labels = ValueArray( args.records.label );

		return renderView( view="formcontrols/select/web", args = args );
	}
}