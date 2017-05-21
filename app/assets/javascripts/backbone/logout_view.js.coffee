#window.ActivitiesRegistry =
#  Models: {}
#  Collections: {}
#  Views: {}
#  Routers: {}
#  initialize: -> alert 'Hello from Backbone!'
#
#$(document).ready ->
#  ActivitiesRegistry.initialize()

@RegistryUI = do (Backbone, Marionette) ->
  App = new Marionette.Application
  App.on 'before:start', (options = {})->
    _.extend App, options

  App