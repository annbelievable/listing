
<cf_presideparam name="args.title"         field="page.title"        editable="true" />
<cf_presideparam name="args.main_content"  field="page.main_content" editable="true" />
<cfscript>
	var user = args.userDetails?:{};
	if(len(user.address2)) {
		var address = "#user.address1#, #user.address2#, #user.postcode# #user.city#, #user.state#";
	} else {
		var address = "#user.address1#, #user.postcode# #user.city#, #user.state#";
	}
</cfscript>

<cfoutput>
	<h1>#args.title#</h1>
	#args.main_content#
	<p>Account Details:</p>
	<p>Email address  : #user.email_address#</p>
	<p>Phone number   : #user.phone_number#</p>
	<p>Address 	      : #address#</p>
</cfoutput>
