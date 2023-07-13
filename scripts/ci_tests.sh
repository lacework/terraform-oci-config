#!/bin/bash
#
# Name::        ci_tests.sh
# Description:: Use this script to run ci tests of this repository
# Author::      Salim Afiune Maya (<afiune@lacework.net>)
#
set -eou pipefail

readonly project_name=terraform-oci-config
private_key_file_name=oci_private_key.pem

TEST_CASES=(
  examples/default-config
  examples/custom-config
  examples/skip-creation-config
)

log() {
  echo "--> ${project_name}: $1"
}

warn() {
  echo "xxx ${project_name}: $1" >&2
}

export_oci_credentials() {
  # This is necessary because environment variables with newlines in them are
  # hard to store in Codefresh.
  echo $OCI_PRIVATE_KEY | sed 's/%/\r\n/g' > $private_key_file_name
  export TF_VAR_private_key_path=$(pwd)/${private_key_file_name}
}

cleanup_oci_credentials() {
  rm ${private_key_file_name}
}

integration_tests() {
  for tcase in ${TEST_CASES[*]}; do
    log "Running tests at $tcase"
    ( cd $tcase || exit 1
      terraform init
      terraform validate
      terraform plan
    ) || exit 1
  done
}

lint_tests() {
  log "terraform fmt check"
  terraform fmt -check
}

main() {
  lint_tests
  export_oci_credentials
  integration_tests
  cleanup_oci_credentials
}

main || exit 99
