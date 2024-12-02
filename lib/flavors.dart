enum Flavor {
  production,
  development,
  staging,
}

class F {
  static Flavor? appFlavor;

  static const String productionApiUrl = 'https://api.production.com';
  static const String developmentApiUrl = 'https://api.development.com';
  static const String testingApiUrl = 'https://api.testing.com';

  // Add a method to get the appropriate API URL based on the current flavor
  static String get apiUrl {
    print(appFlavor);
    switch (appFlavor) {
      case Flavor.production:
        return productionApiUrl;
      case Flavor.development:
        return developmentApiUrl;
      case Flavor.staging:
        return testingApiUrl;
      default:
        return 'title';
    }
  }
  static String get name => appFlavor?.name ?? '';

  static String get title {
    switch (appFlavor) {
      case Flavor.production:
        return 'Production App';
      case Flavor.development:
        return 'Development App';
      case Flavor.staging:
        return 'Staging App';
      default:
        return 'title';
    }
  }

}
