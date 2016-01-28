geocoder = null
map = null
marker = null
markersPhoto = []

@initGoogleMaps = ->
  geocoder = new google.maps.Geocoder()
  latlng = new google.maps.LatLng(10.8400714, 106.67377839999999)
  mapOptions =
    center: latlng
    zoom: 15

  mapDiv = document.getElementById('map-canvas')
  map = new (google.maps.Map)(mapDiv, mapOptions)

  marker = new google.maps.Marker
    position: latlng
    map: map
    title: 'Drag this icon to select new location'
    draggable: true

  google.maps.event.addListener marker, 'dragend', (location) ->
    if location
      setLatLngValue(location.latLng.lat(), location.latLng.lng())
    return
  return

@setLocationAddress = ->
  $('#address').geocomplete().bind 'geocode:result', (event, result) ->
    getLatLngByAddress()
    return
  return

@getLatLngByAddress = ->
  address = document.getElementById('address').value
  return unless address
  geocoder.geocode { 'address': address }, (results, status) ->
    if status == google.maps.GeocoderStatus.OK
      location = results[0].geometry.location
      map.setCenter location
      if marker
        marker.setPosition(location)
      else
        marker = new (google.maps.Marker)
          map: map
          position: location
          draggable: true
      if location
        setLatLngValue(location.lat(), location.lng())
      return
    return
  return

@getTimePost = ->
  $('.info-top').each ->
    time = parseInt($(@).data('time'))
    txtTime = moment(time*1000).fromNow()
    $(@).find('.time').html txtTime
  return

@setLatLngValue = (lat, lng)->
  $('#latitude').val(lat)
  $('#longitude').val(lng)

@showAllPhotosOnMap = ->
  clearMarkers()
  $('.media-box').each ->

    lat = $(@).data('lat')
    lng = $(@).data('lng')
    thumbUrl = $(@).data('thumb-url')
    username = $(@).data('username')
    latLngPhoto = new google.maps.LatLng(lat, lng)

    mk = new google.maps.Marker
      position: latLngPhoto
      map: map
      title: username

    mk.setIcon
      url: thumbUrl
      scaledSize: new google.maps.Size(60, 60)
      origin: new google.maps.Point(0, 0)
      anchor: new google.maps.Point(60/2, 60/2)

    markersPhoto.push(mk)
    return
  return

@clearMarkers = ->
  i = 0
  while i < markersPhoto.length
    markersPhoto[i].setMap null
    i++
  markersPhoto = []
  return

@updateMarker = (lat, lng)->
  $(".btn-search").on 'click', ->
    return unless $("#search-form").valid()
    lat = $('#latitude').val()
    lng = $('#longitude').val()
    latlng = new google.maps.LatLng(lat, lng)
    map.panTo(latlng)
    marker.setPosition(latlng)
    return
  return

@scrollTopToPost = ->
  $('html, body').animate { scrollTop: $('#photos-result').position().top - 20 }, 'slow'
  return

$(document).ready ->
  $('[data-toggle="tooltip"]').tooltip()
  validateSearchForm()
  setLocationAddress()
  getTimePost()
  updateMarker()
  $(".btn-search").trigger 'click'
  return