**Allianz - Setup Jenkins in Kubernetes cluster**

**Problem :**
- Using your own laptop or one of the Cloud Providers, deploy a Kubernetes Cluster (e.g. minikube, kind, EKS, AKS, GKE, etc...)               
- Deploy Jenkins (or a similar tool) on Kubernetes and demonstrate a blue green deployment of an application example (ex: nodejs dummy app).   

**Solution :**
To setup the environment, tried below two approaches. 
1. Implemention using AWS cloud
2. Implemnetion on laptop using docker desktop

Both the approaches are currently paritially completed,they are explained below in detail:

**1. Implemention using AWS cloud**

In this approach, the gitlab pipeline (.gitlab-ci-aws.yml) created to deploy the infrastructure as code on AWS with 3 stages and before_script (to install awscli, helm and kubectl)

-   setup - Deploy the VPC using cloudformation stack 
-   create_eks - First it creates the role with name 'allianz-demo-eks-cluster-role' and attaching different permissions required for EKS deployment. Once role is created it creates the EKS cluster with name 'allianz-demo-eks-cluster' and node gorup with name 'allianz-demo-eks-cluster-group'
-   deploy_jenkins - Finally, once cluster and nodegroups are ready, job deploys jenkins using 'helm' and
     the config files aws-eks-config/jenkins-volume.yaml, aws-eks-config/jenkins-sa.yaml, aws-eks-config/jenkins-values.yaml.

Pipeline works fine as expected, It creates VPC, subnets, security groups, cluster, nodegroup(single node t3.small EC2, EBS gp2 20GB).However facing issues in setting up the jenkins on clusters.

**2. Implemnetion on laptop using docker desktop**

In this approach, you can install the docker desktop on the laptop. As docker Desktop includes a standalone Kubernetes server and client, as well as Docker CLI integration that runs on your machine. 
Once docker desktop is installed, enable the kubernetes option to run the Kubernetes server and client.

Furter tasks are automated in another gitlab pipeline (.gitlab-ci.yml) as below. (Please note that .gitlab-ci-aws.yml gitlab pipeline is only for approach 1 )
- setup - It just checks docker desktop is running or not. 
- deploy_jenkins - It deploys jenkins using 'helm'.

This pipeline runs as expected and installs the jenkins on kubernetes cluster. 
After getting jenkins admin password from pipeline, you can to login to the jenkins localhost URL. Installed the necessary docker plugins for pipeline.

- Deploing the application using Jenkins:

  Created the sample freestyle pipeline to build and push the docker image of python django application present in /src/* of this repository. Even after installing docker plugins, it fails due to missing docker in jenkins.

- Deploing the application using Gitlab pipeline:
  
  In the gitlab pipeline there is one stage called 'build_app', this builds docker image using 'Dockerfile' of django application   present on /src/* and pushes the image on docker hub public repository. This works perfectly fine. ´
This job is commented in gitlab pipeline, as this is created just to test the docker image of the application (without jenkins) and is also not part of challange.
