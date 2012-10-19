# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  # --- neighbor: highlight on hover
  add_highlighting        = -> $(@).addClass "active-area"
  delete_highlighting     = -> $(@).removeClass "active-area"

  $('.neighbor-div').hover add_highlighting, delete_highlighting

  # --- gmaps call
  set_map_in_div = (options) ->
    center      = new google.maps.LatLng options.lat, options.long
    zoom        = 12
    mapTypeId   = google.maps.MapTypeId.ROADMAP

    new google.maps.Map $('#' + options.div_id)[0], {center, zoom, mapTypeId}

  # --- gmaps link
  $('.gmaps_link').each ->
    lat_long_str  = @.id
    div_id        = 'div-' + lat_long_str

    [lat_str, long_str]   = lat_long_str.split '--'

    lat           = lat_str.replace(/-x-/, '.')
    long          = long_str.replace(/-x-/, '.')

    $(@).data 'params', {lat, long, div_id}

  $('.gmaps_link').click ->
    data = $(@).data 'params'

    set_map_in_div data

    $('#' + data.div_id).css 'display', 'block'

  # --- index page
  class IndexPage
    constructor: (@query_method) ->

    set_query_method: (@query_method) ->

    display_query: ->
      switch @query_method
         when 'zip_code'
           $('#city-state-query').hide()
           $('#lat-long-query').hide()
           $('#zip-code-query').show()

         when 'city_state'
           $('#zip-code-query').hide()
           $('#lat-long-query').hide()
           $('#city-state-query').show()

         when 'latitude_longitude'
           $('#zip-code-query').hide()
           $('#city-state-query').hide()
           $('#lat-long-query').show()

         else
           alert 'display_query_fields: unepected query-type: ' + @query_method

    query_string: ->
      query_string         = '?query_type=' + @query_method

      switch @query_method
        when 'zip_code'
          query_string    += '&zip_code=' + $('#zip-code').val()

        when 'city_state'
          query_string    += '&city=' + $('#city').val() +
                             '&state=' + $('select#state_selection option:selected').val()

        when 'latitude_longitude'
          query_string    += '&latitude=' + $('#latitude').val() +
                             '&longitude=' + $('#longitude').val()

        else
          alert 'get_query_string: unepected query-type: ' + @query_method

      query_string        += '&radius=' + $('#radius').val()

  # ------------- main ---------
  console.log "page id: #{window.location.pathname}"

  switch window.location.pathname
    when  '/zip_code/index'
      $('.query-radio-btn').click ->
        index_page.set_query_method(@.value)
        index_page.display_query()

      $('#show-neighbors').click ->
        @.href += index_page.query_string()
        console.log '22b - href = ' + @.href

      index_page = new IndexPage('city_state')
      index_page.display_query()

    else
      console.log "UNKNOWN PAGE: #{window.location.pathname}"
