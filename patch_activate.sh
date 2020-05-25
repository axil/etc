#!/bin/sh
sed -i~ 's/basename \\"\$VIRTUAL_ENV\\"/basename \\`dirname \\"$VIRTUAL_ENV\\"\\`/' env/bin/activate
