const express = require('express');
const http = require('http');
const socketIo = require('socket.io');

const app = express();
const server = http.createServer(app);
const io = socketIo(server);

// Middleware to parse JSON bodies
app.use(express.json());

// Endpoint to receive metrics from the FiveM agent
app.post('/metrics', (req, res) => {
    const metric = req.body;
    console.log("Received metric:", metric);

    // Broadcast the metric to connected clients
    io.emit('metric', metric);
    res.sendStatus(200);
});

// Serve the static dashboard from the client folder
app.use(express.static(__dirname + '/../client'));

const PORT = 3000;
server.listen(PORT, () => {
    console.log(`Server listening on port ${PORT}`);
});
