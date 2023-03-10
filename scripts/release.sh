#!/bin/bash

export AWS_DEFAULT_REGION="us-east-1"

function_loading () {
  source "${GIT_HOME}"/scripts/build.sh
  source "${GIT_HOME}"/scripts/env.sh
  source "${GIT_HOME}"/scripts/release.sh
}

function_release_image () {
  # cargando scripts
  function_loading
  function_env_global

  echo "DOCKERHUB_USER: ${DOCKERHUB_USER}"

  if [ -z "${DOCKERHUB_USER}" ]
  then
    echo "variable DOCKERHUB_USER no detectada"
    exit 1
  fi

  if [ -z "${DOCKERHUB_PASS}" ]
  then
    echo "variable DOCKERHUB_PASS no detectada"
    exit 1
  fi

  # ejecutando proceso
  docker tag "${PROJECT}-${SERVICE}":release ${DOCKERHUB_USER}/"${PROJECT}-${SERVICE}":latest
  docker tag "${PROJECT}-${SERVICE}":release ${DOCKERHUB_USER}/"${PROJECT}-${SERVICE}":${GITHUB_RUN_ID}

  # login
  echo ${DOCKERHUB_PASS} | docker login --username ${DOCKERHUB_USER} --password-stdin

  # publicando imagen
  docker push ${DOCKERHUB_USER}/"${PROJECT}-${SERVICE}":latest
  docker push ${DOCKERHUB_USER}/"${PROJECT}-${SERVICE}":${GITHUB_RUN_ID}
}

"$@"