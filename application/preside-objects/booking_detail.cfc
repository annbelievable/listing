
component  {
	property name="borrower_id" relationship="many-to-one" relatedTo="website_user" required=true;
	property name="owner_id"    relationship="many-to-one" relatedTo="website_user" required=true;
	property name="item_id"     relationship="many-to-one" relatedTo="item"         required=true;

	property name="start_date"  type="date"   dbtype="datetime" required=true;
	property name="end_date"    type="date"   dbtype="datetime" required=true;
	property name="sidenote"    type="string" dbtype="varchar"  required=false;
}