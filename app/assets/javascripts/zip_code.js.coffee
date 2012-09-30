# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  $('.zip-code-div').css       "color",        "black"
  $('.zip-code-div:even').css  "background",   "#c0d0b0"
  $('.zip-code-div:odd').css  "background",   "lightgoldenrodyellow"

  display_query_fields = ->
    $('.query-type:checked').each ->
      switch this.value
        when 'zip_code'
          $('#city-state-div').hide()
          $('#lat-long-div').hide()
          $('#zip-code-div').show()

        when 'city_state'
          $('#zip-code-div').hide()
          $('#lat-long-div').hide()
          $('#city-state-div').show()

        when 'latitude_longitude'
          $('#zip-code-div').hide()
          $('#city-state-div').hide()
          $('#lat-long-div').show()

        else
          alert 'unepected query-type: ' + this.value

  get_query_string = ->
    query_string = '?'

    $('.query-type:checked').each ->
      query_string += 'query_type=' + this.value

      switch this.value
        when 'zip_code'
          query_string += '&zip_code=' + $('#zip-code').val()

        when 'city_state'
          query_string += '&city=' + $('#city').val()
          query_string += '&state=' + $('select#state_selection option:selected').val()

        when 'latitude_longitude'
          query_string += '&latitude=' + $('#latitude').val()
          query_string += '&longitude=' + $('#longitude').val()

        else
          alert 'unepected query-type: ' + this.value

    query_string += '&radius=' + $('#radius').val()

  $('.query-type').click ->
    display_query_fields()

  $('#show-zip-codes').click ->
    this.href += get_query_string()
    console.log 'href = ' + this.href

  # ------------- main ---------
  display_query_fields()