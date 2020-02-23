const doQuery = (query, res, con) => {

    con.query(query, (err, result) => {
        if (err) {
            res.json(err);
        } else {
            res.json(result);
        }
    });
}

exports.doQuery = doQuery;