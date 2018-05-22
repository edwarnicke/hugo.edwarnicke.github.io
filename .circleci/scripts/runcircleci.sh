#!/usr/bin/env bash

SCRIPT_DIR=$(dirname "${BASH_SOURCE[0]}")
REPO_ROOT_DIR=$(cd "${SCRIPT_DIR}";git rev-parse --show-toplevel)
CIRCLECI_CONFIG_FILE="${REPO_ROOT_DIR}/.circleci/config.yml"
GITHASH=$(cd "${REPO_ROOT_DIR}";git rev-parse HEAD)
GITBRANCH=$(cd "${REPO_ROOT_DIR}";git rev-parse --abbrev-ref HEAD)
REMOTE_URL=$(cd "${REPO_ROOT_DIR}";git remote get-url origin)
REMOTE_PATH=$(echo ${REMOTE_URL}| awk -F: '{print $2}'| sed 's/.git$//')
CIRCLECI_URL="https://circleci.com/api/v1.1/project/github/${REMOTE_PATH}/tree/${GITBRANCH}"
curl --user ${CIRCLE_TOKEN}: \
    --request POST \
    --form revision=${GITHASH}\
    --form config=@${CIRCLECI_CONFIG_FILE} \
    --form notify=false \
        ${CIRCLECI_URL}