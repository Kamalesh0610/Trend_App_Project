# Trend App Deployment

## Overview

This project demonstrates end-to-end deployment of a React application to a production-ready environment using Docker, Terraform, AWS EKS (Kubernetes), Jenkins CI/CD, and monitoring. The infrastructure is fully automated and cloud-native.

---

## Table of Contents

- [Application Setup](#application-setup)
- [Dockerization](#dockerization)
- [Infrastructure Provisioning (Terraform)](#infrastructure-provisioning-terraform)
- [Kubernetes Deployment](#kubernetes-deployment)
- [CI/CD Pipeline (Jenkins)](#cicd-pipeline-jenkins)
- [Monitoring](#monitoring)
- [Version Control](#version-control)
- [Screenshots](#screenshots)
- [LoadBalancer ARN](#loadbalancer-arn)

---

## Application Setup

1. **Clone the Repository**
   ```
   git clone https://github.com/Kamalesh0610/Trend_App_Project.git
   cd Trend_App_Project
   ```

---

## Dockerization

- The [`Dockerfile`](Dockerfile) builds a production-ready image for Nginx serving the React app.
- Build and run:
  ```
  docker build -t <your-dockerhub-username>/trend-app-repo:latest .
  docker run -p 3000:80 <your-dockerhub-username>/trend-app-repo:latest
  ```

---

## Infrastructure Provisioning (Terraform)

- Infrastructure is defined in [`main.tf`](main.tf), [`variables.tf`](variables.tf), and [`outputs.tf`](outputs.tf).
- Resources: VPC, public/private subnets, Internet Gateway, Route Table, Security Group, IAM Role/Profile, EC2 (Jenkins).
- Provision with:
  ```
  terraform init
  terraform plan
  terraform apply
  ```
- Jenkins EC2 instance is provisioned with user data from [`userdata.tpl`](userdata.tpl).

---

## Kubernetes Deployment

- EKS cluster setup (see your AWS console).
- Deployment and Service manifests: [`deployment.yaml`](deployment.yaml), [`service.yaml`](service.yaml).
- Deploy with:
  ```
  kubectl apply -f deployment.yaml
  kubectl apply -f service.yaml
  ```

---

## CI/CD Pipeline (Jenkins)

- Jenkins installed on EC2 (see [`userdata.tpl`](userdata.tpl)).
- Declarative pipeline in [`Jenkinsfile`](Jenkinsfile):
  - Clones repo
  - Builds Docker image
  - Pushes to DockerHub
  - Deploys to EKS via `kubectl`
- GitHub webhook triggers build on every commit.

---

## Monitoring

  - Implement monitoring using open-source tools like Prometheus, Grafana, or Lens   to track cluster and application health.

---

## Version Control

- `.gitignore` and `.dockerignore` included.
- Push codebase to GitHub:
  ```
  git init
  git add .
  git commit -m "Initial commit"
  git remote add origin <your-github-repo-url>
  git push -u origin main
  ```

---

## Screenshots

> - AWS resources created
![image alt](https://github.com/Kamalesh0610/Trend_App_Project/blob/main/Screenshot/01.png)



> - Jenkins running on Ubuntu
![image alt](https://github.com/Kamalesh0610/Trend_App_Project/blob/main/Screenshot/02.png)



> - Installed plugins list
![image alt](https://github.com/Kamalesh0610/Trend_App_Project/blob/main/Screenshot/03.png)



> - User-triggered build
![image alt](https://github.com/Kamalesh0610/Trend_App_Project/blob/main/Screenshot/07.png)



> - Webhook-triggered build
![image alt](https://github.com/Kamalesh0610/Trend_App_Project/blob/main/Screenshot/08.png)



> - Build stages overview
![image alt](https://github.com/Kamalesh0610/Trend_App_Project/blob/main/Screenshot/09.png)



> -Grafana dashboards
![image alt](https://github.com/Kamalesh0610/Trend_App_Project/blob/main/Screenshot/10.png)



> - Grafana Logs
![image alt](https://github.com/Kamalesh0610/Trend_App_Project/blob/main/Screenshot/11.png)



> - Prometheus Monitoring
![image alt](https://github.com/Kamalesh0610/Trend_App_Project/blob/main/Screenshot/12.png)



> - Final output: Trendify homepage
![image alt](https://github.com/Kamalesh0610/Trend_App_Project/blob/main/Screenshot/01.png)




---

## LoadBalancer ARN

```

http://a4b5db8103d2b462e80944139eeb5f4b-979003950.ap-south-1.elb.amazonaws.com/

```

---

## References

- [Dockerfile](Dockerfile)
- [main.tf](main.tf)
- [deployment.yaml](deployment.yaml)
- [service.yaml](service.yaml)
