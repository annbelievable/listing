component extends="preside.system.preside-objects.websiteUserManagement.website_user"{
	property name="first_name" 	 type="string"  dbtype="varchar" maxLength="125" required=true  default="";
	property name="last_name"    type="string"  dbtype="varchar" maxLength="125" required=true  default="";
	property name="phone_number" type="numeric" dbtype="int"     minLength="6"   maxLength="20" required=true default="";
	property name="address1"   	 type="string"  dbtype="varchar" maxLength="125" required=true  default="";
	property name="address2"   	 type="string"  dbtype="varchar" maxLength="125" required=false default="";
	property name="postcode"   	 type="string"  dbtype="varchar" minLength="3"   maxLength="12"  required=true default="";
	property name="city"       	 type="string"  dbtype="varchar" minLength="3"   maxLength="125" required=true default="";
	property name="state"      	 type="string"  dbtype="varchar" minLength="3"   maxLength="125" required=true default="";
	property name="item" relationship="one-to-many"	relatedTo="item" relationshipKey="website_user";
}