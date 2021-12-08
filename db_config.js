module.exports.config = {
    host: process.env.DB_HOST,
    database: process.env.POSTGRES_DB,
    user: process.env.POSTGRES_USER,
    password: process.env.POSTGRES_PASSWORD,
    port: process.env.DB_PORT,
};

module.exports.string = `postgres://${process.env.POSTGRES_USER}:${process.env.POSTGRES_USER}@${process.env.DB_HOST}:${process.env.DB_PORT}/${process.env.POSTGRES_DB}`;