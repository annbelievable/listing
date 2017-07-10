component output=false{

    property name="UserService" inject="UserService";

	private string function emailSubject( event, rc, prc, args={} ) {
        var data    = deserializeJSON(args.data);
        var id      = data.id;
        return "New User Sign Up, id: #id#.";
    }

	private string function emailHtml( event, rc, prc, args={} ) {
        var data    = deserializeJSON(args.data);
        var id      = data.id;
        var newUser = UserService.getUserByIdOrEmail(
                      id           = id
                    , selectFields = ["id", "email_address", "display_name"]
        );
        return renderView(
              view = "/renderers/notifications/newUser/emailHtml"
            , args = newUser
        );
    }

    private string function emailText( event, rc, prc, args={} ) {
        var data    = deserializeJSON(args.data);
        var id      = data.id;
        var newUser = UserService.getUserByIdOrEmail(
                      id           = id
                    , selectFields = ["id", "email_address", "display_name"]
        );
        return renderView(
              view = "/renderers/notifications/newUser/emailText"
            , args = newUser
        );
    }

    private string function full( event, rc, prc, args={} ) {
        var id      = args.id;
        var newUser = UserService.getUserByIdOrEmail(
                      id           = id
                    , selectFields = ["id", "email_address", "display_name"]
        );
        return renderView(
              view = "/renderers/notifications/newUser/full"
            , args = newUser
        );
    }

    private string function datatable( event, rc, prc, args={} ) {
        return "New User Sign Up, id: #args.id#.";
    }

}