class FetchContactsQuery {
  final String nationalNumber;
  final String countryCode;
  final String regionCode;

  FetchContactsQuery({
    required this.nationalNumber,
    required this.countryCode,
    required this.regionCode,
  });

  factory FetchContactsQuery.fromArgs(List<String> args) {
    if (args.length < 3) {
      throw ArgumentError(
        'Expected at least 3 arguments: nationalNumber, countryCode, regionCode',
      );
    }
    return FetchContactsQuery(
      nationalNumber: args[0],
      countryCode: args[1],
      regionCode: args[2],
    );
  }
}
