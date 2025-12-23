# Rebase of che-code to enable GitHub Copilot in OpenShift Dev Spaces

## Install the custom editor -

1. Download the editor YAML -

   ```bash
   wget https://raw.githubusercontent.com/cgruver/code-oss-workspace/refs/heads/main/che-code-editor-quay.yaml
   ```

1. Create a configmap for the editor in the namespace where you installed the CheCluster CR -

   __Note:__ Replace `devspaces` with the namespace where the CheCluster is installed

   ```bash
   oc create configmap che-code-copilot --from-file=che-code-editor-quay.yaml -n devspaces
   ```

1. Label the ConfigMap so that Dev Spaces is aware of it as an editor -

   __Note:__ Replace `devspaces` with the namespace where the CheCluster is installed

   ```bash
   oc label configmap che-code-copilot app.kubernetes.io/part-of=che.eclipse.org app.kubernetes.io/component=editor-definition -n devspaces
   ```


## Build the GitHub.copilot-chat extension -

```bash
git clone https://github.com/cgruver/vscode-copilot-chat.git

npm install

npx @vscode/dts dev && mv vscode.proposed.*.ts src/extension

npx tsx .esbuild.ts

vsce package

```

## Create PAT
```
git clone https://github.com/cgruver/vscode-copilot-chat.git

cd vscode-copilot-chat
 
npm install

npm run get_token
```
