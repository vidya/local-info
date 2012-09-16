# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  $('.zip_code_li > div').css       "color",        "black"
  $('.zip_code_li:even > div').css  "background",   "#c0d0b0"

  $('#show-zip-codes').click ->
    # alert 'btn click'
    latitude    = $('#latitude').val()
    longitude   = $('#longitude').val()
    radius      = $('#radius').val()

    href = this.href

    href += '?'
    href += 'latitude=' + latitude

    href += '&'
    href += 'longitude=' + longitude

    href += '&'
    href += 'radius=' + radius
    this.href = href

    console.log 'href = ' + href
    console.log 'latitude = ' + latitude
    console.log 'longitude = ' + longitude
    console.log 'radius = ' + radius
