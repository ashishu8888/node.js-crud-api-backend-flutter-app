
const express = require('express');
const router = express.Router();
const Notes = require('./model');



 //server test..
        router.get('/', (req, res) => {
            console.log("I am server!");
            res.send("hii boys")
        });

        // fetch all notes...
        router.get('/all', async (req, res) => {
            let notes = await Notes.find();
            res.json(notes);
        });


        // add a new note
        router.post('/add', async (req, res) => {

            await Notes.deleteOne({ id: req.body.id });

            const newNote = new Notes({
                id: req.body.id,
                userid: req.body.userid,
                title: req.body.title,
                content : req.body.content,
            })
            
            await newNote.save();

            res.json({mesaage : "new note has been added!"});
        });

        // get notes by userid...
        router.post('/all/user', async (req, res) => {
            const userNotes = await Notes.find({ userid: req.body.userid });

            res.json(userNotes);
        });

        router.post('/delete', async (req, res) => {
            const response = await Notes.deleteOne({ id: req.body.id });

            if (response.acknowledged == true)
                res.json({ mesaage: "note was deleted" });
            else
                res.json({ error: "note was not deleted" });
        });
    module.exports = router