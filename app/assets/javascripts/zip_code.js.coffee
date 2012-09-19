# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  $('.zip-code-li > div').css       "color",        "black"
  $('.zip-code-li:even > div').css  "background",   "#c0d0b0"

  query_string = '?'

  do ->
    $('.query-type:checked').each ->
      console.log 'checked value: ' + this.value

      query_string += 'query_type=' + this.value

      switch this.value
        when 'zip_code'
          zip_code = $('#zip-code').val()
          query_string += '&zip_code=' + zip_code

        when 'city_state'
          console.log 'CITY_STATE'

          city    = $('#city').val()
          state   = $('#state').val()

          query_string += '&city=' + city + '&state=' + state

        when 'latitude_longitude'
          latitude    = $('#latitude').val()
          longitude   = $('#longitude').val()

          query_string += '&latitude=' + latitude + '&longitude=' + longitude

        else
          alert 'unepected query-type: ' + this.value

  $('#show-zip-codes').click ->
    radius      = $('#radius').val()
    query_string += '&radius=' + radius

    console.log 'query_string::: ' + query_string

    this.href += query_string
    console.log 'href = ' + this.href
