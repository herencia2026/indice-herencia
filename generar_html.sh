#!/bin/bash
set -euo pipefail
XSL="/usr/share/xml/docbook/stylesheet/docbook-xsl/html/docbook.xsl"
for f in A H R index creditos; do
  tmp=".${f}.latin1.html"
  out="${f}.html"
  xsltproc --stringparam html.stylesheet style.css "$XSL" "${f}.xml" > "$tmp"
  # DocBook XSL emits ISO-8859-1; convert the actual bytes to UTF-8.
  iconv -f ISO-8859-1 -t UTF-8 "$tmp" > "$out"
  rm "$tmp"
  # Make the HTML declaration agree with the converted bytes.
  sed -i 's/charset=ISO-8859-1/charset=UTF-8/g; s/charset=iso-8859-1/charset=UTF-8/g' "$out"
done
printf 'HTML generados y convertidos a UTF-8. Verificación:\n'
file -bi A.html H.html R.html index.html creditos.html
