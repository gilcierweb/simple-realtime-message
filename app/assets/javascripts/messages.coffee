# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on "ajax:success", "form", (xhr, data, response) ->
  if data.error
    for message of data
      $('#errors ul').append '<li>' + data.error[message] + '</li>'