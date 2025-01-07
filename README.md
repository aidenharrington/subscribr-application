# Subscribr Application

Subscribr is a Dockerized full-stack application that includes the following components:

- **React Frontend**: Located in the `subscribr-frontend` folder.
- **Java Spring Boot Backend APIs**:
  - `subscribr-api`
  - `subscribr-video-uploader`
- **PostgreSQL Database**: Used for storing application data.

The application is fully containerized using Docker and can be run with a single command (see section: How to Run) after initializing the submodules.

---

## Prerequisites

1. **Git**: Ensure Git is installed on your system.
2. **Docker**: Install Docker and Docker Compose.
3. **Node.js**: (Optional) If you wish to run the React frontend outside of Docker.

---

## Cloning the Project

This project uses Git submodules to include the `subscribr-frontend`, `subscribr-api`, and `subscribr-video-uploader` repositories. To properly clone the project, follow these steps:

```bash
# Clone the main repository
git clone --recurse-submodules <repository-url>

# If you've already cloned the repo without submodules, initialize and update them
cd <repository-folder>
git submodule update --init --recursive
```

---

## Project Structure

```
project/
├── docker-compose.yml
├── scripts/
│   └── init.sql             # SQL script to create required tables
├── subscribr-frontend/      # React frontend submodule
├── subscribr-api/           # Java Spring Boot API submodule
├── subscribr-video-uploader/ # Java Spring Boot Video Uploader API submodule
└── README.md
```

---

## How to Run

### 1. Build and Run the Docker Containers

Ensure you are in the root directory of the project, then run the following command:

```bash
./run-subscribr.sh
```

This will:
- Build the Docker images for the frontend, backend APIs, and PostgreSQL database.
- Automatically run the `init.sql` script to create the required tables in the PostgreSQL database.

### 2. Access the Application

- **Frontend**: Navigate to `http://localhost:3000`.
- **API Endpoints**:
  - `subscribr-api`: `http://localhost:8080`
  - `subscribr-video-uploader`: `http://localhost:9000`

---

## Database Initialization

The PostgreSQL database is automatically initialized with the following tables during the first container startup:

- **users**:
  ```sql
  CREATE TABLE users (
      id SERIAL PRIMARY KEY,
      userName VARCHAR(255) NOT NULL UNIQUE
  );
  ```
- **subscriptions**:
  ```sql
  CREATE TABLE subscriptions (
      id SERIAL PRIMARY KEY,
      subscriber_id INT NOT NULL,
      subscribed_to_id INT NOT NULL,
      FOREIGN KEY (subscriber_id) REFERENCES users(id) ON DELETE CASCADE,
      FOREIGN KEY (subscribed_to_id) REFERENCES users(id) ON DELETE CASCADE,
      CONSTRAINT unique_subscription UNIQUE (subscriber_id, subscribed_to_id)
  );
  ```
- **videos**:
  ```sql
  CREATE TABLE videos (
      id SERIAL PRIMARY KEY,
      name VARCHAR(255) NOT NULL,
      release_date TIMESTAMP DEFAULT NOW(),
      video_uploader_id INT NOT NULL,
      FOREIGN KEY (video_uploader_id) REFERENCES users(id) ON DELETE CASCADE
  );
  ```

---

## Stopping the Application

To stop the application and remove the containers:

```bash
docker-compose down
```

---

## Troubleshooting

1. **Database Tables Not Created**: Ensure the `scripts/init.sql` file is mounted correctly in the `docker-compose.yml` under the `db` service.
2. **Ports Already in Use**: Check if the required ports (3000, 8080, 9000, 5432) are free. If not, update the `docker-compose.yml` file to use different ports.
3. **Submodules Missing**: Ensure you ran `git submodule update --init --recursive` after cloning the repository.

---

