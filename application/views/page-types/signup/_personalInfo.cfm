<cfscript>
    savedData                 = rc.savedData        ?: {};
    validationResult          = rc.validationResult ?: "";
</cfscript>

<cfoutput>
    <div class="form-wrap">
        <form name="personalInfo" id="personalInfo" action="#event.buildLink( linkto="page-types.signup.submitPersonalInfoForm" )#" method="post">
            <!--- <input name="csrfToken" type="hidden" value="#event.getCsrfToken()#"> --->

            #renderForm(
                  formName            = "signup.personalInfo"
                , formId              = "personalInfo"

                , context             = "website"
                , savedData           = savedData
                , validationResult    = validationResult
            )#

            <div class="form-submit u-aligned-center">
                <input type="submit" value="Update Profile" class="btn">
            </div>

        </form>
    </div>
</cfoutput>

<!--- , includeValidationJs = true --->