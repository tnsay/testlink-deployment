
# TestLink Deployment Package

This repository contains the required files to deploy the TestLink QA/Test Case Management Tool on an internal server.

---

## 📁 Structure

- `testlink2/` — Full TestLink application folder (from local MAMP installation).
- `testlink2.sql` — MySQL dump of the TestLink database.
- `README.md` — Deployment instructions.

---

## 🛠 Deployment Steps (for DevOps)

### 1. **Move Files**
Clone or download this repo and deploy the contents of the `testlink2/` folder to:

```
/var/www/html/testlink
```

> Or use another directory that your Apache server points to (DocumentRoot).

---

### 2. **MySQL Database Setup**
Create a new database and user in MySQL:

```sql
CREATE DATABASE testlink;
CREATE USER 'testlink_user'@'localhost' IDENTIFIED BY 'yourpassword';
GRANT ALL PRIVILEGES ON testlink.* TO 'testlink_user'@'localhost';
FLUSH PRIVILEGES;
```

Then import the provided SQL dump:

```bash
mysql -u testlink_user -p testlink < /path/to/testlink2.sql
```

---

### 3. **Configure Database Connection**
Edit the database config file:

```
/var/www/html/testlink/config_db.inc.php
```

Update the following values as needed:

```php
$tlCfg->dbhost   = 'localhost';        // or DB server address
$tlCfg->dbname   = 'testlink';         // name of the created DB
$tlCfg->dbuser   = 'testlink_user';    // MySQL user
$tlCfg->dbpass   = 'yourpassword';     // MySQL password
```

---

### 4. **Set File Permissions**
Ensure Apache (or your web server) can access and manage the TestLink files:

```bash
sudo chown -R www-data:www-data /var/www/html/testlink
```

---

### 5. **Access TestLink**
Once deployed, open TestLink in your browser:

```
http://your-server-ip/testlink
```

> Replace `your-server-ip` with the actual IP or domain name of your server.

---

## Deliverables in this Repo

| Item             | Description                          |
|------------------|--------------------------------------|
| `testlink2/`     | PHP files & assets for TestLink app  |
| `testlink2.sql`  | MySQL database dump for TestLink     |
| `README.md`      | Deployment guide (this file)         |
