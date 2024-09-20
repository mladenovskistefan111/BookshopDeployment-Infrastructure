# **BookshopDeployment-Infrastructure**

This project is a hands-on DevOps practice designed to demonstrate multiple skills and tools for automating the deployment of a **highly resilient** and **highly available** cloud infrastructure and an application on **AWS**. The infrastructure and application deployment are fully managed through **CI/CD pipelines**, **Terraform**, **Helm**, and **Kubernetes (EKS)**.

## **Overview**

This repository contains **Terraform configurations** and **Helm charts** that set up an automated AWS infrastructure for deploying a **bookshop application**. The key components of the infrastructure include:

- **VPC** with public and private subnets spanning **two availability zones**.
- **Multi-AZ RDS PostgreSQL** database for high availability.
- **Bastion Host** to populate the RDS database using an SQL dump.
- **EKS Cluster** with worker nodes in two private subnets.
- **Two NAT Gateways** (one in each public subnet) to allow EKS worker nodes internet access.

To help visualize the infrastructure, I created a diagram of the architecture:

![Infrastructure Diagram](https://github.com/mladenovskistefan111/AppDeploymentProject-Infrastructure/blob/main/Infrastructure.png)

### **CI/CD Pipelines**

- **Pipeline 1** provisions the entire AWS infrastructure using **Terraform**, populates the RDS database via the Bastion host, and deploys the **EKS cluster** with worker nodes, NAT Gateways, and necessary networking components.
- **Pipeline 2** deploys the frontend and backend of the bookshop application on **EKS** using **Helm charts**. It:
  - Sets up namespaces for the application.
  - Deploys frontend and backend pods.
  - Creates LoadBalancer services and provides a DNS link to access the application.

### **Automated Code Deployment**

- This infrastructure integrates with the [**AppDeploymentProject-Code**](https://github.com/mladenovskistefan111/AppDeploymentProject-Code) repository, which contains the frontend (Angular) and backend (Spring Boot) code.
- When code changes are pushed to the [**AppDeploymentProject-Code**](https://github.com/mladenovskistefan111/AppDeploymentProject-Code) repository, a CI/CD pipeline is triggered to build both the frontend and backend into Docker images and push them to **DockerHub**.
- After the build is complete, another pipeline is triggered to perform a **rolling update** on the Kubernetes deployment, where new pods are created from the updated images, and old pods are safely terminated.

## **Key Features**

- **Fully automated** infrastructure deployment using **Terraform** and **GitHub Actions**.
- **Highly available** Multi-AZ RDS PostgreSQL database.
- **Kubernetes (EKS)** cluster for containerized applications.
- **Helm charts** to streamline application deployment on EKS.
- End-to-end **CI/CD pipelines** for both infrastructure and application deployment, resulting in a **highly resilient** and scalable environment.
- **Automated code rollout** ensures seamless deployment of updated application images to the Kubernetes cluster.
