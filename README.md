cd /Users/nithish/Cloud-Computing

cat << 'EOF' > README.md
# Cloud-Native E-Commerce & SRE Platform (CCws26)

A production-style **Cloud-Native E-Commerce & Site Reliability Engineering** platform demonstrating reliability, fault tolerance, scalability, observability, role-based security, Infrastructure as Code, and FinOps cost modeling on AWS.

It pairs a dual-role **React (Vite + Tailwind CSS)** frontend (Customer Storefront & Admin Portal) and a **FastAPI + PostgreSQL + Redis** backend with **AWS Cognito** RBAC, wrapped in a multi-AZ AWS topology provisioned via modular **Terraform**, with **Prometheus/Grafana/CloudWatch** observability and **Locust** load testing.

---

## Project Overview

| Area | What this project demonstrates |
| --- | --- |
| **Architecture & Reliability** | Multi-AZ EC2 Auto Scaling Group behind an ALB, RDS PostgreSQL, ElastiCache Redis with graceful fallback to degraded DB-only mode, `/health` & `/ready` probes |
| **Security & RBAC** | AWS Cognito User Pool (`customer` vs. `admin` groups), JWT verification in FastAPI, least-privilege IAM roles & Security Groups, encrypted storage |
| **Scalability & Performance** | ALB + ASG CPU target-tracking autoscaling, Redis product caching, DB indexing, connection pooling, Locust load testing (P50/P95/P99 latency) |
| **Observability** | Prometheus + Grafana locally, CloudWatch dashboards & alarms + SNS notifications in AWS, structured JSON logs with request correlation IDs |
| **User Experience** | Dual-role React SPA (Customer Storefront + Admin Management Portal) hosted via S3 + CloudFront |
| **Infrastructure as Code** | Modular Terraform (`auth`, `networking`, `security`, `compute`, `database`, `cache`, `storage`, `monitoring`) with S3 remote state & DynamoDB locking |
| **FinOps & Pricing** | Idle baseline vs. active workload cost modeling (1k / 10k / 50k users) and Price-per-User breakdown |
| **CI/CD** | GitHub Actions: linting, `pytest` unit tests, `terraform fmt/validate`, and security checks |

## Team & Responsibilities

| Member | Role | Core Ownership |
| --- | --- | --- |
| **Nithish** | Cloud Infra & Security Lead | Terraform IaC (`VPC`, `ALB`, `ASG`, `RDS`, `ElastiCache`, `S3/CloudFront`, `Cognito`), AWS deployment & teardown |
| **Lalit** | Backend & API Engineer | FastAPI REST API, PostgreSQL schema, Redis caching & graceful fallback, Cognito JWT RBAC, `pytest` suite |
| **Varun** | Frontend & UX Engineer | React Customer Storefront & Admin Portal, Cognito auth integration, CloudFront hosting |
| **Sid** | SRE, Performance & FinOps Lead | Prometheus, Grafana, CloudWatch/SNS alerting, Locust load testing, incident simulations, AWS pricing models |

## Technology Stack

AWS · Terraform · Docker / Docker Compose · Python FastAPI · React (Vite + Tailwind CSS) · PostgreSQL · Redis · AWS Cognito · Prometheus · Grafana · CloudWatch · SNS · Locust · GitHub Actions

---

## Architecture

### AWS Architecture

```mermaid
flowchart LR
  User([Customers & Admins]) --> CF[CloudFront + S3<br/>React SPA]
  User --> Cognito[AWS Cognito<br/>JWT Auth & RBAC]
  User --> IGW[Internet Gateway]
  IGW --> ALB[Application Load Balancer<br/>public subnets, 2 AZs]
  ALB --> EC2a[EC2 FastAPI App<br/>private subnet AZ-a]
  ALB --> EC2b[EC2 FastAPI App<br/>private subnet AZ-b]
  EC2a --> RDS[(RDS PostgreSQL)]
  EC2b --> RDS
  EC2a --> Redis[(ElastiCache Redis)]
  EC2b --> Redis
  EC2a & EC2b --> CW[CloudWatch<br/>Logs / Metrics / Alarms]
  CW --> SNS[SNS Alert Topic]
  EC2a & EC2b --> S3Ops[(S3 Ops Bucket<br/>Backups & Logs)]
