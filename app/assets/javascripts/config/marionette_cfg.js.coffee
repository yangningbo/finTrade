_.extend Marionette.Renderer,
  lookups: [
    "backbone/logout_view/"
    "backbone/logout_view/components/"
  ]

  render: (template, data) ->
    return if template is false
    path = @getTemplate template
    throw "Template #{template} not found!" unless path
    path(data)

  getTemplate: (template) ->
    for lookup in @lookups
      for path in [template, @withTemplate(template)]
        return JST[lookup + path] if JST[lookup + path]

  withTemplate: (string) ->
    array = string.split "/"
    array.splice(-1, 0, "templates")
    array.join "/"

Marionette.Module::controllers = new Backbone.Collection
Marionette.Module::getController = (name, options) ->
  if !name and @router
    controller = @router.controller
  else
    controller = @controllers.findWhere name: name
    controller = controller?.controller

    if !controller
      controller = new @[name].Controller
      @controllers.add name: name, controller: controller

  controller

Marionette.Application::addRegions = (regionDefinitions, defaults)->
  @_regionManager.addRegions regionDefinitions, defaults

Marionette.Callbacks::isEmpty = -> @_callbacks.length is 0