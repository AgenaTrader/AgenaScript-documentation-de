#!/bin/bash
# This shell script will build and deploy everything from this repository.
# Simon Pucher 22.01.2017

if [ "$1" = "" ] ; then
   echo "No parameter was specified or parameter unknown, so I do not know what to do and I am going to exit now!"
   exit
fi

# echo "$1"
if [ "$1" = "-build" ] ;
then
  # echo "let's build"
  # build new static sites via mkdocs
  mkdocs build --clean

  exit
elif [ "$1" = "-books" ] ;
then
  # variables
  TODAY=$(date)

  # change the creation date of the ebook
  cd documents
  sed -e "s%.*date.*%date: $TODAY%g" epub_title.txt > epub_title.txt.bak && rm epub_title.txt && mv epub_title.txt.bak epub_title.txt
  cd ..

  ## build epub ebook with pandoc
  cd sources
  pandoc -S --epub-cover-image=../documents/epub_cover.png --epub-stylesheet=../documents/epub_styles.css -o ../documents/agenascript-documentation.epub ../documents/epub_title.txt index.md handling_bars_and_instruments.md events.md strategy_programming.md keywords.md drawing_objects.md hints_and_advice.md

  # build word file with pandoc
  pandoc -S -o ../documents/agenascript-documentation.docx ../documents/epub_title.txt index.md handling_bars_and_instruments.md events.md strategy_programming.md keywords.md drawing_objects.md hints_and_advice.md
  cd ..
  exit
elif [ "$1" = "-deploy" ] ;
then
  # echo "let's deploy"

  # if anything in the site/subdirectory changed in the prior commit,
  # push that directory to gh-pages for auto generation.
  git diff-tree -r --name-only --no-commit-id master | grep '^site/' &> /dev/null
  if [ $? == 0 ]; then
    git push origin `git subtree split --prefix site master 2> /dev/null`:gh-pages --force
    # merge master
    # git commit -a -m "Automatic deploy: $TODAY"
  else
    echo "No deploy was done and I am going to exit now!"
    exit
  fi

  exit
fi
