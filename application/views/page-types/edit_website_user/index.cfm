
<cf_presideparam name="args.title"         field="page.title"        editable="true" />
<cf_presideparam name="args.main_content"  field="page.main_content" editable="true" />
<cfscript>
    savedData                 = rc.savedData        ?: {};
    validationResult          = rc.validationResult ?: "";
</cfscript>

<cfoutput>
	<h1>#args.title#</h1>
	#args.main_content#

    <cfif Len( Trim( rc.errorMessage ?: "" ) )>
        <div class="alert alert-danger">
            #renderContent( "richeditor", rc.errorMessage )#
        </div>
    </cfif>

	<h3>Edit Profile</h3>
    <form name="personalInfo" id="personalInfo" action="#event.buildLink( linkto="page-types.edit_website_user.updatePersonalInfo" )#" method="post">
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

    <a href="#event.buildLink( page="user_profile" )#">Back to Profile</a>

</cfoutput>
