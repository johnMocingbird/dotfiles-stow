const {
  createConnection,
  subscribeEntities,
  callService,
} = require("home-assistant-js-websocket");

async function connectToHomeAssistant() {
  // Replace with your Home Assistant URL and Long-Lived Access Token
  const connection = await createConnection({
    url: "ws://192.168.50.2:8123/api/websocket",
    token:
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJjM2M3MGRlNzgyZWU0MDc0OTZkN2M4Yjk2NTNlODNhYyIsImlhdCI6MTcwMzI2NTc5NiwiZXhwIjoyMDE4NjI1Nzk2fQ.2KklLAGuVtBYHwxYgGfgbzMd8yiI0Jl5Yh2wHYMQA1o",
  });

  // Log when connection is established
  console.log("Connected to Home Assistant");

  // Replace 'light.your_light_entity_id' with the actual entity ID of your light
  callService(connection, "light", "turn_on", {
    entity_id: "light.your_light_entity_id",
  });
}

connectToHomeAssistant().catch((error) => {
  console.error(error);
  console.log("hi");
});
