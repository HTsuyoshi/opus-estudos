.PHONY: 'status'
status:
	@echo 'K8s resources status...'
	@watch "kubectl get all -A -o wide | grep -v '^kube-system\|^ingress-nginx'"

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
	@echo '--- Start nodes ---'
	@minikube start --nodes 5 -p multinode --vm-driver=virtualbox
	echo '--- Add taints ---'
	@kubectl taint nodes multinode-m02 type=site:NoSchedule
	@kubectl taint nodes multinode-m03 type=ctfd:NoSchedule
	@kubectl taint nodes multinode-m04 type=challs:NoSchedule
	@kubectl taint nodes multinode-m05 type=database:NoSchedule
	@echo '--- Enabling minikube addons  ---'
	@minikube -p multinode addons enable metrics-server
	@minikube -p multinode addons enable ingress
	@minikube -p multinode addons enable ingress-dns

.PHONY: 'clean'
clean:
	@echo '--- Deleting minikube nodes ---'
	@minikube -p multinode delete

.PHONY: 'start'
start:
	@echo 'Applying k8s yaml files...'
	@echo 'Namespaces...'
	@kubectl apply -f ./namespace.yaml
	@echo 'Main page...'
	@kubectl apply -R -f ./site
	@echo 'Database...'
	@kubectl apply -R -f ./database
	@echo 'Website...'
	@kubectl apply -R -f ./ctfd
	@echo 'Redis...'
	@helm install ctfd-redis -f ./redis/values.yaml -n redis bitnami/redis
	@echo 'Challenges...'
	@kubectl apply -R -f ./challenges
	@echo 'Open TCP ports...'
	@kubectl patch configmap tcp-services -n ingress-nginx \
		--patch '{"data":{"47400":"challs/ctfd-2021-chall-xor-otp-service:47400"}}'
	@kubectl patch deployment ingress-nginx-controller \
		--patch-file ./ingress-controller-patch.yaml -n ingress-nginx

.PHONY: 'stop'
stop:
	@echo 'Deleting k8s resources...'
	@echo 'Main page...'
	@kubectl delete -R -f ./site 2>&- \
		|| echo 'Error while deleteting site'
	@echo 'Database...'
	@kubectl delete -R -f ./database 2>&- \
		|| echo 'Error while deleteting database'
	@echo 'Website...'
	@kubectl delete -R -f ./ctfd 2>&- \
		|| echo 'Error while deleteting ctfd'
	@echo 'Redis...'
	@helm uninstall -n redis ctfd-redis 2>&- \
		|| echo 'Error while deleteting helm redis'
	@echo 'Challenges...'
	@kubectl delete -R -f ./challenges/ingress.yaml 2>&- \
		|| echo 'Error while deleteting challs'
	@echo 'Namespaces...'
	@kubectl delete -f ./namespace.yaml 2>&- \
		|| echo 'Error while deleteting namespace'

.PHONY: 'reset'
restart: stop start
