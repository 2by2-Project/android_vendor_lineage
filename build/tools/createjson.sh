#!/bin/bash
#
# Copyright (C) 2019-2025 crDroid Android Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# You may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

#$1=TARGET_DEVICE, $2=PRODUCT_OUT, $3=FILE_NAME
existingOTAjson=./vendor/2by2-ota/$1.json
output=$2/$1.json

# Cleanup old file
if [ -f $output ]; then
    rm $output
fi

echo "Generating JSON file data for OTA support..."

# Generate JSON fields
FILENAME=$3
VERSION=$(echo "$3" | cut -d'-' -f3 | sed 's/v//')

BUILDPROP="$2/system/build.prop"
TIMESTAMP=$(grep "ro.system.build.date.utc" "$BUILDPROP" | cut -d'=' -f2)
SHA256=$(sha256sum "$2/$3" | cut -d' ' -f1)
SIZE=$(stat -c "%s" "$2/$3")

# Generate JSON output
cat <<EOF >$output
{
    "response": [
        {
            "datetime": $TIMESTAMP,
            "filename": "$FILENAME",
            "id": "$SHA256",
            "romtype": "",
            "size": $SIZE,
            "url": "https://files.project2by2.jp/builds/$1/$VERSION/$FILENAME",
            "version": "$VERSION"
        }
    ]
}
EOF

echo "JSON file generation completed"
