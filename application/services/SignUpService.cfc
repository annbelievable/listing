/**
* @presideService
* @singleton true
*/
component output=false{
    // CONSTRUCTOR
    /**
     * @workflowService.inject      workflowService
     */

    public any function init(
          required any workflowService
    ) {
        _setWorkflowService( arguments.workflowService );
        return this;
    }

    public struct function getApplicationProgress( ) {
        var workflowArgs = {
              workflow  = "new_user"
            , reference = "new_user"
        }
        return _getWorkflowService().getState( argumentCollection=workflowArgs );
    }

    public void function updateApplicationProgress(
          required string step
        ,          struct stateDetail = {}
    ) {
        var workflowArgs = {
              workflow  = "new_user"
            , reference = "new_user"
            , state     = arguments.stateDetail
            , status    = arguments.step
            , expires   = _getApplicationWorkflowExpiry()
        };
        _getWorkflowService().appendToState( argumentCollection=workFlowArgs );
    }

    public struct function finalizeApplication() {
        var result              = { statusCode="SUCCESS" };
        var userDetails         = $getWebsiteLoggedInUserDetails();
        var applicationProgress = getApplicationProgress();
        var applicationState    = applicationProgress.state ?: {};
        var data    = {
              login_id      = applicationState.step1Detail.email_address                                              ?: ""
            , email_address = applicationState.step1Detail.email_address                                              ?: ""
            , display_name  = applicationState.step2Detail.display_name                                               ?: ""
            , first_name    = applicationState.step2Detail.first_name                                                 ?: ""
            , last_name     = applicationState.step2Detail.last_name                                                  ?: ""
            , phone_number  = LSParseNumber( applicationState.step2Detail.phone_number )                              ?: ""
            , address1      = applicationState.step2Detail.address1                                                   ?: ""
            , address2      = applicationState.step2Detail.address2                                                   ?: ""
            , postcode      = applicationState.step2Detail.postcode                                                   ?: ""
            , city          = applicationState.step2Detail.city                                                       ?: ""
            , state         = applicationState.step2Detail.state                                                      ?: ""
        }
        var password      = applicationState.step1Detail.password;

        try {
            var newUser = $getPresideObjectService().insertData(
                  objectName = "website_user"
                , data       = data
            );
            _getWorkflowService().complete( id=applicationProgress.id );
        }
        catch( e ) {
            $raiseError(e);
            result.statusCode        = "FAILED";
            result.statusCodeMessage = "Failed to save the data. Please contact our web administrator";
        }

        if( result.statusCode=="SUCCESS" ) {            //encrypt password
            $getWebsiteLoginService().changePassword( password=password, userId=newUser );
            // sends notification to admin
            $createNotification(
                   topic = "newUser"
                 , type  = "AlERT"
                 , data  = { id=newUser }
             );
            // sends email to user
            $sendEmail(
                  template = "newUserWelcome"
                , to       = [ data.email_address ]
                , args     = { display_name=data.display_name }
            );
        }
        return result;
    }

    private date function _getApplicationWorkflowExpiry() {
        return DateAdd( "d", 1, Now() );
    }



    //getter and setter
    private function _setWorkflowService( required any workflowService ) {
        _workflowService = arguments.workflowService;
    }

    private function _getWorkflowService() {
        return _workflowService;
    }
}







