import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="map"
export default class extends Controller {
  static values = {
    apiKey: String,
    markers: Array
   }

  connect() {
    mapboxgl.accessToken = this.apiKeyValue;
    this.map = new mapboxgl.Map({
      container: this.element,
      style: 'mapbox://styles/mapbox/streets-v12',
      projection: 'globe', // Display the map as a globe, since satellite-v9 defaults to Mercator
      zoom: 0,
      maxZoom: 15,
    });
    this.#addMarkersToMap()
    this.#fitMapToMarkers()
  }

  #fitMapToMarkers() {
    const bounds = new mapboxgl.LngLatBounds();
    this.markersValue.forEach((marker) => {
      bounds.extend([marker.lng, marker.lat]);
    });
    this.map.fitBounds(bounds, {
      padding: 40,
      duration: 10
    });
  }

  #addMarkersToMap() {
    this.markersValue.forEach((marker) => {
      const pokeBall = document.createElement('div');
      pokeBall.className = 'poke-ball';
      pokeBall.style.backgroundImage = `url('${marker.image_url}')`;
      pokeBall.style.backgroundSize = "contain";

      const popup = new mapboxgl.Popup().setHTML(marker.infoWindow);
      new mapboxgl.Marker({element: pokeBall})
        .setLngLat([marker.lng, marker.lat])
        .setPopup(popup)
        .addTo(this.map);
    });
  }
}

