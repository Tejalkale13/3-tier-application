# My App - 3-Tier Application with Docker and Kubernetes

This project demonstrates the deployment of a **3-tier application** using **Docker** for local development and **Kubernetes** for production-grade deployment. The application consists of the following components:
 
- **Frontend**: Built using **React.js**
- **Backend**: Built with **Flask** and connected to a **PostgreSQL** database
- **Database**: **PostgreSQL** 

## Project Structure

```
my-app/
├── backend/ 
│   ├── Dockerfile
│   ├── app.py
│   ├── requirements.txt
│   └── ...
├── frontend/
│   ├── Dockerfile
│   ├── src/
│   ├── public/
│   └── package.json
├── docker-compose.yml
└── kubernetes/
    ├── cluster.yaml
    ├── frontend.yaml
    ├── backend.yaml
    ├── postgres.yaml
    └── metrics.yaml
```

## How it works

1. **Frontend**: 
   - The frontend is built using **React.js** and communicates with the Flask backend.
   - It is containerized using **Docker** and configured to run on port `3000`.

2. **Backend**:
   - The backend is a **Flask** application that interacts with the **PostgreSQL** database.
   - The backend is containerized with a **Dockerfile** and communicates with the frontend through an API (accessible on port `5000`).

3. **Database**:
   - **PostgreSQL** is used to persist data for the application, including user items.
   - The database is configured as a service in the **docker-compose.yml** file.

4. **Docker**:
   - Each service (frontend, backend, database) is configured and managed using **Docker**.
   - The **docker-compose.yml** file is used to define and run the multi-container application, creating a seamless local environment for all services.

5. **Kubernetes**:
   - Kubernetes configurations are included for deploying the application to a **Kubernetes cluster**. 
   - The Kubernetes manifests (`frontend.yaml`, `backend.yaml`, `postgres.yaml`, `cluster.yaml`, `metrics.yaml`) provide the resources and settings for deploying the application on a **Google Kubernetes Engine (GKE)** cluster.

6. **Horizontal Pod Autoscaling**:
   - The backend and frontend are horizontally scalable using Kubernetes, with **Horizontal Pod Autoscaling (HPA)** to automatically scale pods based on CPU usage.

## Dependencies

### Local Development

- **Docker**: [Install Docker](https://docs.docker.com/get-docker/)
- **Docker Compose**: [Install Docker Compose](https://docs.docker.com/compose/install/)
- **Node.js**: [Install Node.js](https://nodejs.org/)
- **Python**: [Install Python](https://www.python.org/downloads/)
  
#### Frontend (React.js)
- **React.js**: The frontend app is built using React. Install dependencies with the following:
  
  ```bash
  cd frontend
  npm install
  ```

- **Required Packages** (for React):
  - `react`
  - `react-dom`
  - `react-scripts`

#### Backend (Flask)
- **Flask**: Install Flask and the required Python libraries using the following:

  ```bash
  cd backend
  pip install -r requirements.txt
  ```

- **Required Python Packages**:
  - `flask`
  - `psycopg2` (PostgreSQL adapter for Python)
  - `flask-cors` (for handling cross-origin requests)
  - `gunicorn` (WSGI HTTP server for production deployment)

#### PostgreSQL
- **PostgreSQL**: This is used as the database for the backend. You can use a local PostgreSQL instance or a managed database service.

  - To run it locally, **Docker Compose** will manage it for you, as specified in the `docker-compose.yml`.

### Kubernetes

- **kubectl**: [Install kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)
- **Google Cloud SDK (for GKE)**: [Install the Google Cloud SDK](https://cloud.google.com/sdk/docs/install)

### How to Run Locally

### 1. Clone the repository:

```bash
git clone https://github.com/Prasad-b-git/3-tier-application.git
cd 3-tier-application
```

### 2. Setup the Project

#### Backend Setup

Run the `backend.sh` script to set up the backend service:

```bash
chmod +x backend.sh
./backend.sh
```

This will create the necessary directory structure, Dockerfiles, and configuration files for the backend service.

#### Frontend Setup

Run the `frontend.sh` script to set up the frontend service:

```bash
chmod +x frontend.sh
./frontend.sh
```

This will create the necessary directory structure, Dockerfiles, and configuration files for the frontend service.

#### Main Setup

Finally, run the `main.sh` script to set up the project with Docker Compose:

```bash
chmod +x main.sh
./main.sh
```

This will create the **docker-compose.yml** file and set up the application structure for both frontend and backend, and database.

### 3. Build and Run the Application with Docker Compose

```bash
docker-compose up --build
```

This will:

- Build and start the **frontend**, **backend**, and **database** services.
- The frontend will be available at `http://localhost:3000`.
- The backend API will be available at `http://localhost:5000`.

### 4. Access the Application

- **Frontend**: Open `http://localhost:3000` in your browser to access the application.
- **Backend**: The backend API can be accessed at `http://localhost:5000/items`.

## Kubernetes Deployment

To deploy the application on Kubernetes:

### 1. Cluster Setup

Use the **cluster.yaml** to set up your Kubernetes cluster. The manifest contains all necessary configurations for setting up the cluster.

```bash
kubectl apply -f kubernetes/cluster.yaml
```

### 2. Deploy Services

Apply the Kubernetes manifest files for the **frontend**, **backend**, and **postgres** services:

```bash
kubectl apply -f kubernetes/postgres.yaml
kubectl apply -f kubernetes/backend.yaml
kubectl apply -f kubernetes/frontend.yaml
```

### 3. Horizontal Pod Autoscaling

To ensure the backend and frontend services scale dynamically based on CPU usage, apply the **metrics.yaml**:

```bash
kubectl apply -f kubernetes/metrics.yaml
```

### 4. Access the Application

Once the services are running in the Kubernetes cluster, you can access the application using the external IP of the load balancer or set up port-forwarding.

## Technologies Used

- **Frontend**: React.js
- **Backend**: Flask
- **Database**: PostgreSQL
- **Docker**: For containerizing services
- **Kubernetes**: For orchestrating services and auto-scaling
- **Google Kubernetes Engine (GKE)**: For cloud deployment

## Conclusion

This project demonstrates the power of Docker and Kubernetes in deploying a scalable 3-tier web application. By using Kubernetes, the application can scale up or down automatically based on the load, making it efficient for production use.

--- 
