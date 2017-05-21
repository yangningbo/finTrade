@RegistryUI.module "Utilities", (Utilities, App, Backbone, Marionette, $, _) ->
  @getFormData = (form) ->
    that = @
    textInput = form.find('input[type="text"],input[type="password"]')
    checkboxInput = _.groupBy(form.find('input[type="checkbox"]'),'name')
    radioInput = _.groupBy(form.find('input[type="radio"]'),'name')
    outputData = {}
    if textInput.length > 0
      textInput.each ->
        that.getInputData $(this), outputData
    if !_.isEmpty(checkboxInput)
      for key, value of checkboxInput
        that.getCheckboxData key, value, outputData
    if !_.isEmpty(radioInput)
      @getRadioInput radioInput, outputData
    if form.find('input.invalid').length == 0
      return outputData
    else
      return null

  @getRadioInput = (key, value, outputData) ->
    val = $(value).filter('input:checked').val()
    @setData key, val, outputData

  @getCheckboxData = (key, value, outputData) ->
    selected = []
    inputs = $(value).filter('input:checked')
    least  = parseInt($(value).attr('data-validate-least')) or 0
    if inputs.length >= least
      inputs.each ->
        selected.push $(this).val()
      @setData key, selected, outputData

  @getInputData = (input,output) ->
    validateType = input.attr('data-validate-type')
    val = $.trim(input.val())
    errMsg = input.attr('data-validate-msg') or null
    if validateType == 'length'
      length = parseInt(input.attr('data-validate-value'))
      if val.length<length
        @setInvalid input, errMsg
    if validateType == 'email'
      if !(App.consts.emailRegex.test val)
        @setInvalid input, errMsg
    if !input.hasClass('invalid')
      @setData input.attr('name'), val, output

  @setInvalid = (item, errMsg)->
    item.addClass('invalid')
    item.next('.message').html(errMsg) if errMsg

  @setData = (key,val,data)->
    temp = {}
    temp[key] = val
    _.extend data, temp

  @urlString = (data) ->
    str = ''
    if !!data and data.length > 0
      for key,val of data
        str += "#{key}=#{val}&"
    str