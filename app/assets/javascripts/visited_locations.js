$(document).ready(function() {
  var map = createMap();

  var container = document.getElementById('popup');
  var content = document.getElementById('popup-content');
  var closer = document.getElementById('popup-closer');
  var form = $('form[name=mark-location]');
  var userId = $('#user_id').val();
  var data;

  var overlay = new ol.Overlay({
    element: container,
    id: 'current-location-popup',
    autoPan: true,
    autoPanAnimation: {
      duration: 250
    }
  });

  closer.onclick = function() {
    overlay.setPosition(undefined);
    closer.blur();
    return false;
  };

  map.on('click', function(evt) {
    if (map.getOverlayById('current-location-popup') == null) {
      map.addOverlay(overlay);
    }

    var coordinate = evt.coordinate;
    var latLongCoordinate = ol.proj.toLonLat(coordinate);
    var hdms = ol.coordinate.toStringHDMS(latLongCoordinate);
    form.append($('<input>').attr({
        type: 'hidden',
        id: 'longitude',
        name: 'longitude',
        value: latLongCoordinate[0]
    }));

    form.append($('<input>').attr({
        type: 'hidden',
        id: 'latitude',
        name: 'latitude',
        value: latLongCoordinate[1]
    }));

    content.innerHTML = '<p>You clicked here:</p><code>' + hdms + '</code>';
    overlay.setPosition(coordinate);
  });

  if(userId !== undefined) {
    data = {user_id: userId}
  }
  else {
    data = {}
  }
  $.ajax({
    url: 'visited_locations/all',
    method: 'GET',
    data: data,
    success: function(response) {
      if (response.success) {
        response.visited_locations.forEach(function(location) {
          addMapPoint(map, location.latitude, location.longitude, 'green');
        });

        response.friends_visited_locations.forEach(function(location) {
          addMapPoint(map, location.latitude, location.longitude, 'blue');
        })
      }
    }
  });
});