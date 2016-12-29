var map = L.map('map').setView([48.68, 4.9], 7);

L.tileLayer('https://api.mapbox.com/styles/v1/deltux/cix9hq0il00f42qo9ru2lvi10/tiles/256/{z}/{x}/{y}?access_token=pk.eyJ1IjoiZGVsdHV4IiwiYSI6ImNpdzB4dHhqcDAwMXoyb280c3VyZjVpZmYifQ.8A9IxhBEga9lI1h2zUDSgg')
    .addTo(map);

function onEachFeature(feature, layer) {
    if (feature.properties && feature.properties.callsign) {
	layer.bindPopup(feature.properties.callsign);
    }
}

L.geoJSON(aller, {
    onEachFeature: onEachFeature
}).addTo(map);

