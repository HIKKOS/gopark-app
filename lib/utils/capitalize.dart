capitalize(String s, {bool lowerRest = true}) =>
    '${s[0].toUpperCase()}${(lowerRest) ? s.substring(1).toLowerCase() : s.substring(1)}';
