import { createServer } from "node:http";
import { greet } from "./greet.js";

createServer((req, res) => {
  res.writeHead(200, { "content-type": "application/json" });
  res.end(JSON.stringify(req.url === "/health" ? { ok: true } : { msg: greet("world") }));
}).listen(8080);
