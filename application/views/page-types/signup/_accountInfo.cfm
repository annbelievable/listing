<cfscript>
    savedData                 = rc.savedData        ?: {};
    validationResult          = rc.validationResult ?: "";
</cfscript>

<cfoutput>
    <div class="form-wrap">
        <form name="accountInfo" id="accountInfo" action="#event.buildLink( linkto="page-types.signup.submitAccountInfoForm" )#" method="post">
            <!--- <input name="csrfToken" type="hidden" value="#event.getCsrfToken()#"> --->

            #renderForm(
                  formName            = "signup.accountInfo"
                , formId              = "accountInfo"
                , context             = "website"
                , savedData           = savedData
                , validationResult    = validationResult
            )#

            <div class="form-submit u-aligned-center">
                <input type="submit" value="Sign Up" class="btn">
            </div>

        </form>
    </div>
</cfoutput>

<!--- Changes:
    added form name,
    id and another form in inside render form,
    set includeValidationJs to true,
    then removed it:
        , includeValidationJs = true
    comment out crsf token line
    something of these might be causing problem
    --->