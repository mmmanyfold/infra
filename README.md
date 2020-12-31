# `mmmanyfold/infra`

Declarative infrastructure project for mmmanyfold

### DEPENDENCIES

- [kubernetes](https://kubernetes.io/docs/tasks/tools/install-kubectl/)
- [kubectx + kubens](https://github.com/ahmetb/kubectx)
- [tanka & jsonnet-bundler](https://tanka.dev/install)
- [sops](https://github.com/mozilla/sops)
- [minikube](https://kubernetes.io/docs/tasks/tools/install-minikube/)
- jb `go get -u github.com/jsonnet-bundler/jsonnet-bundler/cmd/jb`

### SETUP

- `jb install`
- helpful kubernetes aliases and env vars

```bash
export KUBE_EDITOR="emacs" # vim, vscode, etc..
alias gc="gcloud"
alias kk="kubectl"
alias mk="minikube"
alias kcd="kubectx"
alias kns="kubens"
```

### TANKA

#### CMDs

creating a new managed environment
`tk env add environments/<project>/<env> --namespace=<project>-<environment>`

examples:

- `tk env add environments/prom-grafana/dev --namespace=prom-grafana-dev`
- `tk env add environments/prom-grafana/stage --namespace=prom-grafana-stage`
- `tk env add environments/prom-grafana/prod --namespace=prom-grafana-prod`

**Note**: create namespace manually after adding a new environment

`kk create ns <project-environment>`

Applying configuration environment

`tk apply environments/<project>/<environment>`

### KUBERNETES

#### CMDs

Port Forwarding

`kk port-forward --namespace=<ns> deployments/<deploy> <local-port>:<pod-port>`

deleting a group of pods by deleting a namespace

`kk delete ns custom-namespace`

deleting all the pods in a namespace without removing the namespace

`kk delete po --all`

delete every resource in a context (except secrets)

`kk delete all --all`
