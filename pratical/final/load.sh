#!/bin/bash
for i in {1..10};
do
	dd if=/dev/urandom | base64 | nc -v $(minikube ip -p multinode -n multinode-m02) 47400 &
done
