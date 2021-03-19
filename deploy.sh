#build images
docker build -t efuentesg/multi-client:latest -t efuentesg/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t efuentesg/multi-server:latest -t efuentesg/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t efuentesg/multi-worker:latest -t efuentesg/multi-worker:$SHA -f ./worker/Dockerfile ./worker
#push images to docker hub
docker push efuentesg/multi-client:$SHA
docker push efuentesg/multi-client:latest
docker push efuentesg/multi-server:$SHA
docker push efuentesg/multi-server:latest
docker push efuentesg/multi-worker:$SHA
docker push efuentesg/multi-worker:latest
#kubectl
kubectl apply -f k8s
# Set latest images on each deploment
kubectl set image deployments/server-deployment server=efuentesg/multi-server:$SHA
kubectl set image deployments/client-deployment client=efuentesg/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=efuentesg/multi-worker:$SHA