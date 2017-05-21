@RegistryUI.module "LogoutView", (LogoutView, App, Backbone, Marionette, $, _) ->
  class LogoutView.Controller extends Marionette.Controller
    initialize: (options)->
      _.extend @, options
      @options = options
      @currentSession = 'home'
      @initRegions()
      @initModels()
      @renderInitView()

    initRegions: ->
      App.addRegions
        viewContainerRegion: '#view-container'
        navbarContainerRegion: '.navbar-menu'

    renderInitView: ->
      App.viewContainerRegion.show new App.LogoutView.View
        controller: @
        status: 'home'
      App.navbarContainerRegion.show new App.LogoutView.navbar
        controller: @
    initModels: ->
      @user = new App.Entities.user

    renderRegisterView: ->
      @changeSession('registration')
      App.viewContainerRegion.show new App.LogoutView.RegisterView
        model: @user

    renderToView: (toView)->
      @changeSession(toView)
      App.viewContainerRegion.show new App.LogoutView.View
        status: toView
        controller: @

    changeSession: (session, callback)->
      @currentSession = session
      App.navbarContainerRegion.currentView?.render()

  class LogoutView.Router extends Marionette.AppRouter
    appRoutes:
      ':toView': 'renderToView'
      'user/register': 'renderRegisterView'
#      'charity-registry(/:list)': 'renderCharitySettings'
#      'wedding-website': 'renderWwsSettings'
#      'display-settings': 'renderRegistrySettings'
#      'email-share': 'renderEmailSharing'

  LogoutView.on 'start', (options)->
    @router = new LogoutView.Router
      controller: new LogoutView.Controller(options)
    Backbone.history.start(pushState:true)