.PHONY: 'status'
status:
	@echo 'K8s resources status...'
	@watch "kubectl get all -A | grep -v '^kube-system\|^ingress-nginx'"

.PHONY: 'test'
test:
	@echo '--- Testing ctfd ---'
	@echo -n 'ctfssi 2021... '
	@curl ctfssi-2021.test &>/dev/null && \
		echo 'Passed' || echo 'Failed'
	@echo -n 'ctfssi 2022... '
	@curl ctfssi-2022.test &>/dev/null && \
		echo 'Passed' || echo 'Failed'
	@echo 'challenges...'
	@echo '--- Testing challs ---'
	@echo -n 'chall 2021... '
	@curl uccdi.challs.ctfssi-2022.test &>/dev/null \
		&& echo 'Passed' || echo 'Failed'
	@echo 'chall 2022... '
	@echo 'Run the following command to test:'
	@echo 'nc (minikube ip) 47400'

.PHONY: 'setup'
setup:
	@echo '--- Starting minikube ---'
	# TODO: start 2 nodes and configure taints
	@minikube start --vm-driver=virtualbox
	@echo '--- Enabling minikube addons  ---'
	@minikube addon enable metrics-server
	@minikube addon enable ingress
	@minikube addon enable ingress-dns
	@echo 'Minikube IP: $(minikube ip)'

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
	@kubectl apply -f ./challenges/chall-xor-otp.yaml
	@kubectl patch configmap tcp-services -n ingress-nginx \
		--patch '{"data":{"47400":"challs/ctfd-2021-chall-xor-otp-service:47400"}}'
	@kubectl patch deployment ingress-nginx-controller \
		--patch-file ./challenges/ingress-controller-patch.yaml -n ingress-nginx



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
	@kubectl apply -f ./challenges/chall-xor-otp.yaml 2>&- \
		|| echo 'Error while deleteting chall-xor-otp'
	@echo 'Namespaces...'
	@kubectl delete -f ./namespace.yaml 2>&- \
		|| echo 'Error while deleteting namespace'
	@echo 'Deleting nginx-ingress controller...'
