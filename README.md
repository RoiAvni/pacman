# Pacman EKS Project

## 🎯 Overview
Deploying Pac-Man as a microservice on AWS EKS using Terraform and CodePipeline.

## 🧰 Technologies Used
- Terraform
- AWS EKS
- Kubernetes
- AWS CodePipeline & CodeBuild
- Docker

## 🗂 Structure
- `terraform/`: Infrastructure as Code (EKS)
- `kubernetes/`: Application YAML files
- `screenshots/`: Proof of deployment
- `pacman/`: Game source code (from https://github.com/font/pacman)

## 🚀 Deployment
1. Run Terraform to create infrastructure:
   ```bash
   terraform init
   terraform apply
   ```
2. CodePipeline will deploy the app automatically upon GitHub push.

## 🌐 Access
The service is exposed via LoadBalancer. Check `kubectl get svc`.

## 📸 Screenshots
See the `/screenshots/` folder.
