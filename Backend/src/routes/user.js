const { Router } = require('express');
const router = Router();

const mysqlConnection = require('../database');

router.get('/', (req, res) => {
    res.status(200).json('Server on port 4000 and Database is connected.');
});

router.get('/:users', (req, res) => {
    mysqlConnection.query('select * from user', (error, rows, fields) => {
        if(!error) {
            res.json(rows);
        } else {
            console.log(error);
        }
    });
});

//This function allows us concatenate 'id' to url => localhost:4000/id
router.get('/:users/:id', (req, res) => {
    const { id } = req.params;
    mysqlConnection.query('select * from user where id = ?', [id], (error, rows, fields) => {
        if(!error) {
            res.json(rows);
        } else {
            console.log(error);
        }
    })
});

router.post('/:users', (req, res) => {
    const { id, username, name, lastname, mail, randomstr, hash } = req.body;
    console.log(req.body);
    mysqlConnection.query('insert into user(id, username, name, lastname, mail, randomstr, hash) values (?, ?, ?, ?, ?, ?, ?)', [ id, username, name, lastname, mail, randomstr, hash], (error, rows, fields) => {
        if(!error) {
            res.json({Status : "User saved"})
        } else {
            console.log(error);
        }
    });
})

router.put('/:users/:id', (req, res) => {
    const { id, username, name, lastname, mail, randomstr, hash } = req.body;
    console.log(req.body);
    mysqlConnection.query('update user set username = ?, name = ?, lastname = ?, mail = ?, randomstr = ?, hash = ? where id = ?;', 
    [username, name, lastname, mail, randomstr, hash, id], (error, rows, fields) => {
        if(!error){
            res.json({
                Status: 'User updated'
            });
        } else {
            console.log(error);
        }
    });
});

router.delete('/:users/:id', (req,res) => {
    const { id } = req.params;
    mysqlConnection.query('delete from user where id = ?', [id], (error, rows, fields) => {
        if(!error){
            res.json({
                Status: "User deleted"
            });
        } else {
            res.json({
                Status: error
            });
        }
    })
});

module.exports = router;

// [{
// 	"id":1,
//     "username": "Veterano23",
//     "name": "Jesus",
//     "lastname": "Hedo",
//     "mail": "hedo.jesus@gmail.com",
//     "randomstr": "dsDsfj=·",
//     "hash": "sdfjioi93448rfj7"
// },
// {
// 	"id":2,
//     "username": "Xavito95",
//     "name": "Xavi",
//     "lastname": "Castro",
//     "mail": "xc@gmail.com",
//     "randomstr": "gHf08vf^",
//     "hash": "1sr6p5ly´c,wzh6/"
// }]
