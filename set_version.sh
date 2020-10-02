#!/bin/bash

CURRENT_VERSION=`cat version.txt`

echo "CURRENT_VERSION:$CURRENT_VERSION"

MAJOR=`echo $CURRENT_VERSION | awk -F "." '{ print $1 }'`
MINOR=`echo $CURRENT_VERSION | awk -F "." '{ print $2 }'`
PATCH=`echo $CURRENT_VERSION | awk -F "." '{ print $3 }'`

echo "MAJOR:$MAJOR"
echo "MINOR:$MINOR"
echo "PATCH:$PATCH"

COMMIT_MESSAGE=`git log | head -1 | awk -F " " '{ print $2 }' | git log --format=%B -n 1 | grep -e {{MAJOR}} -e {{MINOR}} -e {{PATCH}}`

echo $COMMIT_MESSAGE

if [ $? -eq 0 ];
 then

  echo $COMMIT_MESSAGE | grep {{MAJOR}}
     if [ $? -eq 0 ];
      then
        VER=MAJOR
     fi

  echo $COMMIT_MESSAGE | grep {{MINOR}}
     if [ $? -eq 0 ];
      then
        VER=MINOR
     fi

  echo $COMMIT_MESSAGE | grep {{PATCH}}
     if [ $? -eq 0 ];
      then
        VER=PATCH
     fi
echo VER: $VER

if [ `echo $VER | grep "MAJOR"` ];
    then
      MAJOR=`expr $MAJOR + 1`
      MINOR=0
      PATCH=0

      NEXTVERSION=$MAJOR.$MINOR.$PATCH
      echo "NEXTVERSION:$NEXTVERSION"
       > version.txt
      echo "$NEXTVERSION" > version.txt
      export IMAGE_TAG=$NEXTVERSION
      
  elif [ `echo $VER | grep "MINOR"` ];
    then
      MINOR=`expr $MINOR + 1`
      PATCH=0
      NEXTVERSION=$MAJOR.$MINOR.$PATCH
      echo "NEXTVERSION:$NEXTVERSION"
       > version.txt
      echo "$NEXTVERSION" > version.txt
      export IMAGE_TAG=$NEXTVERSION

  elif [ `echo $VER | grep "PATCH"` ];
    then
      PATCH=`expr $PATCH + 1`
      NEXTVERSION=$MAJOR.$MINOR.$PATCH
      echo "NEXTVERSION:$NEXTVERSION"
       > version.txt
      echo "$NEXTVERSION" > version.txt
      export IMAGE_TAG=$NEXTVERSION
  fi  
  
  git add .
  git commit -m "Latest version pushed into the file version.txt"
  git pull
  git push

else
    echo "The commit message does not contain the keywords MAJOR, MINOR or PATCH to determine the next version of the build. Please retry"
fi
