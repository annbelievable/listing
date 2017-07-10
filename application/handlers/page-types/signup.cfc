component {
	property name="SignupService"		 inject="SignupService";
    property name="UserService"          inject="UserService";
	property name="FormsService"		 inject="FormsService";

	private function index( event, rc, prc, args={} ) {
		rc.savedData            = rc.savedData ?: {};
		var applicationProgress = SignupService.getApplicationProgress();
		args.currentStep        = isNumeric( applicationProgress.status ?: "" ) && applicationProgress.status <=2 ? applicationProgress.status : 1;

		if( isEmpty( rc.savedData  ) ){
            if( StructKeyExists( applicationProgress, "status" ) ){
                rc.savedData = applicationProgress.state["step#applicationProgress.status#Detail"] ?: {};
            }
        }

		return renderView(
			  view          = 'page-types/signup/index'
			, presideObject = 'signup'
			, id            = event.getCurrentPageId()
			, args          = args
		);
	}

	public function submitAccountInfoForm( event, rc, prc, args={} ) {
        var formName         = 'signup.accountInfo';
        var formData         = event.getCollectionForForm( formName );
        var validationResult = validateForm( formName, formData );

        //if email exist in db redirect user to login
        if( UserService.getUserByIdOrEmail( email_address=formData.email_address ).recordCount ) {
            relocate( event.buildLink(page="login") );
        }

        //check if the 2 if conditions below works well
        if( ( formData.password?:"" ) != ( formData.confirm_password?:"" ) ) {
			validationResult.addError( fieldName="confirm_password", message="Password must be the same.");
		}

        if( validationResult.validated() ){
        	StructDelete(formData,"confirm_password");
            SignupService.updateApplicationProgress(
                  step        = 2
                , stateDetail = { step1Detail=formData }
            );
            setNextEvent( url=event.buildLink( page="signup" ) );
        }

        setNextEvent(
              url           = event.buildLink( page="signup" )
            , persistStruct = {
                  validationResult = validationResult
                , savedData        = formData
                , errorMessage     = translateResource( "cms:problem_with_form_submission" )
            }
        );
	}

	public function submitPersonalInfoForm( event, rc, prc, args={} ) {
		var formName         = "signup.personalInfo";
		var formData         = event.getCollectionForForm( formName );
		var validationResult = validateForm( formName, formData );
		if( validationResult.validated() ) {
            SignupService.updateApplicationProgress(
                  step        = 2
                , stateDetail = { step2Detail=formData }
            );
            var result = SignupService.finalizeApplication();

            if( result.statusCode == "SUCCESS" ) {
                setNextEvent( url=event.buildLink( page="login" ) );
            }
        }

        setNextEvent(
              url           = event.buildLink( page="signup" )
            , persistStruct = {
                  validationResult = validationResult
                , savedData        = formData
                , errorMessage     = result.statusCodeMessage
            }
        );
	}
}
