#!/usr/bin/env bash
set -e 

export OVSX_REGISTRY_URL=https://$(oc get route open-vsx-server -n che-openvsx -o jsonpath={.spec.host})
export OVSX_PAT=eclipse_che_token
export NODE_TLS_REJECT_UNAUTHORIZED='0'

TEMP_DIR="$(mktemp -d)"
git clone -b ${CHAT_REVISION} --single-branch https://github.com/microsoft/vscode-copilot-chat ${TEMP_DIR}
pushd ${TEMP_DIR}
mv package.json tmpfile.json
jq 'del(.extensionPack)' tmpfile.json > package.json
rm tmpfile.json
npm install
npm run build
vsce package
ovsx create-namespace GitHub
ovsx publish --skip-duplicate copilot-chat-*.vsix
popd
rm -rf ${TEMP_DIR}
