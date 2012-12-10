# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  class IndexPage
    query_string: ->
      query_string    = '?zip_code=' + $('#area-zip-code').val()
      console.log "query_string = #{query_string}"
      query_string

    add_show_area_handler: ->
      self = this

      $('#show-area-link').click ->
        @.href += self.query_string()

  class ShowAreaPage

  class ShowPlacesPage
    query_string: ->
      query_string    = '?'
      query_string   += 'street_address=' + $('#street-address').val()
      query_string   += '&city=' + $('#places-city').val()
#      query_string   += '&state=' + $('#places-state').val()
      query_string   += '&zipcode=' + $('#places-zip-code').val()

      console.log "query_string = #{query_string}"
      query_string

    add_show_places_handler: ->
      self = this

      $('#show-places').click ->
#        self = this
        #      alert 'Here'
        @.href += self.query_string()

  # ------------- main ---------
  $('.disabled-link').bind 'click', false

  switch window.location.pathname
    when  "/home/index", "/"
      index_page = new IndexPage

      index_page.add_show_area_handler()

    when "/home/show_area"
      area_page = new ShowAreaPage

#    when "/home/show_places"
    when "/home/neighborhood"
      console.log "THIS PAGE: neighborhood: #{window.location.pathname}"
      places_page = new ShowPlacesPage
      places_page.add_show_places_handler()

    else
      console.log "UNKNOWN PAGE: #{window.location.pathname}"

