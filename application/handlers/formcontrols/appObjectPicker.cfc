//output=false extends="preside.system.handlers.formcontrols.objectpicker"
component  {

	property name="presideObjectService" inject="presideObjectService";

	public string function index( event, rc, prc, args={} ){
		var objectName = args.objectName ?: "";
		args.records   = presideObjectService.selectData( objectName=objectName );

		args.values = ValueArray( args.records.id );
		args.labels = ValueArray( args.records.label );

		return renderView( view="formcontrols/objectPicker/web", args = args );
	}
}