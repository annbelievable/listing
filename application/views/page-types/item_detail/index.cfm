<cf_presideparam name="args.title"         field="page.title"        editable="true" />
<cf_presideparam name="args.main_content"  field="page.main_content" editable="true" />

<cfscript>
	var item = args.item?:QueryNew("");
</cfscript>

<cfoutput>
	<h1>#args.title#</h1>
	#args.main_content#

	<h3>#item.name#</h3>
	<p>Description: #item.description#</p>
	<p>Side Note: #item.sidenote#</p>
	<p>Owner: <a href="#event.buildLink( page='user_profile', id="#item.website_user#" )#">#item.website_user#</a></p>

	<br>
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

</cfoutput>