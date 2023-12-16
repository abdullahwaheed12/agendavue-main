class ZipCodeResult {
  String? districtName, districtUrl, address;

  ZipCodeResult({this.districtName, this.districtUrl, this.address});

  @override
  String toString() {
    return 'ZipCodeResult{districtName: $districtName, districtUrl: $districtUrl, address: $address}';
  }
}
