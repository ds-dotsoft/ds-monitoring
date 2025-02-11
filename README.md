# Advanced Monitoring Tool for FiveM

A full-stack monitoring solution for FiveM servers.

## Project Overview

This project provides real-time monitoring of your FiveM server by collecting key metrics and displaying them on a live dashboard.

### Components
- **FiveM Agent (Lua):** Gathers server metrics (memory usage, tick time, player count) every 5 seconds and sends them via HTTP to the backend.
- **Node.js Backend:** Receives, logs, and broadcasts metrics via Socket.IO.
- **Live Dashboard (HTML/JS):** Displays real-time metrics in a clean and responsive UI.

## Features
✅ **Real-Time Metrics:** Collects **memory usage, tick time, and player count**.  
✅ **Live Visualization:** Updates in real-time using **Socket.IO**.  
✅ **Easy Integration:** Simply drop the resource into your server and start monitoring.  
✅ **Extensible:** Easily expandable for more metrics or custom features.

---

## Project Structure

```
advanced-monitoring-tool/
├── fivem-agent/            # FiveM monitoring resource
│   ├── fxmanifest.lua      # FiveM resource manifest
│   └── monitor.lua         # Monitoring script (Lua)
├── server/                 # Node.js backend
│   ├── package.json        # Node.js dependencies
│   └── index.js            # Server logic
└── client/                 # Web dashboard
    └── index.html          # Frontend UI
```

---

## Installation & Setup

### 1️⃣ FiveM Agent
1. Copy the `fivem-agent` folder into your FiveM server's `resources` directory.
2. In your `server.cfg`, add:
   ```ini
   ensure fivem-agent
   ```

### 2️⃣ Node.js Backend
1. Navigate to the `server` directory in your terminal.
2. Install dependencies:
   ```bash
   npm install
   ```
3. Start the backend:
   ```bash
   npm start
   ```

### 3️⃣ Dashboard
- Once the backend is running, open:
  ```
  http://localhost:3000
  ```
  in your browser to see real-time metrics.

---

## How It Works
- **FiveM Agent:** Sends metrics every 5 seconds to `http://localhost:3000/metrics` using HTTP POST.
- **Backend:** Receives and broadcasts metrics in real time via **Socket.IO**.
- **Dashboard:** Displays real-time updates for server performance monitoring.

---

## Documentation
The `monitor.lua` file contains **LuaDoc** comments for easy understanding. You can use a **LuaDoc generator** for documentation.

---

## Contributing
Pull requests and issue reports are welcome! Fork the repo and submit your improvements.

## License
This project is licensed under the **MIT License**.
