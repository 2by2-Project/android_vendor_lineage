#!/bin/bash
#
#  Copyright (C) 2024 The 2by2 Project
#  SPDX-License-Identifier: Apache-2.0
#

# Available variables:
#   ${1} = LINEAGE_BUILD
#   ${2} = PRODUCT_OUT
#   ${3} = LINEAGE_VERSION
#   ${4} = PRODUCT_VERSION_MAJOR and PRODUCT_VERSION_MINOR
#   ${5} = PLATFORM_VERSION

DOWNLOAD_URL_ROOT="https://master.dl.sourceforge.net/project/project2by2-test"
TIMESTAMP=$(unzip -p ${2}/${3}.zip META-INF/com/android/metadata | grep 'post-timestamp=' | cut -d '=' -f 2)
MD5_HASH=$(md5sum ${2}/${3}.zip | awk '{print $1}')

cat <<EOF > ${2}/${1}.json
{
  "response": [
    {
      "datetime": "${TIMESTAMP}",
      "filename": "${3}.zip",
      "id": "${MD5_HASH}",
      "romtype": "UNOFFICIAL",
      "size": "$(stat -c%s ${2}/${3}.zip)",
      "url": "${DOWNLOAD_URL_ROOT}/${1}/${5}/${3}.zip?viasf=1",
      "version": "${4}",
      "platform_version": "${5}"
    }
  ]
}
EOF
