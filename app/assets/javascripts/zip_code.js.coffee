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

  # --- test gmaps link
  geocode_function = ->
    if(status==google.maps.GeocoderStatus.OK)
      map = new google.maps.Map(document.getElementById("the_map"),{
        'center': result[0].geometry.location,
        'zoom': 14,
        'streetViewControl': false,
        'mapTypeId': google.maps.MapTypeId.TERRAIN,
        'noClear':true,
      })
      new google.maps.Marker({
        'map': map,
        'position': result[0].geometry.location,
      })
    else
      alert('Address not found!')

  $('.city-state-div').each ->
    $(@).css 'width', '400px'
    $(@).css 'height', '300px'

  $('.gmaps_link').click ->
    #    false

    link_id = this.id
    div_id = 'div-' + link_id.substr(5)
    alert 'div_id = ' + div_id

    #-------------------
    fenway = new google.maps.LatLng(37.44, -122.2)
    mapOptions = {
      center: fenway,
      zoom: 14,
      mapTypeId: google.maps.MapTypeId.ROADMAP
    }
    map = new google.maps.Map(document.getElementById(div_id), mapOptions)
    #----------------

  $('.latest_gmaps_link').click ->
    #    false

    link_id = this.id

    #==================
    t1 = link_id.substr(5)

    lat = t1.split('--')[0].split(':')[1]
    long = t1.split('--')[1].split(':')[1]
    console.log 'lat = ' + lat
    console.log 'long = ' + long

    #====================

    #----------------------
#    >>> t1 = link_id.substr(5)
#
#    "lat:37.44--long:-122.2"
#
#    >>> lat-long = t1.split('--')
#
#    ReferenceError: invalid assignment left-hand side
#    [Break On This Error]
#
#    ...wport" /><title>Localinfo</title><meta content="" name="description" /><meta con...
#
#    nearby...dius=25 (line 1)
#
#    >>> t1.split('--')
#
#    [
#
#    "lat:37.44"
#
#    ,
#
#    "long:-122.2"
#
#    ]
#
#    >>> lat-long = new Array
#
#    ReferenceError: invalid assignment left-hand side
#    [Break On This Error]
#
#    ...wport" /><title>Localinfo</title><meta content="" name="description" /><meta con...
#
#    nearby...dius=25 (line 1)
#
#    >>> var lat-long = new Array
#
#    SyntaxError: missing ; before statement
#    [Break On This Error]
#
#    ...wport" /><title>Localinfo</title><meta content="" name="description" /><meta con...
#
#    nearby...dius=25 (line 1)
#
#    >>> var lat-long = new Array;
#
#    SyntaxError: missing ; before statement
#    [Break On This Error]
#
#    ...wport" /><title>Localinfo</title><meta content="" name="description" /><meta con...
#
#    nearby...dius=25 (line 1)
#
#    >>> t1.split('--');
#
#    [
#
#    "lat:37.44"
#
#    ,
#
#    "long:-122.2"
#
#    ]
#
#    >>> t1.split('--')[0];
#
#    "lat:37.44"
#
#    >>> t1.split('--')[0].split(':')
#
#    [
#
#    "lat"
#
#    ,
#
#    "37.44"
#
#    ]
#
#    >>> t1.split('--')[0].split(':')[1]
#
#    "37.44"
#
#    >>> t1.split('--')[1].split(':')[1]
#
#    "-122.2"
#    #-----------------------

    div_id = 'div-' + link_id.substr(5)
    alert 'div_id = ' + div_id
    t1 = link_id.substr

    #-------------------
#    fenway = new google.maps.LatLng(37.44, -122.2)
    fenway = new google.maps.LatLng(lat, long)
    mapOptions = {
      center: fenway,
      zoom: 14,
      mapTypeId: google.maps.MapTypeId.ROADMAP
    }
    map = new google.maps.Map(document.getElementById(div_id), mapOptions)
    #----------------

  # ------------- main ---------
  display_query_fields()