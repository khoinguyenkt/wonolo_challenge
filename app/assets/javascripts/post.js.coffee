geocoder = null
map = null
marker = null
self = @
markersPhoto = []

@initGoogleMaps = ->
  geocoder = new google.maps.Geocoder()
  latlng = new google.maps.LatLng(10.8400714, 106.67377839999999)
  mapOptions =
    center: latlng
    zoom: 15

  mapDiv = document.getElementById('map-canvas')
  map = new (google.maps.Map)(mapDiv, mapOptions)

  marker = new (google.maps.Marker)
    position: latlng
    map: map
    title: 'Drag this icon to select new location'
    draggable: true
  return

@showImageAjaxLoading = ->
  $("#search-form").ajaxSend ->
    $(".ajax-loading").removeClass('hidden')
    return
  return
@hideImageAjaxLoading = ->
  $("#search-form").ajaxComplete ->
    $(".ajax-loading").addClass('hidden')
    return
  return

$(document).ready ->
  $('[data-toggle="tooltip"]').tooltip()
  initGoogleMaps()
  @showImageAjaxLoading()
  @hideImageAjaxLoading()
  return