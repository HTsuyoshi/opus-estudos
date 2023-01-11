.PHONY: 'status'
status:
	@echo 'K8s resources status...'
	@watch "kubectl get all -A -o wide | grep -v '^kube-system\|^ingress-nginx'"

.PHONY: 'setup'
setup:
	@echo '--- Starting minikube ---'
	@echo '--- Start nodes ---'
	@minikube start --nodes='4' --network-plugin=cni --cni=calico  --profile=multinode --vm-driver=virtualbox --kubernetes-version=v1.24.3
	#@minikube start --nodes='4' --profile multinode --vm-driver=virtualbox
	@echo '--- Enabling minikube addons  ---'
	@kubectl taint nodes multinode type=b:NoSchedule
	@kubectl taint nodes multinode-m03 type=b:NoSchedule
	@kubectl taint nodes multinode-m04 type=b:NoSchedule
	@kubectl label nodes multinode-m02 minikube.k8s.io/primary=true
	@minikube -p multinode addons enable ingress
	@minikube -p multinode addons enable ingress-dns
	@minikube -p multinode addons enable metrics-server
	@kubectl label nodes multinode-m02 minikube.k8s.io/primary-
	@kubectl taint nodes multinode type=b:NoSchedule-
	@kubectl taint nodes multinode-m03 type=b:NoSchedule-
	@kubectl taint nodes multinode-m04 type=b:NoSchedule-
	@echo '--- Add taints ---'
	@kubectl taint nodes multinode-m02 type=db:NoSchedule
	@kubectl taint nodes multinode-m03 type=site:NoSchedule
	@kubectl taint nodes multinode-m04 type=challs:NoSchedule
	@echo '--- Changing /etc/NetworkManager/dnsmasq.d/minikube.conf ---'
	@sudo sed -i "s/\([0-9]\{1,3\}\.\)\{3\}[0-9]\{1,3\}\$$/$$(minikube --profile multinode ip --node multinode-m02)/" /etc/NetworkManager/dnsmasq.d/minikube.conf
	@cat /etc/NetworkManager/dnsmasq.d/minikube.conf
	@echo '--- Restarting NetworkManager.service ---'
	@systemctl restart NetworkManager.service

.PHONY: 'clean'
clean:
	@echo '--- Deleting minikube nodes ---'
	@minikube -p multinode delete

.PHONY: 'start'
start:
	@echo 'Applying k8s yaml files...'
	@echo 'Kube-system...'
	@kubectl apply -R -f ./kube-system
	@echo 'Namespaces...'
	@kubectl apply -f ./namespace.yaml
	@echo 'Main page...'
	@kubectl apply -R -f ./site
	@echo 'Database...'
	@kubectl apply -R -f ./database
	@echo 'Website...'
	@kubectl apply -R -f ./ctfd
	@echo 'Redis...'
	@kubectl apply -f ./redis/pv.yaml
	@helm install ctfd-redis -f ./redis/values.yaml -n redis bitnami/redis 2>&- \
		|| echo 'Error while installing redis'
	@echo 'Challenges...'
	@kubectl apply -R -f ./challenges
	@echo 'Open TCP ports...'
	@kubectl patch configmap tcp-services -n ingress-nginx \
		--patch '{"data":{"47400":"challs/ctfd-2021-chall-xor-otp-service:47400"}}'
	@kubectl patch deployment ingress-nginx-controller \
		--patch-file ./ingress-nginx/ingress-controller-patch.yaml -n ingress-nginx

.PHONY: 'stop'
stop:
	@echo 'Deleting k8s resources...'
	@echo 'Kube-system...'
	@kubectl delete -R -f ./kube-system 2>&- \
		|| echo 'Error while deleteting kube-system netpoly'
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
	@echo "nc $$(minikube -p multinode ip) 47400"
	# Test connection
	# kubectl run -it curl --image=curlimages/curl --namespace=ctfd --restart=Never -- sh
	# kubectl taint nodes multinode type=b:NoSchedule
