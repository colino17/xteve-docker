#!/bin/sh

XTEVE_FILE=/config/xteve.conf

if [ -f "$XTEVE_FILE" ]; then
	xteve -port=34400 -config=/config
else
	cp /sample.conf /config/xteve.conf
	xteve -port=34400 -config=/config
fi

exit
