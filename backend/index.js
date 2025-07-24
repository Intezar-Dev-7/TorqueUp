const express = require("express");

const app = express();

const Port = 3000;

app.get('/', (req, res) => {
    res.send('Server Started');
    res.end();
});

app.listen(Port, '0.0.0.0', () => {
    console.log('Connected');
}
);