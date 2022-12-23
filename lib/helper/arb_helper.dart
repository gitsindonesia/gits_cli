import 'dart:convert';

import 'package:collection/collection.dart';

/// Includes the novel keys of `arb2Contents` in the `arb1Contents`
/// and returns the result of the merge. In case of discrepances of
/// the values for the same key, the `arb2Contents` will prevail
///
/// In a nutshell `arb1Contents` <-merge-- `arb2Contents`
String mergeARBs(String arb1Contents, String arb2Contents) {
  Map<String, dynamic> ret = json.decode(arb1Contents);
  Map<String, dynamic> json2 = json.decode(arb2Contents);
  for (var key in json2.keys) {
    ret[key] = json2[key];
  }
  return json.encode(ret);
}

/// Sorts the .arb formatted String `arbContents` in alphabetical order
/// of the keys, with the @key portion added below it's respective key
/// Optionally you can provide a `compareFunction` for customizing the sorting.
/// For simplicity sake there are common sorting features you can use when not
/// defining the former parameter
String sortARB(String arbContents,
    {int Function(String, String)? compareFunction,
    bool caseInsensitive = false,
    bool naturalOrdering = false,
    bool descendingOrdering = false}) {
  compareFunction ??= (a, b) =>
      _commonSorts(a, b, caseInsensitive, naturalOrdering, descendingOrdering);

  final sorted = <String, dynamic>{};
  final Map<String, dynamic> contents = json.decode(arbContents);

  final keys = contents.keys.where((key) => !key.startsWith('@')).toList()
    ..sort(compareFunction);

  // Add at the beginning the [Global Attributes] of the .arb original file, if any
  // [link]: https://github.com/google/app-resource-bundle/wiki/ApplicationResourceBundleSpecification#global-attributes
  contents.keys.where((key) => key.startsWith('@@')).toList()
    ..sort(compareFunction)
    ..forEach((key) {
      sorted[key] = contents[key];
    });
  for (final key in keys) {
    sorted[key] = contents[key];
    if (contents.containsKey('@$key')) {
      sorted['@$key'] = contents['@$key'];
    }
  }

  final encoder = JsonEncoder.withIndent('  ');
  return encoder.convert(sorted);
}

int _commonSorts(String a, String b, bool isCaseInsensitive,
    bool isNaturalOrdering, bool isDescending) {
  var ascending = 1;
  if (isDescending) {
    ascending = -1;
  }
  if (isCaseInsensitive) {
    a = a.toLowerCase();
    b = b.toLowerCase();
  }

  if (isNaturalOrdering) {
    return ascending * compareNatural(a, b);
  } else {
    return ascending * a.compareTo(b);
  }
}
