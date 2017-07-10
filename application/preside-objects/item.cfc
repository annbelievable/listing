/**
*	@labelField name
*
*/
component {
	property name="name"         type="string" dbtype="varchar"  maxLength="200"          required=true;
	property name="description"  type="string" dbtype="longtext" required=true;
	property name="sidenote"     type="string" dbtype="longtext" required=false;
	property name="category"     relationship="many-to-many"     relatedTo="category"     required=true;
	property name="website_user" relationship="many-to-one"		 relatedTo="website_user" required=true;
}
