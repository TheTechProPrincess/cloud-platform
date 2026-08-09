const http = require('http');
const os = require('os');

const startTime = Date.now();

const server = http.createServer((req, res) => {
  if (req.url === '/health') {
    const uptimeSeconds = Math.floor((Date.now() - startTime) / 1000);
    const status = {
      status: 'healthy',
      uptimeSeconds: uptimeSeconds,
      hostname: os.hostname(),
      freeMemoryMB: Math.round(os.freemem() / 1024 / 1024),
      loadAverage: os.loadavg()
    };
    res.writeHead(200, { 'Content-Type': 'application/json' });
    res.end(JSON.stringify(status, null, 2));
    return;
  }

  res.writeHead(200, { 'Content-Type': 'text/plain' });
  res.end('cloud-platform app is running. Try /health for status.\n');
});

const PORT = process.env.PORT || 3000;
server.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
