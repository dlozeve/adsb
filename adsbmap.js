var map = L.map('map').setView([48.68, 4.9], 7);

L.tileLayer('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png')
    .addTo(map);

function onEachFeature(feature, layer) {
    if (feature.properties && feature.properties.callsign) {
	layer.bindPopup(feature.properties.callsign);
    }
}

L.geoJSON(aller, {
    onEachFeature: onEachFeature
}).addTo(map);

