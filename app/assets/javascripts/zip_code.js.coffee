# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  $('.zip-code-li > div').css       "color",        "black"
  $('.zip-code-li:even > div').css  "background",   "#c0d0b0"

  $('#show-zip-codes').click ->
    latitude    = $('#latitude').val()
    longitude   = $('#longitude').val()
    radius      = $('#radius').val()

    this.href += '?latitude=' + latitude + '&longitude=' + longitude + '&radius=' + radius

    console.log 'href = ' + this.href
