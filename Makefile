.PHONY: 'start'
start: build
	@kubectl apply -R -f .

.PHONY: 'clean'
clean:
	@kubectl delete all --all
	@kubectl delete pvc --all
	@kubectl delete pv --all
	@kubectl delete secrets --all
