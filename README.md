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
  - [ ] Daemonsets - conceito
  - [x] Configmaps
  - [x] Secrets
  - [x] Services
  - [x] Ingress
  - [x] Persistência de dados (Storageclass - SC, Persistent Volume Claim - PVC, Persistent Volume - PV)
  - [ ] Job e Cronjobs - conceito
  - [ ] Statefulsets - conceito
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

O computador utilizado para testar a aplicação tem o EndeavourOS instalado:

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

Foi usado o `minikube` e o `virtualbox` para testar a aplicação localmente.

Lembrar de arrumar o servidor DNS ([link](https://minikube.sigs.k8s.io/docs/handbook/addons/ingress-dns/))
