docker build -t gulmohar/k8s-multicontainer-client:latest -t gulmohar/8s-multicontainer-client:$SHA -f ./client/Dockerfile ./client
docker build -t gulmohar/k8s-multicontainer-server:latest -t gulmohar/8s-multicontainer-server:$SHA -f ./server/Dockerfile ./server
docker build -t gulmohar/k8s-multicontainer-worker:latest -t gulmohar/8s-multicontainer-worker:$SHA -f ./worker/Dockerfile ./worker

docker push gulmohar/k8s-multicontainer-client:latest
docker push gulmohar/k8s-multicontainer-server:latest
docker push gulmohar/k8s-multicontainer-worker:latest

docker push gulmohar/k8s-multicontainer-client:$SHA
docker push gulmohar/k8s-multicontainer-server:$SHA
docker push gulmohar/k8s-multicontainer-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=gulmohar/k8s-multicontainer-client:$SHA
kubectl set image deployments/server-deployment server=gulmohar/k8s-multicontainer-server:$SHA
kubectl set image deployments/worker-deployment worker=gulmohar/k8s-multicontainer-worker:$SHA
