<cf_presideparam name="args.title"         field="page.title"        editable="true" />
<cf_presideparam name="args.main_content"  field="page.main_content" editable="true" />

<cfscript>
	var item    = args.item?:QueryNew("");
	var user_id = args.user_id?:"";
</cfscript>

<cfoutput>
	<h1>#args.title#</h1>
	#args.main_content#

	<h3>#item.name#</h3>
	<p>Description: #item.description#</p>
	<p>Side Note: #item.sidenote#</p>
	<p><a href="#event.buildLink( page='user_profile', id="#item.website_user#" )#">Owner Profile</a></p>

	<br>
	<cfif len(user_id)>
		<h3>Book Item</h3>
		<cfif Len( Trim( rc.statusCode ?: "" ) )>
	        <div class="alert alert-danger">
	            #renderContent( "richeditor", rc.statusCode )#
	        </div>
	    </cfif>
		<cfif Len( Trim( rc.errorMessage ?: "" ) )>
	        <div class="alert alert-danger">
	            #renderContent( "richeditor", rc.errorMessage )#
	        </div>
	    </cfif>
		#renderView( view='page-types/item_detail/_bookingInfo', args=args )#
    </cfif>

</cfoutput>