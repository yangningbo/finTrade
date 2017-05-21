// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
// basic third-part libs
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require jquery.cookie

// backbone marionette dependencies
//= require underscore
//= require backbone
//= require backbone-validation
//= require marionette
//= require honeybadger.min
//= require hamlcoffee
//= require jquery-ui-sortable.min
//= require jquery.backstretch.min

//= require_tree ./config
//= require backbone/logout_view
//= require_tree ./backbone/lib
//= require_tree ./backbone/entities
//= require_tree ./backbone/logout_view

$(function(){
    RegistryUI.start(window.gon);
});