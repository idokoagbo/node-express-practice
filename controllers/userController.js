const Pool = require('pg').Pool;
const config = require('../db_config');
const pool = new Pool(config);

module.exports.login = function(req, res, next) {
    res.send({
        data: {
            name: 'Idoko Agbo',
            username: 'test'
        }
    });
};

module.exports.register = function(req, res, next){
    res.send({
        data: {
            name: 'Idoko Agbo',
            username: 'test'
        }
    });
};

// database tutorial functions

module.exports.getUsers = function(req, res, next){
    pool.query('SELECT * FROM users ORDER BY id ASC ',(error, results) => {

        if(error){
            throw error;
        }


        res.status(200).json(results.rows);
    });
}

module.exports.getUserById = function(req, res, next) {

    const id = parseInt(req.params.id);
    
    pool.query('SELECT * FROM users WHERE id =$1', [id], (error, results)=> {
        if(error){
            throw error;
        }

        res.status(200).json(results.rows);
    })
}

module.exports.createUser = function(req, res, next){
    const name = req.body.name;
    const email = req.body.email;

    pool.query('INSERT INTO users (name, email) VALUES ($1, $2)', [name, email], (error, result) => {
        if (error){
            throw error;
        }

        res.status(201).send(`user inserted with ID ${result.rows[0].id}`);
    });
}

module.exports.updateUser = function(req, res, next){

    const id = req.params.id;

    const name = req.body.name;
    const email = req.body.email;

    pool.query('UPDATE users SET name = $1, email = $2 WHERE id = $3', [name, email, id], (error, results)=>{
        if(error){
            throw error;
        }

        res.status(200).send(`user modified with ID: ${id}`);
    })
}

module.exports.deleteUser = function(req, res, next){
    const id = req.params.id;

    pool.query('DELETE FROM users WHERE id = $1', [id], (error, results) => {
        if(error){
            throw error;
        }

        res.status(200).send(`user deleted with ID: ${id}`);
    });
}