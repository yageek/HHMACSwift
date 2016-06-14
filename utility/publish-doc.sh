#!/bin/sh

#  publish-doc.sh
#  HHMACSwift
#
#  Created by Yannick Heinrich on 14.06.16.
#  Copyright © 2016 yageek. All rights reserved.


jazzy \
    --clean \
    --author Yannick Heinrich \
    --author_url https://blog.yageek.net \
    --github_url https://github.com/yageek/HHMACSwift \
    --module-version 0.96.2 \
    --xcodebuild-arguments -scheme,HHMacSwift \
    --module HHMacSwift \
    --output docs/swift_output