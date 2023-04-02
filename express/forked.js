const cluster = require("node:cluster");

if (cluster.isPrimary) {
  // Count the machine's CPUs
  const cpuCount = require("os").cpus().length;

  // Create a worker for each CPU
  for (let i = 0; i < cpuCount; i += 1) {
    cluster.fork();
  }
} else {
  require("./index.js");
}
