#!/bin/sh

#  publish-doc.sh
#  HHMACSwift
#
#  Created by Yannick Heinrich on 14.06.16.
#  Copyright © 2016 yageek. All rights reserved.


if [ "$TRAVIS_REPO_SLUG" == "yageek/HHMACSwift" ]; then

    echo "Generating docs..."

    jazzy --clean --author "Yannick Heinrich" --author_url "https://blog.yageek.net" --github_url "https://github.com/yageek/HHMACSwift" --module "HHMACSwift" --xcodebuild-arguments "-scheme,HHMACSwift" --output "$HOME/docs/swift_output"

    if [ $? -ne 0 ]

        then
        echo "Failed to generate documentation";
        exit 1;

    fi

    echo "Publishing to Github..."

    cd $HOME
    git config --global user.email "travis@travis-ci.org"
    git config --global user.name "travis-ci"
    git clone --quiet --branch=gh-pages https://${GH_TOKEN}@github.com/yageek/HHMACSwift gh-pages > /dev/null

    cd gh-pages
    git rm -rf .
    cp -Rf $HOME/docs/swift_output/* .
    git add -f .
    git commit -m "Latest HHMAC doc on successful travis build $TRAVIS_BUILD_NUMBER auto-pushed to gh-pages"
    git push -fq origin gh-pages > /dev/null

    if [ $? -ne 0 ]
        then
        echo "Failed to push documentation. Aborting..."
        exit 1
    fi

    echo "Published HHMACSwift to gh-pages.\n"
fi


