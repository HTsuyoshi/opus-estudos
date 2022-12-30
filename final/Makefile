.PHONY: 'status'
status:
	@echo 'K8s resources status...'
	@watch "kubectl get all -A | grep -v '^kube-system\|^ingress-nginx'"

.PHONY: 'setup'
setup:
	@minikube start --vm-driver=virtualbox
	@minikube addon enable metrics-server
	@minikube addon enable ingress
	@minikube addon enable ingress-dns

.PHONY: 'start'
start:
	@echo 'Applying k8s yaml files...'
	@echo 'Namespaces...'
	@kubectl apply -f ./namespace.yaml
	@echo 'Database...'
	@kubectl apply -f ./database/convert-internal-networkpolicy.yaml
	@kubectl apply -f ./database/db-2021.yaml
	@kubectl apply -f ./database/db-2022.yaml
	@echo 'Website...'
	@kubectl apply -f ./ctfd/env-configmap.yaml
	@kubectl apply -f ./ctfd/ctfd-2021.yaml
	@kubectl apply -f ./ctfd/ctfd-2022.yaml
	@kubectl apply -f ./ctfd/ingress.yaml
	@echo 'Redis...'
	@kubectl apply -f ./redis/redis.yaml
	@echo 'Challenges...'
	@kubectl apply -f ./challenges/ingress.yaml
	@kubectl apply -f ./challenges/chall-uccdi.yaml
	#@echo 'Starting nginx-ingress controller...'
	#@helm install ingress-nginx --namespace=website nginx-stable/nginx-ingress -f ./nginx/values.yaml
	#@helm install ingress-nginx --namespace=website nginx-stable/nginx-ingress

.PHONY: 'clean'
clean:
	@echo 'Deleting k8s resources...'
	@echo 'Database...'
	@kubectl delete -f ./database/convert-internal-networkpolicy.yaml 2>&- \
		|| echo 'Error while deleteting database'
	@kubectl delete -f ./database/db-2021.yaml 2>&- \
		|| echo 'Error while deleteting db-2021'
	@kubectl delete -f ./database/db-2022.yaml 2>&- \
		|| echo 'Error while deleteting db-2022'
	@echo 'Website...'
	@kubectl delete -f ./ctfd/env-configmap.yaml 2>&- \
		|| echo 'Error while deleteting env-configmap'
	@kubectl delete -f ./ctfd/ctfd-2021.yaml 2>&- \
		|| echo 'Error while deleteting ctfd-2021'
	@kubectl delete -f ./ctfd/ctfd-2022.yaml 2>&- \
		|| echo 'Error while deleteting ctfd-2022'
	@kubectl delete -f ./ctfd/ingress.yaml 2>&- \
		|| echo 'Error while deleteting ctfd-ingress'
	@echo 'Redis...'
	@kubectl delete -f ./redis/redis.yaml 2>&- \
		|| echo 'Error while deleteting redis'
	@echo 'Challenges...'
	@kubectl apply -f ./challenges/ingress.yaml 2>&- \
		|| echo 'Error while deleteting challs-ingress'
	@kubectl delete -f ./challenges/chall-uccdi.yaml 2>&- \
		|| echo 'Error while deleteting chall-uccdi'
	@echo 'Namespaces...'
	@kubectl delete -f ./namespace.yaml 2>&- \
		|| echo 'Error while deleteting namespace'
	@echo 'Deleting nginx-ingress controller...'
	#@helm uninstall ingress-nginx --namespace=website
