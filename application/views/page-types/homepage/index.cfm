<cf_presideparam name="args.title"         field="page.title"        editable="true" />
<cf_presideparam name="args.main_content"  field="page.main_content" editable="true" />

<cfscript>
	categories  = args.categories?:queryNew("");
	rc.category = rc.category?:"";
</cfscript>

<cfoutput>
	<div class="jumbotron"><h1>#args.title#</h1></div>
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

	#renderViewlet( event="page-types.homepage.filterItemsByCategory", args={ category=rc.category })#

</cfoutput>

