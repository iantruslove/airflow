#!/usr/bin/env bash

#
#  Licensed to the Apache Software Foundation (ASF) under one
#  or more contributor license agreements.  See the NOTICE file
#  distributed with this work for additional information
#  regarding copyright ownership.  The ASF licenses this file
#  to you under the Apache License, Version 2.0 (the
#  "License"); you may not use this file except in compliance
#  with the License.  You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing,
#  software distributed under the License is distributed on an
#  "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
#  KIND, either express or implied.  See the License for the
#  specific language governing permissions and limitations
#  under the License.

set -xeuo pipefail
MY_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
# shellcheck source=./_check_not_in_container.sh
. "${MY_DIR}/_check_not_in_container.sh"

export PYTHON_VERSION=${PYTHON_VERSION:="3.6"}
export DOCKERHUB_USER=${DOCKERHUB_USER:="apache"}
export DOCKERHUB_REPO=${DOCKERHUB_REPO:="airflow"}
export WEBSERVER_HOST_PORT=${WEBSERVER_HOST_PORT:="8080"}

export BRANCH_NAME=${BRANCH_NAME:="master"}
export DOCKER_IMAGE=${DOCKERHUB_USER}/${DOCKERHUB_REPO}:${BRANCH_NAME}-python${PYTHON_VERSION}-ci

# Default branch name for triggered builds is master
export AIRFLOW_CONTAINER_BRANCH_NAME=${AIRFLOW_CONTAINER_BRANCH_NAME:="master"}

export AIRFLOW_CONTAINER_DOCKER_IMAGE=\
${DOCKERHUB_USER}/${DOCKERHUB_REPO}:${AIRFLOW_CONTAINER_BRANCH_NAME}-python${PYTHON_VERSION}-ci

docker-compose \
    -f "${MY_DIR}/docker-compose.yml" \
    -f "${MY_DIR}/docker-compose-kubernetes.yml" \
    -f "${MY_DIR}/docker-compose-local.yml" \
    -f "${MY_DIR}/docker-compose-mysql.yml" \
    -f "${MY_DIR}/docker-compose-postgres.yml" \
    -f "${MY_DIR}/docker-compose-sqlite.yml" down