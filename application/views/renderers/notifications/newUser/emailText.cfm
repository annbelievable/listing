<cfparam name="args.id"				 type="string" />
<cfparam name="args.email_address"	 type="string" />
<cfparam name="args.display_name"    type="string" />
<cfoutput>
	New User Sign Up:

	User ID: #args.id#
	Email: #args.email_address#
	Name: #args.display_name#
</cfoutput>