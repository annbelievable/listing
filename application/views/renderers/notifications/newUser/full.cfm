<cfparam name="args.id"				 type="string" />
<cfparam name="args.email_address"	 type="string" />
<cfparam name="args.display_name"    type="string" />
<cfoutput>
	<h2>New User Sign Up</h2>
	<dl>
		<dt>User ID:</dt>
		<dd><strong>#args.id#</strong></dd>

		<dt>Email:</dt>
		<dd><a href="#args.email_address#">#args.email_address#</a></dd>

		<dt>Name:</dt>
		<dd>#args.display_name#</dd>
	</dl>
</cfoutput>