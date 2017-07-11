
<cfscript>
	var items = args.items?:QueryNew("");
</cfscript>

<cfif items.recordcount>
	<h1>Featured Items</h1>
	<cfoutput query="items" >
		<h3><a href="#event.buildLink( page='item_detail', id="#items.id#")#" target="_blank">#items.name#</a></h3>
	</cfoutput>
</cfif>