const pg = require('pg');
const config = require('../db_config');
const client = new pg.Pool(config.config);
const twilio = require('twilio');
const twilioClient = new twilio(process.env.TWILIO_ACCOUNT_SID, process.env.TWILIO_AUTH_TOKEN);

// const client = new pg.Client(config.string);
// client.connect();

module.exports.login = async function(req, res, next) {
    
    // var service = await twilioClient.verify.services.create({friendlyName: 'Sprinty', codeLength: 4});
    var response = await twilioClient.verify.services(process.env.TWILIO_SERVICE_SID).verifications.create({to: process.env.PHONE, channel: 'sms'});

    res.send({
        data: {
            name: 'Idoko Agbo',
            username: 'test',
            // services: service,
            response: response
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
    client.query('SELECT * FROM users ORDER BY id ASC ',(error, results) => {

        if(error){
            throw error;
        }


        res.status(200).json(results.rows);
    });
}

module.exports.getUserById = function(req, res, next) {

    const id = parseInt(req.params.id);
    
    client.query('SELECT * FROM users WHERE id =$1', [id], (error, results)=> {
        if(error){
            throw error;
        }

        res.status(200).json(results.rows);
    })
}

module.exports.createUser = function(req, res, next){
    const name = req.body.name;
    const email = req.body.email;

    client.query('INSERT INTO users (name, email) VALUES ($1, $2)', [name, email], (error, result) => {
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

    client.query('UPDATE users SET name = $1, email = $2 WHERE id = $3', [name, email, id], (error, results)=>{
        if(error){
            throw error;
        }

        res.status(200).send(`user modified with ID: ${id}`);
    })
}

module.exports.deleteUser = function(req, res, next){
    const id = req.params.id;

    client.query('DELETE FROM users WHERE id = $1', [id], (error, results) => {
        if(error){
            throw error;
        }

        res.status(200).send(`user deleted with ID: ${id}`);
    });
}
