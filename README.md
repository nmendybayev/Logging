# Hi 

# Core Setup for a Logging Solution Based on Elasticsearch, Fluentd, and Kibana (EFK Stack)

## EFK stack
The EFK stack consists of the following components:

### Elasticsearch: 
A distributed, RESTful search and analytics engine that stores and indexes log data for analysis and visualization.

### Fluentd: 
An open-source data collector that ingests logs from various sources, transforms them, and sends them to Elasticsearch.

### Kibana: 
A web application providing a user interface to visualize and analyze log data stored in Elasticsearch.

### Introduction
The EFK stack, also known as the Elastic-Fluentd-Kibana stack, is a powerful data processing and analysis solution used for log management and analytics. It combines three open-source technologies—Elasticsearch, Fluentd, and Kibana—to efficiently collect, process, store, and visualize large volumes of log data.

Elasticsearch serves as the core component, functioning as a distributed, scalable, and real-time search and analytics engine. It provides fast search results and supports advanced querying capabilities, making it ideal for handling log data.

Fluentd acts as the centralized log collector and transport layer. It efficiently collects logs from various sources, such as servers, applications, and network devices, and sends them to Elasticsearch for indexing and analysis. Fluentd supports a wide range of data sources and provides robust filtering and transformation capabilities.

Kibana is the visualization tool of the EFK stack, enabling users to explore, analyze, and visualize log data in real-time. It offers a user-friendly interface with powerful dashboards, charts, and graphs to help identify trends, patterns, and anomalies in the log data. Kibana provides a rich set of visualizations and allows for the creation of customized dashboards to meet specific monitoring and analysis needs.

Overall, the EFK stack provides a comprehensive log management solution, empowering organizations to gain valuable insights from their log data to improve troubleshooting, security monitoring, performance optimization, and business intelligence.

### Challenges in Logging

- Centralized overview of all log events
- Normalizing different log types
- Automated processing of log messages
- Supporting diverse event sources

### Prerequisites

Before deploying the EFK stack, ensure you have the following:

- A running Kubernetes cluster with cluster admin permissions
- kubectl command-line tool installed and configured
- Docker installed on your local machine

### Installation
A set of YAML files for the Kubernetes deployment of the EFK stack (Elasticsearch, Fluentd, and Kibana) are provided.

Kubernetes clusters come with predefined namespaces (e.g., kube-system, kube-public) that contain resources necessary for proper function. Namespaces help divide cluster resources among multiple users. Start by creating a namespace:

kubectl apply -f efk-namespace.yaml
Confirm the namespace is created:

kubectl get namespaces
If everything looks as expected, continue by creating the Elasticsearch cluster. Deploying a 3-node Elasticsearch cluster in Kubernetes requires using a StatefulSet, which provides pods with a stable identity and persistent storage. Elasticsearch needs stable storage to persist data between pod rescheduling and restarts. Create the Elasticsearch cluster:

kubectl apply -f es-svc.yaml
kubectl apply -f es-sts.yaml
Next, create the Kibana deployment resources to run Kibana, which will provide a centralized interface for analyzing application logs:

kubectl apply -f kibana.yaml
Kibana is exposed on port 5601.

For the final step, deploy the Fluentd log collector using a DaemonSet. Kubernetes will roll out a copy of this pod (node-logging agent) on each worker node in the cluster. This agent runs as a container in a pod, accessing a directory with log files from all application containers on the node. It collects, parses, and ships the logs to Elasticsearch. Run the following commands:

kubectl apply -f fluentd.yaml
Verify that everything is created successfully:

kubectl get all -n efk-logging
To access the dashboards, launch the Kibana web interface using the LoadBalancer's DNS name.