#!/bin/bash

# Set the stable and next versions of MonetDBLite-Java
NEW_JDBC_STABLE_MAJOR_VERSION=2
NEW_JDBC_STABLE_MINOR_VERSION=36

NEW_JDBC_NEXT_MAJOR_VERSION=2
NEW_JDBC_NEXT_MINOR_VERSION=37

MONETDBLITEJAVA_STABLE_MAJOR_VERSION=2
MONETDBLITEJAVA_STABLE_MINOR_VERSION=37

MONETDBLITEJAVA_NEXT_MAJOR_VERSION=2
MONETDBLITEJAVA_NEXT_MINOR_VERSION=38

REPLACES_STR=( "NEW_JDBC_STABLE_MAJOR_VERSION" "NEW_JDBC_STABLE_MINOR_VERSION" "NEW_JDBC_NEXT_MAJOR_VERSION" "NEW_JDBC_NEXT_MINOR_VERSION"
"MONETDBLITEJAVA_STABLE_MAJOR_VERSION" "MONETDBLITEJAVA_STABLE_MINOR_VERSION" "MONETDBLITEJAVA_NEXT_MAJOR_VERSION" "MONETDBLITEJAVA_NEXT_MINOR_VERSION" )

REPLACES_VAL=( $NEW_JDBC_STABLE_MAJOR_VERSION $NEW_JDBC_STABLE_MINOR_VERSION $NEW_JDBC_NEXT_MAJOR_VERSION $NEW_JDBC_NEXT_MINOR_VERSION
$MONETDBLITEJAVA_STABLE_MAJOR_VERSION $MONETDBLITEJAVA_STABLE_MINOR_VERSION $MONETDBLITEJAVA_NEXT_MAJOR_VERSION $MONETDBLITEJAVA_NEXT_MINOR_VERSION )

SED_REGEX=""

for ((i=0; i < ${#REPLACES_VAL[@]} ; i+=1))
do
    SED_REGEX="${SED_REGEX} s/@${REPLACES_STR[i]}@/${REPLACES_VAL[i]}/g;"
done

SED_REGEX="${SED_REGEX%?}" # Bash way of remove last char

# This way is more secure
TO_UPDATE=( "build_and_upload.sh.in" "HEADER.html.in" "README.md.in" "monetdb-java-lite/pom.xml.in" "monetdb-java-lite/build.gradle.in"
"monetdb-java-lite/src/main/java/nl/cwi/monetdb/embedded/env/MonetDBJavaLiteLoader.java.in")

for entry in "${TO_UPDATE[@]}"
do
    sed "${SED_REGEX}" "${entry}" > "${entry::-3}" # Remove .in
done