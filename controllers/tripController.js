const pg = require('pg');
const config = require('../db_config');
const client = new pg.Pool(config.config);

// const client = new pg.Client(config.string);
// client.connect();

module.exports.getTrips = function(req, res, next){
    client.query('SELECT * FROM trips', (error, results) => {
        if(error){
            throw error;
        }

        res.status(200).json(results.rows);
    });
}

module.exports.create = function(req, res, next){
    var userId = req.body.userId;
    var origin = req.body.origin;
    var destination = req.body.destination;

    client.query('INSERT INTO trips (user_id, origin, destination) VALUES ($1, $2, $3)', [userId, origin, destination], (error, results)=> {
        if(error){
            throw error;
        }

        res.status(201).send('Trip created');
    });
}