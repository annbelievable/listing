
<cf_presideparam name="args.title"         field="page.title"        editable="true" />
<cf_presideparam name="args.main_content"  field="page.main_content" editable="true" />
<cfscript>
	var user     = args.userDetails?:{};
	if(len(user.address2)) {
		var address = "#user.address1#, #user.address2#, #user.postcode# #user.city#, #user.state#";
	} else {
		var address = "#user.address1#, #user.postcode# #user.city#, #user.state#";
	}
	var items    = args.items?:QueryNew("");
	var bookings = args.bookings?:QueryNew("");
</cfscript>

<cfoutput>
	<div class="row">
		<h1>#args.title#</h1>
		#args.main_content#
		<p>Account Details:</p>
		<p>Email address  : #user.email_address#</p>
		<p>Phone number   : #user.phone_number#</p>
		<p>Address 	      : #address#</p>
	</div>

	<cfif user.id == args.userId>

		<a href="#event.buildLink( page='edit_website_user' )#">Edit Profile</a>

		<div class="row">
			<cfif items.recordcount>
				<h2>Your Listed Items:</h2>
				<cfoutput query="items">
					<h4>
						<a href="#event.buildLink( page='item_detail', id="#items.id#")#" target="_blank">#items.name#</a>
						||
						<a href="#event.buildLink( page='edit_item', id='#items.id#')#">Edit Item</a>
					</h4>
				</cfoutput>
			<cfelse>
				<h3>You have no items.</h3>
			</cfif>
		</div>

		<div class="row">
			<cfif bookings.recordcount>
				<h2>Your Bookings:</h2>
				<cfoutput query="bookings">
					<h4>#bookings.id#</h4>
				</cfoutput>
			<cfelse>
				<h3>You have no bookings.</h3>
			</cfif>
		</div>
	</cfif>
</cfoutput>

