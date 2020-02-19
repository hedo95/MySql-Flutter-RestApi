const { Router } = require('express');
const router = Router();

const mysqlConnection = require('../database');

router.get('/', (req, res) => {
    res.status(200).json('Server on port 4000 and Database is connected.');
});

router.get('/:customers', (req, res) => {
    mysqlConnection.query('select * from customer', (error, rows, fields) => {
        if(!error) {
            res.json(rows);
        } else {
            console.log(error);
        }
    });
});

// This function allows us concatenate 'id' to url => localhost:4000/id
router.get('/:customers/:id', (req, res) => {
    const { id } = req.params;
    mysqlConnection.query('select * from customer where id = ?', [id], (error, rows, fields) => {
        if(!error) {
            res.json(rows);
        } else {
            console.log(error);
        }
    })
});

router.post('/:customers', (req, res) => {
    const { username, name, lastname, mail, password } = req.body;
    console.log(req.body);
    mysqlConnection.query('insert into customer(username, name, lastname, mail, password) values (?, ?, ?, ?, ?)', [ username, name, lastname, mail, password], (error, rows, fields) => {
        if(!error) {
            res.json({
                Status: 'Customer saved'
            });
        } else {
            console.log(error);
        }
    });
})

router.put('/:customers/:id', (req, res) => {
    const { id, username, name, lastname, mail, password } = req.body;
    console.log(req.body);
    mysqlConnection.query('update customer set username = ?, name = ?, lastname = ?, mail = ?, password = ? where id = ?', 
    [username, name, lastname, mail, password, id], (error, rows, fields) => {
        if(!error){
            res.json({
                Status: 'Customer updated'
            });
        } else {
            console.log(error);
        }
    });
});

router.delete('/:customers/:id', (req,res) => {
    const { id } = req.params;
    mysqlConnection.query('delete from customer where id = ?', [id], (error, rows, fields) => {
        if(!error){
            res.json({
                Status: "Customer deleted"
            });
        } else {
            res.json({
                Status: error
            });
        }
    })
});

module.exports = router;