Accounts.oauth.registerService "twitch"
if Meteor.isClient
  Meteor.loginWithTwitch = (options, callback) ->
    
    # support a callback without options
    if not callback and typeof options is "function"
      callback = options
      options = null
    credentialRequestCompleteCallback = Accounts.oauth.credentialRequestCompleteHandler(callback)
    Meetup.requestCredential options, credentialRequestCompleteCallback
    return
else
  Accounts.addAutopublishFields
    
    # publish all fields including access token, which can legitimately
    # be used from the client (if transmitted over ssl or on
    # localhost). http://api.twitch.tv/kraken/auth/#oauth2implicit
    forLoggedInUser: ["services.twitch"]
    forOtherUsers: ["services.twitch.id"]