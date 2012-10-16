# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  display_query_fields = ->
    $('.query-radio-btn:checked').each ->
      switch @.value
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
          alert 'display_query_fields: unepected query-type: ' + @.value

  get_query_string = ->
    query_string = '?'

    $('.query-radio-btn:checked').each ->
      query_string        += 'query_type=' + (@).value

      switch @.value
        when 'zip_code'
          query_string    += '&zip_code=' + $('#zip-code').val()

        when 'city_state'
          query_string    += '&city=' + $('#city').val() +
                             '&state=' + $('select#state_selection option:selected').val()

        when 'latitude_longitude'
          query_string    += '&latitude=' + $('#latitude').val() +
                             '&longitude=' + $('#longitude').val()

        else
          alert 'get_query_string: unepected query-type: ' + @.value

    query_string          += '&radius=' + $('#radius').val()

  $('.query-radio-btn').click -> display_query_fields()

  # --- neighbor: highlight on hover
  add_highlighting        = -> $(@).addClass "active-area"
  delete_highlighting     = -> $(@).removeClass "active-area"

  $('.neighbor-div').hover add_highlighting, delete_highlighting

  # ---
  $('#show-zip-codes').click ->
    @.href += get_query_string()
    console.log 'href = ' + @.href

  # --- gmaps call
  set_map_in_div = (options) ->
    map_center = new google.maps.LatLng(options.lat, options.long)

    mapOptions = {
      center:       map_center,
#      zoom:         14,
      zoom:         12,
      mapTypeId:    google.maps.MapTypeId.ROADMAP
    }

#    new google.maps.Map(document.getElementById(options.div_id), mapOptions)
    new google.maps.Map($('#' + options.div_id)[0], mapOptions)

  # --- gmaps link
  $('.latest_gmaps_link').click ->
    link_id       = this.id

    lat_long_str  = link_id.substr(5)
    div_id        = 'div-' + lat_long_str

    lat_long      = lat_long_str.split('--')

    lat           = lat_long[0].split('_')[1]
    long          = lat_long[1].split('_')[1]

    lat = lat.replace(/-x-/, '.')
    long = long.replace(/-x-/, '.')

    console.log '9ji lat = ' + lat
    console.log 'long = ' + long

    options = {
      lat:      lat,
      long:     long,
      div_id:   div_id
    }

    set_map_in_div(options)

    $('#' + div_id).css 'display', 'block'

  # ------------- main ---------
  display_query_fields()