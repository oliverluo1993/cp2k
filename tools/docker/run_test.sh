#!/bin/bash

# author: Ole Schuett

if (( $# < 1 )); then
    echo "usage: run_test.sh <test_name> [additional-args]"
    echo "example: run_test.sh python"
    exit 1
fi

set -e
TESTNAME=$1
shift
echo "Running ${TESTNAME} ..."

echo -n "Date: "
date --utc --rfc-3339=seconds
if git rev-parse; then
  git --no-pager log -1 --pretty="%nCommitSHA: %H%nCommitTime: %ci%nCommitAuthor: %an%nCommitSubject: %s%n"
fi

CP2K_LOCAL=`realpath ../../../`
set -x
docker run -i --init --rm --volume ${CP2K_LOCAL}:/opt/cp2k-local/:ro $@ img_cp2k_test_${TESTNAME}

#EOF