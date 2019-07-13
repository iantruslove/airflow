#!/usr/bin/env bash

#
# Licensed to the Apache Software Foundation (ASF) under one or more
# contributor license agreements.  See the NOTICE file distributed with
# this work for additional information regarding copyright ownership.
# The ASF licenses this file to You under the Apache License, Version 2.0
# (the "License"); you may not use this file except in compliance with
# the License.  You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Script to run Pylint on all code. Can be started from any working directory
# ./scripts/ci/run_pylint.sh

set -uo pipefail

MY_DIR=$(cd "$(dirname "$0")" || exit 1; pwd)

# shellcheck source=./_check_in_container.sh
. "${MY_DIR}/_check_in_container.sh"

pushd "${AIRFLOW_SOURCES}"  &>/dev/null || exit 1

echo
echo "Running in $(pwd)"
echo

echo
echo "Running mypy with parameters: $*"
echo

mypy "$@"

RES="$?"


popd &>/dev/null || exit 1

if [[ "${RES}" != 0 ]]; then
    echo >&2
    echo >&2 "There were some mypy errors. Exiting"
    echo >&2
    exit 1
else
    echo
    echo "Mypy check succeeded"
    echo
fi