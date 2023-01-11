# Opus kubernetes

Projeto da Opus Software para aprender um pouco mais sobre kubernetes

<!-- As imagens utilizadas podem ser encontradas na pasta `./dockerfiles` -->

Tópicos de Estudo:

- [x] Kubernetes (conceito, pré-requisitos, componentes)
- [x] Kubernetes vs Docker (diferenças, em que casos é melhor utilizá-los)
- [x] Pods vs Container
- [x] Criação local do cluster kubernetes (exemplo: kind, minikube, etc) e uso do kubectl
- [x] Recursos (conceito e prática: comandos e aplicação de yaml)
  - [x] Namespaces
  - [x] Deployments
  - [x] Daemonsets - conceito
  - [x] Configmaps
  - [x] Secrets
  - [x] Services
  - [x] Ingress
  - [x] Persistência de dados (Storageclass - SC, Persistent Volume Claim - PVC, Persistent Volume - PV)
  - [x] Job e Cronjobs - conceito
  - [x] Statefulsets - conceito
  - [x] HPA - conceito
  - [ ] RBAC (roles, service accounts, users) - conceito
  - [ ] CRD - conceito
- [x] Troubleshooting (describe, logs, events e exec)
- [x] Ambientes produtivos: setup de alta disponibilidade, scaling, quais cuidados tomar, etc
- [x] Uso do Helm para a instalação de pacotes

## Pastas

A pasta `./tests` são apenas alguns testes para aprender um pouco mais sobre o kubernetes.

A pasta `./final` contém o projeto final desenvolvido.

## Setup

O sistema operacional utilizado é o `EndeavourOS`:

```
NAME=EndeavourOS
PRETTY_NAME=EndeavourOS
ID=endeavouros
ID_LIKE=arch
BUILD_ID=2022.08.28
ANSI_COLOR="38;2;23;147;209"
HOME_URL='https://endeavouros.com'
DOCUMENTATION_URL='https://discovery.endeavouros.com'
SUPPORT_URL='https://forum.endeavouros.com'
BUG_REPORT_URL='https://forum.endeavouros.com/c/arch-based-related-questions/bug-reports'
PRIVACY_POLICY_URL="https://terms.archlinux.org/docs/privacy-policy/"
LOGO=endeavouros
```

Foi usado o `minikube` em conjunto com o `virtualbox` para testar a aplicação localmente.

A versão do `minikube`:

```yaml
minikube version: v1.28.0
commit: 986b1ebd987211ed16f8cc10aed7d2c42fc8392f-dirty
```

Versão do `kubectl`:

```yaml
WARNING: This version information is deprecated and will be replaced with the output from kubectl version --short.  Use --output=yaml|json to get the full version.
Client Version: version.Info{Major:"1", Minor:"25", GitVersion:"v1.25.5", GitCommit:"804d6167111f6858541cef440ccc53887fbbc96a", GitTreeState:"archive", BuildDate:"2022-12-08T19:51:18Z", GoVersion:"go1.19.4", Compiler:"gc", Platform:"linux/amd64"}
Kustomize Version: v4.5.7
Server Version: version.Info{Major:"1", Minor:"25", GitVersion:"v1.25.3", GitCommit:"434bfd82814af038ad94d62ebe59b133fcb50506", GitTreeState:"clean", BuildDate:"2022-10-12T10:49:09Z", GoVersion:"go1.19.2", Compiler:"gc", Platform:"linux/amd64"}
```

Sempre que inicializar os pods é preciso fazer o setup do servidor _DNS_ ([link](https://minikube.sigs.k8s.io/docs/handbook/addons/ingress-dns/)

Já que o _MariaDB_ não se da muito bem com o _NFS_, foi criado dois diretórios dentro do nó `multinode-m05` /data/db-202{1,2}. (É preciso adicionar essas pastas sempre que o cluster for inicializado)

Foi criado um servidor _NFS_ no endereço `192.168.0.20` na rede LAN

Reiniciar o cluster:

```
make clean && make setup && make start
```
