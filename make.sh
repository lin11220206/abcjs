#!/bin/sh
die () {
    echo >&2 "$@"
    exit 1
}

[ "$#" -eq 1 ] || die "Call with a version number argument in the form x.y.z"
echo $1 | grep -E -q '^[1-9]\.[0-9]+\.[0-9ab]+$' || die "Version number argument required (x.y.z), $1 provided"
echo "Concatenating all files..."
# NOTE: To run this, install uglifier with:
# npm install uglify-js -g
cp file_header.js tmp/file_header.js
perl -pi -e "s/VERSION/$1/" tmp/file_header.js
cat tmp/midijs/Base64.js tmp/midijs/WebAudioAPI.js tmp/midijs/WebMIDIAPI.js tmp/midijs/request_script.js tmp/midijs/request_xhr.js tmp/midijs/util.js tmp/midijs/AudioSupports.js tmp/midijs/EventEmitter.js tmp/midijs/loader.js tmp/midijs/adaptors.js tmp/midijs/adaptors-Audio.js tmp/midijs/adaptors-AudioAPI.js tmp/midijs/adaptors-MIDI.js tmp/midijs/channels.js tmp/midijs/gm.js tmp/midijs/player.js > tmp/midijs.js
cat api/*.js data/*.js midi/*.js parse/*.js write/*.js > tmp/abcjs-noraphael.js
cat raphael.js tmp/abcjs-noraphael.js > tmp/abcjs_basic.js
cat tmp/midijs.js tmp/abcjs_basic.js > tmp/abcjs_basic_midi.js

