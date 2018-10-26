const Lokka = require("lokka").Lokka;
const Transport = require("lokka-transport-http").Transport;

const client = new Lokka({
  transport: new Transport("http://127.0.0.1:3000/graphql"),
});

export default client;
