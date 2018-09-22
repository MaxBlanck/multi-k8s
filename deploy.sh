 docker build -t maxbl/multi-client:latest -t maxbl/multi-client:$SHA ./client/Dockerfile ./client
docker build -t maxbl/multi-server:latest -t maxbl/multi-server:$SHA ./server/Dockerfile ./server
docker build -t maxbl/multi-worker:latest -t maxbl/multi-worker:$SHA ./worker/Dockerfile ./worker

docker push maxbl/multi-client:latest
docker push maxbl/multi-server:latest
docker push maxbl/multi-worker:latest

docker push maxbl/multi-client:$SHA
docker push maxbl/multi-server:$SHA
docker push maxbl/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployment/client-deployment client=maxbl/multi-client:$SHA
kubectl set image deployment/server-deployment server=maxbl/multi-server:$SHA
kubectl set image deployment/worker-deployment worker=maxbl/multi-worker:$SHA