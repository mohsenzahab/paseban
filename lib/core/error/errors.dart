enum Errors {
  hostUnreachable('Host unreachable'),
  noNetworkAccess('No network access');

  const Errors([this.message]);

  final String? message;
  // final int? errorCode;
}
