# Azure Kubernetes Security and Observability

## 🚨 Challenges Addressed

### 🔐 Security Vulnerabilities
- ❌ No runtime intrusion detection in cloud kubernetes clusters.
- ❌ No policy enforcement for cluster compliance.

### 👁️ Lack of Observability
- ❌ Limited visibility into cluster state and potential threats.

---

## ✅ Solution Overview

I implemented a robust **security and monitoring** strategy through:

- 🧱 **Intrusion prevention mechanisms**
- 🕵️ **Intrusion detection mechanisms**
- 📈 **Observability and monitoring best practices**

---

## 📌 About This project

It is a scalable, Azure Kubernetes security projet that integrates, it can be done with any other cloud platform (AWS/GCP):

- 🛡️ **Falco**: Real-time runtime intrusion detection via system call analysis.
- 🔒 **OPA Gatekeeper**: Policy enforcement engine for compliance and security.
- 📊 **Prometheus & Grafana**: Real-time metrics collection and visual dashboards.
- 🔍 **crAPI**: An intentionally vulnerable OWASP API application for penetration testing and demo purposes.

> 🧭 Deployed on **Azure Kubernetes Service (AKS)** with a **web interface** for managing rules and alerts.

---

## 🏗️ Architecture Overview

### 1. 📡 Overall Architecture
!(assets/GlobalArchitecture.jpg)

- **crAPI Namespace**
  - Microservices:
    - `Identity` (Java)
    - `Community` (Go)
    - `Workshop` (Python)
    - `Web` (JavaScript)
  - Databases:
    - MongoDB / PostgreSQL (via StatefulSet + Azure Persistent Volumes)

- **Monitoring Namespace**
  - Prometheus Operator
  - Grafana Dashboards

- **OPA Namespace**
  - OPA Gatekeeper for Kubernetes policy enforcement

- **Falco Namespace**
  - DaemonSet-based intrusion detection with event forwarding

---

### 2. 📈 Monitoring Stack

- **Prometheus Operator**: Manages `ServiceMonitors`, rules, and alerts.
- **Node Exporter** + **Kube State Metrics**: Cluster and node-level metrics.
- **Grafana**: Real-time observability through pre-configured dashboards.

---

### 3. 🧪 crAPI Services

- `Web` Service: Frontend orchestrating Identity, Community, and Workshop
- `Identity` / `Community` / `Workshop`: Each implemented in a different language for realistic attack surfaces
- `MongoDB` and `PostgreSQL`: With persistent storage
- `Mailhog`: Email catcher used for simulating notifications

---

### 4. 🔁 Falco Event Flow

1. **Falco** detects suspicious behavior (e.g., reverse shell).
2. **Falcosidekick** forwards events to:
   - Web interface for real-time alerts
   - Fluent Bit → Cloud Logging / Elasticsearch
!(assets/falcoworkflow.jpg)


---

### 5. 📜 OPA Gatekeeper Workflow

- API Server → Gatekeeper validating webhook
- **Rego constraints** determine whether requests are allowed or denied based on compliance rules (e.g., resource limits, naming conventions)
!(assets/opaworkflow.jpg)
 

---

## 📦 Technologies Used

- **Kubernetes (AKS)**
- **Falco**
- **OPA Gatekeeper**
- **Prometheus Operator**
- **Grafana**
- **crAPI**
- **Nginx Ingress**
- **Azure Load Balancer**

---








