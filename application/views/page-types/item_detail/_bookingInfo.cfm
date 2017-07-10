<cfscript>
    savedData                 = rc.savedData        ?: {};
    validationResult          = rc.validationResult ?: "";
</cfscript>

<cfoutput>
    <div class="form-wrap">
        <form name="bookingInfo" id="bookingInfo" action="#event.buildLink( linkto="page-types.item_detail.submitBookingInfoForm" )#" method="post">
            <!--- <input name="csrfToken" type="hidden" value="#event.getCsrfToken()#"> --->

            #renderForm(
                  formName            = "custom.bookingInfo"
                , formId              = "bookingInfo"
                , context             = "website"
                , savedData           = savedData
                , validationResult    = validationResult
            )#

            <div class="form-submit u-aligned-center">
                <input type="submit" value="Book" class="btn">
            </div>
        </form>
    </div>
</cfoutput>
