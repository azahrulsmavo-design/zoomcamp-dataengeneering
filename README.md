# Zoomcamp Project

## Modules

- [Module 1: Docker & SQL](Module-1/Homework/README.md)
- [Module 2: Workflow Orchestration](Module-2/KESTRA_SETUP.md)

## 🚀 Getting Started (Universal Environment)

This project uses a **Universal Docker Environment** located at the project root.

### 1. Start Services
Run the following command from this root directory to start Postgres, PgAdmin, and Kestra:

```bash
docker-compose up -d
```

### 2. Access Tools
- **Kestra UI**: [http://localhost:8081](http://localhost:8081)
- **PgAdmin**: [http://localhost:8080](http://localhost:8080)
  - User: `pgadmin@pgadmin.com`
  - Pass: `pgadmin`
- **Database**:
  - Host: `postgres`
  - Port: `5432`
  - User/Pass: `postgres`

