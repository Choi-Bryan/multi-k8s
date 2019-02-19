docker build -t bryanchoi/multi-client:latest -t bryanchoi/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t bryanchoi/multi-server:latest -t bryanchoi/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t bryanchoi/multi-worker:latest -t bryanchoi/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push bryanchoi/multi-client:latest
docker push bryanchoi/multi-server:latest
docker push bryanchoi/multi-worker:latest
docker push bryanchoi/multi-client:$SHA
docker push bryanchoi/multi-server:$SHA
docker push bryanchoi/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=bryanchoi/multi-server:$SHA
kubectl set image deployments/client-deployment client=bryanchoi/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=bryanchoi/multi-worker:$SHA
