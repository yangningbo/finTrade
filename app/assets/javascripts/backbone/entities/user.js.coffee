@RegistryUI.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->
  smuEmailRegex = /^[\w\-\.]+@[\w\-]+(\.smu\.edu\.sg)$/
  class Entities.user extends Backbone.Model

    validate: (attrs)->
      attrs = attrs || {}
      errors = []

      if !attrs.name
        errors.push({
          type:'name'
          message:'Name is required.'
        })
      if !attrs.email
        errors.push({
          type:"email"
          message:'Email is required.'
        })
      else
        if !smuEmailRegex.test attrs.email
          errors.push({
            type:"email"
            message:'Invalid SMU email address.'
          })
      if !attrs.password
        errors.push({
          type:"password"
          message:'Password is required.'
        })
      if !attrs.confirm_password
        errors.push({
          type:"confirm_password"
          message:'Confirm your password is required.'
        })
      else
        if attrs.confirm_password != attrs.password
          errors.push({
            type:"confirm_password"
            message:'password does not match'
          })

      if errors.length > 0 then errors else null

    setCreateData: (form)->
      data = App.Utilities.getFormData(form)
      if !_.isEmpty(data)
        @set data
        @setNewUserUrl data
        return true
      else
        return false

    setNewUserUrl: ->
      @url = '/api/users/new'