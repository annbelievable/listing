component {

  property name="UserService"   inject="UserService";

  private struct function prepareParameters() {
    user_id  = (arguments.user_id?:"");
    new_user = UserService.getUserByIdOrEmail( id=user_id, selectFields=["display_name"] );
    return {
      display_name = new_user.display_name
    };
  }

  private struct function getPreviewParameters() {
    return {
      display_name = "Dinosaur Popeye"
    };
  }

  private string function defaultSubject() {
    return "Welcome to Listing";
  }

}

