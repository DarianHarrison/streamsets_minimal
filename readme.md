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

make sure to edit and modify docker images on the following yaml files before creating deployment
```
design-sdc/design-sdc.yaml
exec-sdc/exec-sdc.yaml
```

on k8's cluster first create ns, switch context:
```
https://github.com/DarianHarrison/streamsets_minimal
cd streamsets
kubectl apply -f design-sdc/namespace.yaml
kubectl config set-context --current --namespace=streamsets
```

create secrets:
```
kubectl create secret generic mysecrets --from-literal=dpmuser=user@org --from-literal=dpmpassword=password
```

deploy 2 types deployments: “Design” deployment with one SDC and “Execution” deployment with many.
```
kubectl apply -f design-sdc/
kubectl apply -f exec-sdc/
kubectl scale deployment exec-sdc --replicas=3
kubectl get all
```

view on browser
```
kubectl get svc
(go to browser) http://<master-ip>:<port>/
```
user:admin
pass:admin

then create statefulsets
```
kubectl apply -f statefulsets
```


resources:
```
https://github.com/onefoursix/sdc-k8s-deployment-with-custom-config#example-1-baked-in-configuration-and-how-to-set-java-opts
https://github.com/onefoursix/control-agent-k8s-deployment
https://streamsets.com/documentation/datacollector/latest/help/datacollector/UserGuide/Installation/MapR-Prerequisites.html
https://streamsets.com/documentation/datacollector/latest/help/datacollector/UserGuide/Installation/AddtionalStageLibs.html?hl=streamsets-datacollector-mapr_6_1-lib
https://streamsets.com/documentation/datacollector/latest/help/datacollector/UserGuide/Installation/AddtionalStageLibs.html#concept_evs_xkm_s5
https://github.com/streamsets/datacollector-kubernetes
```

////////////////////////// todos //////////////////////////////////////////

tasks:

*   need to read/write to/from local/external kdf
*   Finish setup of Streamsets on HPE-CP
*   Run the test framework
*   Time permitting finalize the test plan for StreamSets on HPE-CP

Test:
Regarding test plans, we use StreamSets Test Framework that creates environments via docker, automates creation of pipelines and manages configurations and then runs pipelines in an automated way in the environments it creates.
https://streamsets.com/blog/introducing-the-streamsets-test-framework/
https://streamsets.com/documentation/stf/latest/

setup docs:
https://streamsets.com/blog/scaling-out-streamsets-with-kubernetes/

general docs:
https://streamsets.com/documentation/controlhub/latest/help/controlhub/UserGuide/GettingStarted/GettingStarted_title.html

---------------------------
TESTS
---------------------------
setup,general docs:
```
https://streamsets.com/blog/scaling-out-streamsets-with-kubernetes/
https://streamsets.com/documentation/controlhub/latest/help/controlhub/UserGuide/GettingStarted/GettingStarted_title.html
```