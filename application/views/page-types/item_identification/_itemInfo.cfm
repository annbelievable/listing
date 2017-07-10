<cfscript>
    savedData                 = rc.savedData        ?: {};
    validationResult          = rc.validationResult ?: "";
</cfscript>

<cfoutput>
    <div class="form-wrap">
        <form name="item" id="item" action="#event.buildLink( linkto="page-types.item_identification.submitItemForm" )#" method="post">
            <!--- <input name="csrfToken" type="hidden" value="#event.getCsrfToken()#"> --->

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
    </div>
</cfoutput>
