#! /usr/bin/env bash

if [ "$1" ]; then
	echo "use <_cookie_cutter.scad>";
	echo "cookie_cutter_from_dxf(\"$(basename "$1" '.scad').dxf\");";
else
	find src -name '*.svg' -not -name '_*' | sed -r 's,\.svg$,.scad,'
fi
