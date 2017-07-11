/**
 * @singleton true
 * @presideservice
 * @autodoc
 *
 */
component extends="preside.system.services.websiteUsers.WebsiteLoginService"{

	public function updatedUserDetail( required string loginId ) {
		var loginId    = arguments.loginId;
		//the login id is not the id of the user but i saved the user login id using their email
		//hence it is not usable here
		var user       = _getUserByLoginId( loginId=loginId );
		var userRecord = _getUserDao().selectData( id=loginId );
		for( var u in userRecord ) {
			userRecord = u;
			_setUserSession( userRecord );
		}
	}

}
