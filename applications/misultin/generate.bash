#!/bin/bash

set -e -E -u -o pipefail -o noclobber -o noglob -o braceexpand || exit 1
trap 'printf "[ee] failed: %s\n" "${BASH_COMMAND}" >&2' ERR || exit 1

test "${#}" -eq 0

cd -- "$( dirname -- "$( readlink -e -- "${0}" )" )"

rm -Rf ./.generated
mkdir ./.generated

cp -T ./repositories/misultin/src/misultin.app.src ./.generated/misultin.app

exit 0
