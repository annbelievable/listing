
<cf_presideparam name="args.title"         field="page.title"        editable="true" />
<cf_presideparam name="args.main_content"  field="page.main_content" editable="true" />

<cfscript>

	rc.category    = rc.category?:"";
	var categories = args.categories?:queryNew("");
	var items      = args.filteredItems?:QueryNew("");
</cfscript>

<cfoutput>
	<h1>#args.title#</h1>
	#args.main_content#

	<form name="filter" action="#event.buildLink()#" method="POST">
		<fieldset>
			<label for="category">Category</label>
			<select id="category" name="category">
				<option value="">All</option>
				<cfloop query="categories">
					<option value="#id#" #(rc.category eq id)?'selected="selected"':''#>#label#</option>
				</cfloop>
			</select>
			<input type="submit" value="Filter" />
		</fieldset>
	</form>

	<cfif items.recordcount>
		<cfoutput query="items" >
			<h3><a href="#event.buildLink( page='item_detail', id="#items.id#")#" target="_blank">#items.name#</a></h3>
		</cfoutput>
	<cfelse>
		<h3>No items posted yet</h3>
	</cfif>
</cfoutput>