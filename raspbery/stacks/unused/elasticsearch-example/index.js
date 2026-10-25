const winston = require("winston");

const logger = winston.createLogger({
  level: "info",
  format: winston.format.combine(
    winston.format.timestamp(),
    winston.format.json()
  ),
  transports: [new winston.transports.Console()],
});

setInterval(() => {
  logger.info("App is alive!", { uptime: process.uptime() });
}, 5000);

setTimeout(() => {
  logger.error("Something went wrong", { stack: new Error("Boom!").stack });
}, 10000);
