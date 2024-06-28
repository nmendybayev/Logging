
# deployment of EFK-stack
deploy:
	kubectl apply -f efk-namespace.yaml
	kubectl apply -f fluentd.yaml
	kubectl apply -f es-sts.yaml 
	kubectl apply -f es-svc.yaml
	kubectl apply -f kibana.yaml

 #deletion of EFK-stack 
clean:
	kubectl delete all --all -n efk-logging

redeploy: clean deploy

#to connect to kibana:
kubectl port-forward kibana-568c5d8dcd-qnjgq 5601:5601 -n efk-logging
http://localhost:5601
