
<cf_presideparam name="args.title" field="page.title" editable="true" />

<cfoutput>
	<h1>#args.title#</h1>

	<cfif Len( Trim( rc.errorMessage ?: "" ) )>
        <div class="alert alert-danger">
            #renderContent( "richeditor", rc.errorMessage )#
        </div>
    </cfif>

    <cfswitch expression="#args.currentStep#">
        <cfcase value="2">
            #renderView( view='page-types/signup/_personalInfo', args=args )#
        </cfcase>
        <cfdefaultcase>
            #renderView( view='page-types/signup/_accountInfo', args=args )#
        </cfdefaultcase>
    </cfswitch>
</cfoutput>