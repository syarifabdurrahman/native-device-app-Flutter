const API_KEY = 'b8142eda582d4a7992c63f0447c6f325';

class LocationHelper {
  static String generateImageLocation() {
    return 'https://maps.geoapify.com/v1/tile/carto/{z}/{x}/{y}.png?&apiKey=${API_KEY}';
  }

  static String generateMarkerLocation() {
    return 'https://api.geoapify.com/v1/icon?type=awesome&color=%2352b74c&size=x-large&icon=tree&noWhiteCircle=true&scaleFactor=2&apiKey=${API_KEY}';
  }
}
