
<cf_presideparam name="args.title"         field="page.title"        editable="true" />
<cf_presideparam name="args.main_content"  field="page.main_content" editable="true" />

<cfscript>
    savedData                 = rc.savedData        ?: {};
    validationResult          = rc.validationResult ?: "";
    id                        = rc.id               ?: "";
</cfscript>

<cfoutput>
	<h1>#args.title#</h1>
	#args.main_content#

    <cfif Len( Trim( rc.errorMessage ?: "" ) )>
        <div class="alert alert-danger">
            #renderContent( "richeditor", rc.errorMessage )#
        </div>
    </cfif>

	<h3>Edit Item: #id#</h3>
        <form name="item" id="item" action="#event.buildLink( linkto="page-types.edit_item.updateItemInfo" )#" method="post">
            <!--- <input name="csrfToken" type="hidden" value="#event.getCsrfToken()#"> --->
            <input type="hidden" name="id" value="#id#">
            #renderForm(
                  formName            = "custom.item"
                , formId              = "item"
                , context             = "website"
                , savedData           = savedData
                , validationResult    = validationResult
            )#

            <div class="form-submit u-aligned-center">
                <input type="submit" value="Submit" class="btn">
            </div>

        </form>

    <a href="#event.buildLink( page="" )#">Back to Item</a>

</cfoutput>