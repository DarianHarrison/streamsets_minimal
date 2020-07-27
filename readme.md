(on machien with higher docker version) clone project 
```
git clone https://github.com/DarianHarrison/streamsets_minimal
cd streamsets_minimal
```

build image 
```
docker build \
-t darianharrison89/ss:0.0.1 \
--build-arg SDC_LIBS=\
streamsets-datacollector-jdbc-lib,\
streamsets-datacollector-apache-kafka_1_0-lib,\
streamsets-datacollector-elasticsearch_5-lib,\
streamsets-datacollector-mapr_6_1-lib,\
streamsets-datacollector-mapr_6_1-mep6-lib \
--build-arg http_proxy=http://web-proxy.corp.hpecorp.net:8080 \
--build-arg HTTPS_PROXY=http://web-proxy.corp.hpecorp.net:8080 \
.
```
push to image repo hub
```
docker push darianharrison89/ss:0.0.1
```

make sure to add your own "image: darianharrison89/ss:0.0.1" on the following files
```
design-sdc/design-sdc.yaml
exec-sdc/exec-sdc.yaml
```

on k8's cluster first create ns, switch context:
```
https://github.com/DarianHarrison/streamsets_minimal
cd streamsets_minimal
kubectl apply -f design-sdc/namespace.yaml
kubectl config set-context --current --namespace=streamsets
```

create secrets:
```
kubectl create secret generic mysecrets --from-literal=dpmuser=user@org --from-literal=dpmpassword=password
```

deploy 2 types deployments: "Design" deployment with one SDC and "Execution" deployment with many. (note: Wait few minutes for containers to create)

```
kubectl apply -f design-sdc/
kubectl apply -f exec-sdc/
kubectl scale deployment exec-sdc --replicas=3
watch kubectl get all
```

view on browser
```
kubectl get svc
(go to browser) http://<master-ip>:<port>/
```
user:admin
pass:admin


note: 3 option "statefulset" is not recommended by authors

setup and general references:
```
https://streamsets.com/blog/scaling-out-streamsets-with-kubernetes/
https://streamsets.com/documentation/datacollector/latest/help//datacollector/UserGuide/Installation/MapR-Prerequisites.html#concept_rt3_p5p_qcb
https://archives.streamsets.com/datacollector
https://github.com/onefoursix/sdc-k8s-deployment-with-custom-config
```

////////////////////////// TODOS //////////////////////////////////////////

tasks:

*   need to read/write to/from local/external kdf
*   Finish setup of Streamsets on HPE-CP
*   Run the test framework

Test:
Regarding test plans, we use StreamSets Test Framework that creates environments via docker, automates creation of pipelines and manages configurations and then runs pipelines in an automated way in the environments it creates.
https://streamsets.com/blog/introducing-the-streamsets-test-framework/
https://streamsets.com/documentation/stf/latest/

//personla notes

to create dynamic pv,pvc you can do sepparately with cspaces, or within same saprk app, when prompted to create dyamic pv,pvc 