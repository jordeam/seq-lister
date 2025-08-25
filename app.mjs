//index.js

import createError from "http-errors";
import express from "express";
import path from "path";
import { fileURLToPath } from 'url';
import cookieParser from "cookie-parser";
import logger from 'morgan';

import Debug from "debug";
const debug = Debug('lister:server');

import http from 'http';

import session from 'express-session';
import sessionFileStore from 'session-file-store';
const FileStore = sessionFileStore(session);

import sessionMemoryStore from 'memorystore';
const MemoryStore = sessionMemoryStore(session);

import indexRouter from "./routes/index.mjs";
import supergroupRouter from "./routes/supergroup.mjs";
import groupRouter from "./routes/group.mjs";
import componentRouter from "./routes/component.mjs";
import locationRouter from "./routes/location.mjs";
import bomRouter from "./routes/bom.mjs";
import locationEntryRouter from "./routes/locationentry.mjs";
import shoplistRouter from "./routes/shoplist.mjs";
import supplierRouter from "./routes/supplier.mjs";
import suppliercodeRouter from "./routes/suppliercode.mjs";
import caseRouter from "./routes/case.mjs";
import searchRouter from "./routes/search.mjs";
import scriptRouter from './routes/scripts.mjs';
import imageRouter from './routes/images.mjs';
import {initPassport, sessionCookieName} from './controllers/users.mjs';
import { router as usersRouter } from './routes/users.mjs';

import compression from "compression";
// import helmet from "helmet");
import fileUpload from 'express-fileupload';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const app = express();

// app.configure('development', function(){
//   app.use(express.errorHandler());
//   app.locals.pretty = true;
// });

// default options
app.use(fileUpload());

app.set('view options', { pretty: true });

app.set('trust proxy', 1);
app.get('/ip', (request, response) => response.send(request.ip));

// Set up rate limiter: maximum of twenty requests per minute
import RateLimit from "express-rate-limit";
const limiter = RateLimit({
  windowMs: 0.1 * 10 * 1000, // 1 seconds
  max: 30,
});
// Apply rate limiter to all requests
app.use(limiter);

// Sessions

app.use(session({
  store: new FileStore({ path: "sessions" }),
  secret: 'keyboard mouse',
  resave: true,
  saveUninitialized: true,
  name: sessionCookieName
}));
initPassport(app);

app.use(session({
 store: new MemoryStore({}),
 secret: 'keyboard mouse',
 resave: true,
 saveUninitialized: true,
 name: sessionCookieName
}));

// view engine setup

app.set("views", path.join(__dirname, "views"));
app.set("view engine", "pug");

app.use(logger("dev"));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());

// app.use( // Firefox sucks, does not get 'self'
//     helmet.contentSecurityPolicy({
//         directives: {
//             defaultSrc: ["'self'"],
//             scriptSrc: ["'self'", "code.jquery.com", "cdn.jsdelivr.net"],
//         },
//     })
// );

app.use(compression()); // Compress all routes

app.use(express.static(path.join(__dirname, "public")));

app.use("/", indexRouter);
app.use("/supergroup", supergroupRouter);
app.use("/supplier", supplierRouter);
app.use("/suppliercode", suppliercodeRouter);
app.use("/location", locationRouter);
app.use("/bom", bomRouter);
app.use("/locationentry", locationEntryRouter);
app.use("/shoplist", shoplistRouter);
app.use("/group", groupRouter);
app.use("/case", caseRouter);
app.use("/component", componentRouter);
app.use("/search", searchRouter);
app.use("/script", scriptRouter);
app.use("/image", imageRouter);
app.use('/users', usersRouter);

// catch 404 and forward to error handler
app.use(function (req, res, next) {
  next(createError(404));
});

// error handler
app.use(function (err, req, res, next) {
  // set locals, only providing error in development
  res.locals.message = err.message;
  res.locals.error = req.app.get("env") === "development" ? err : {};

  // render the error page
  res.status(err.status || 500);
  res.render("error");
});

/**
 * Get port from environment and store in Express.
 */

var port = normalizePort(process.env.PORT || '4000');
app.set('port', port);

/**
 * Create HTTP server.
 */

var server = http.createServer(app);

/**
 * Listen on provided port, on all network interfaces.
 */

server.listen(port);
server.on('error', onError);
server.on('listening', onListening);

console.log(`Server listening on port ${port}`);

/**
 * Normalize a port into a number, string, or false.
 */

function normalizePort(val) {
  var port = parseInt(val, 10);

  if (isNaN(port)) {
    // named pipe
    return val;
  }

  if (port >= 0) {
    // port number
    return port;
  }

  return false;
}

/**
 * Event listener for HTTP server "error" event.
 */

function onError(error) {
  if (error.syscall !== 'listen') {
    throw error;
  }

  var bind = typeof port === 'string'
    ? 'Pipe ' + port
    : 'Port ' + port;

  // handle specific listen errors with friendly messages
  switch (error.code) {
    case 'EACCES':
      console.error(bind + ' requires elevated privileges');
      process.exit(1);
    case 'EADDRINUSE':
      console.error(bind + ' is already in use');
      process.exit(1);
    default:
      throw error;
  }
}

/**
 * Event listener for HTTP server "listening" event.
 */

function onListening() {
  var addr = server.address();
  var bind = typeof addr === 'string'
    ? 'pipe ' + addr
    : 'port ' + addr.port;
  debug('Listening on ' + bind);
}

