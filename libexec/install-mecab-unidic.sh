#!/usr/bin/env bash

# Copyright (C) 2015-2016 Toshinori Sato (@overlast)
#
#       https://github.com/neologd/mecab-unidic-neologd
#
# Licensed under the Apache License, Version 2.0 (the &quot;License&quot;);
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an &quot;AS IS&quot; BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

set -e

TMP_DIR_PATH=/var/tmp/build-unidic-mecab
MECAB_UNIDIC_VERSION=2.1.2
MECAB_UNIDIC_DIR_NAME=unidic-mecab-${MECAB_UNIDIC_VERSION}_src
MECAB_UNIDIC_FILE_NAME=${MECAB_UNIDIC_DIR_NAME}.zip
MECAB_UNIDIC_URL="http://osdn.jp/frs/redir.php?m=iij&f=%2Funidic%2F58338%2F${MECAB_UNIDIC_FILE_NAME}"

ECHO_PREFIX='[install-mecab-unidic] :'

echo "${ECHO_PREFIX} Start.."

echo "${ECHO_PREFIX} Get sudo password"
sudo ls -al

if [ ! -d ${TMP_DIR_PATH} ]; then
    echo "${ECHO_PREFIX} mkdir -p ${TMP_DIR_PATH} to use as a temporary directory"
    mkdir -p ${TMP_DIR_PATH}
fi

echo "${ECHO_PREFIX} Go to ${ECHO_PREFIX}"
cd ${TMP_DIR_PATH}
pwd

echo "${ECHO_PREFIX} Get ${MECAB_UNIDIC_FILE_NAME}"
curl --insecure -L "${MECAB_UNIDIC_URL}" -o ${MECAB_UNIDIC_FILE_NAME}

echo "${ECHO_PREFIX} Extract ${MECAB_UNIDIC_FILE_NAME}"
unzip ${MECAB_UNIDIC_FILE_NAME}


echo "${ECHO_PREFIX} Execute configure and make"
cd ${MECAB_UNIDIC_DIR_NAME}
./configure
make

echo "${ECHO_PREFIX} Install unidic-mecab-${MECAB_UNIDIC_VERSION}"
sudo make install


echo "${ECHO_PREFIX} Delete ${TMP_DIR_PATH}"
cd
rm -rf ${TMP_DIR_PATH}

echo "${ECHO_PREFIX} Finish !!"
