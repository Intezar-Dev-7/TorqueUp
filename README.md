# ⚙️ TorqueUp – Car & Bike Service Center Management System

**TorqueUp** is a SaaS platform for managing daily operations of **car and bike service centers**.
It handles bookings, vehicles, inventory, employees, and reports in one system.

---

## ✨ Key Features

* 📅 **Booking and scheduling**
* 🧰 **Inventory tracking** 
* 👩‍🔧 **Employee management**
* 📊 **Reports and analytics**
* 📊 **Dashboard overview** 
* 🧑‍🔧 **Staff management** (mechanics, interns, employees)
* 🔐 **Authentication and role-based access**

---

## 🧩 Core Modules & Features

### 📊 Dashboard

Provides a quick overview of key operations.

#### Features:

* View **inventory status** at a glance
* Track **active bookings**


---

### 👤 User Management

* Secure registration and login
* **Role-based access**:

  * Admin
  * Receptionist
  * Customer
* Change password
* JWT-based authentication

---

### 📅 Booking Management

Handle customer bookings and service requests.

#### Features:

* ➕ Add bookings 
* 🔄 Update booking status 
* 📋 Fetch bookings with filters
* ❌ Delete bookings
* 🔁 Status flow: *Scheduled → In Progress → Completed*

---

### 🏷️ Inventory Management

Manage workshop parts and supplies.

#### Features:

* ➕ Add parts 
* 🔄 Update quantities and details
* 📋 View inventory 
* ❌ Delete items
* ⚠️ Low stock alerts

---

### 👩‍🔧 Staff Management

Manage all staff including mechanics, interns, and other employees.

#### Features:

* ➕ Add staff members
* 🔄 Update roles and details
* 📋 View staff by role
* ❌ Remove staff records

---


### 📈 Reports

Track business data.

#### Metrics include:

* 💰 Revenue reports
* 🧾 Inventory usage
* 💬 Customer activity

---

## 🧠 Tech Stack

| Layer          | Technologies                          |
| -------------- | ------------------------------------- |
| **Frontend**   | Flutter                               |
| **Backend**    | Node.js, Express.js                   |
| **Database**   | MongoDB                               |
| **Auth**       | JWT, bcrypt                           |
| **Deployment** | Netlify (Frontend) • Render (Backend) |

---

## 🔗 Project Link

👉 **Live Demo:** https://vraxton.netlify.app/
