#!/bin/sh

/Users/reva/Documents/Library/flex_sdk_4.6/bin/mxmlc src/Migration.as -source-path=src/ -load-config+=release-build.xml -output output/Migration.swf -default-size 640 480 && open output/Migration.swf
