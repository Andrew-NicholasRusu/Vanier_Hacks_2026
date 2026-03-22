const express = require("express");

const app = express();
const PORT = 3000;

app.set('view-engine', 'ejs');

app.use((req, res, next) => {
    console.log(`[${new Date().toISOString()}] Request to path ${req.url} from IP ${req.ip}.`)
    next();
})

app.get('/', (req, res) => {
    res.redirect('/errors/my-brand-new-website/');
})

app.get('/errors/my-brand-new-website/', (req, res) => {
    res.render('index.ejs');
});

app.get('/errors/my-brand-new-website/flag/', (req, res) => {
    res.render('flag.ejs', { flag: crypto.randomUUID() });
})

app.listen(PORT, () => {
    console.log('My first server is listening on port ' + PORT + "!");
})