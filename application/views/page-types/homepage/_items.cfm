<cfscript>
	var items = args.filteredItems?:QueryNew("");
</cfscript>

<cfif items.recordcount>
	<h4>10 Items:</h4>
	<cfoutput query="items"  maxRows="10" >
		<h3><a href="#event.buildLink( page='item_detail', id="#items.id#")#" target="_blank">#items.name#</a></h3>
	</cfoutput>
</cfif>