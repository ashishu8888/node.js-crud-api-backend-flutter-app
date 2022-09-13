const express = require("express");
const app = express();
const mongoose = require('mongoose')
const Notes = require("./model")
const bodyParser = require('body-parser');
const router = require("./route");
const PORT = process.env.PORT || 3000

app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());


mongoose.connect('mongodb+srv://ashish:ashish123@cluster0.pymnbol.mongodb.net/?retryWrites=true&w=majority').then(
    function () {
        app.get("/", function (req, res) {
            const response = { message: "API Works !" }
            res.json(response)
        }
        );
        app.use("/notes",router)
    }
)

app.listen(PORT, function () {
    console.log(`server started at port : ${PORT}`);
});
