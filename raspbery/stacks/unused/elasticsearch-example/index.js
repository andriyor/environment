const winston = require("winston");
const packageJSON = require("./package.json");

const logger = winston.createLogger({
    level: "info",
    format: winston.format.combine(
        // winston.format.errors({ stack: true }),
        winston.format.timestamp(),
        winston.format.json(),
    ),
    transports: [new winston.transports.Console()],
});

// logger.error("kek");
// logger.error(new Error("fail"));
// logger.error("fail lol", { err: new Error("oops") });
logger.error("fail kek", new Error("oops"));

setInterval(() => {
    logger.info("App is alive!", {
        uptime: process.uptime(),
        version: packageJSON.version,
    });
}, 5000);

setTimeout(() => {
    logger.error("Something went wrong", { stack: new Error("Boom!").stack });
}, 10000);
