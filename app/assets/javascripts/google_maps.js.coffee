google_map = (address, title) ->
  geocoder = new google.maps.Geocoder()
  geocoder.geocode
    address: address
  , (results, status) ->
    if status is google.maps.GeocoderStatus.OK
      latlng = new google.maps.LatLng(results[0].geometry.location)
      myOptions =
        zoom: 12
        center: latlng
        mapTypeId: google.maps.MapTypeId.ROADMAP
      map = new google.maps.Map(document.getElementById("map_canvas"), myOptions)
      map.setCenter results[0].geometry.location
      contentString = "<div id='content'><div id='siteNotice'></div><h3 id='firstHeading' class='firstHeading'>#{title}</h3><div id='bodyContent'><p>#{address}</p></div></div>"
      infowindow = new google.maps.InfoWindow(content: contentString)
      marker = new google.maps.Marker(
        map: map
        position: results[0].geometry.location
        title: title
      )
      google.maps.event.addListener marker, "click", ->
        infowindow.open map, marker
window.google_map = google_map