# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  #  $('.zip_code_li').click -> alert 'li clicked'
  $('.zip_code_li > div').css       "color",        "black"
  $('.zip_code_li:even > div').css  "background",   "#c0d0b0"
