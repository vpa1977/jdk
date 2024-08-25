#
# Copyright (c) 2015, 2024, Oracle and/or its affiliates. All rights reserved.
# DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
#
# This code is free software; you can redistribute it and/or modify it
# under the terms of the GNU General Public License version 2 only, as
# published by the Free Software Foundation.
#
# This code is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
# FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
# version 2 for more details (a copy is included in the LICENSE file that
# accompanied this code).
#
# You should have received a copy of the GNU General Public License version
# 2 along with this work; if not, write to the Free Software Foundation,
# Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA.
#
# Please contact Oracle, 500 Oracle Parkway, Redwood Shores, CA 94065 USA
# or visit www.oracle.com if you need additional information or have any
# questions.
#
# @test
# @key headful
# @summary Unit test for javax.accessibility classpath property
#
# @build Load FooProvider
# @run shell basic.sh

# Command-line usage: sh basic.sh /path/to/build
set -ex

if [ -z "$TESTJAVA" ]; then
  if [ $# -lt 1 ]; then exit 1; fi
  TESTJAVA="$1"
  TESTSRC=`pwd`
  TESTCLASSES="`pwd`"
fi

JAVA="$TESTJAVA/bin/java"

TESTD=x.test
rm -rf $TESTD
mkdir -p $TESTD

mv $TESTCLASSES/Load.class $TESTD
mkdir -p $TESTD/META-INF/services
echo FooProvider >$TESTD/META-INF/services/javax.accessibility.AccessibilityProvider

$JAVA -Djavax.accessibility.assistive_technologies.classpath=$TESTCLASSES \
 -Djavax.accessibility.assistive_technologies=FooProvider -cp $TESTD \
 Load pass FooProvider 2>&1
