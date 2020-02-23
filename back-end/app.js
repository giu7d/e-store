const express = require('express');
const helmet = require('helmet');
const bodyParser = require('body-parser');
const query = require('./query');
const mysql = require('mysql');

const app = express();

app.use(function (req, res, next) {
    res.header("Access-Control-Allow-Origin", "*");
    res.header("Access-Control-Allow-Methods", "GET, PUT, POST, DELETE");
    res.header("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept");
    next();
});

app.use(helmet());

app.use(bodyParser.urlencoded({
    extended: true
}));
app.use(bodyParser.json());


const port = process.env.port || 3000;

const con = mysql.createConnection({
    host: "localhost",
    user: "root",
    password: "",
    database: "store_db"
});



// Category
app.get('/category', (req, res) => {
    query.doQuery('SELECT cat_codigo, cat_descricao FROM tb_categoria', res, con);
});

app.get('/category/:id?', (req, res) => {
    let filter = '';
    if (req.params.id) filter = ' WHERE cat_codigo =' + parseInt(req.params.id);
    query.doQuery('SELECT * FROM tb_categoria' + filter, res, con);
});

app.post('/category', (req, res) => {
    const desc = req.body.cat_descricao;
    query.doQuery(`INSERT INTO tb_categoria (cat_descricao) VALUES('${desc}')`, res, con);
});

app.patch('/category/:id', (req, res) => {
    const id = parseInt(req.body.cat_codigo);
    const desc = req.body.cat_descricao;
    query.doQuery(`UPDATE tb_categoria SET cat_descricao='${desc}' WHERE cat_codigo='${id}'`, res, con)
});

app.delete('/category/:id', (req, res) => {
    let filter = '';
    filter = ' WHERE cat_codigo =' + parseInt(req.params.id);
    query.doQuery('DELETE FROM tb_categoria' + filter, res, con);
});


// Marca
app.get('/brand', (req, res) => {
    query.doQuery('SELECT * FROM tb_marca', res, con);
});

app.get('/brand/:id?', (req, res) => {
    let filter = '';
    if (req.params.id) filter = ' WHERE mar_codigo =' + parseInt(req.params.id);
    query.doQuery('SELECT * FROM tb_marca' + filter, res, con);
});

app.post('/brand', (req, res) => {
    const desc = req.body.mar_descricao;
    query.doQuery(`INSERT INTO tb_marca (mar_descricao) VALUES('${desc}')`, res, con);
});

app.patch('/brand/:id', (req, res) => {
    const id = parseInt(req.param.id);
    const desc = req.body.mar_descricao;
    query.doQuery(`UPDATE tb_marca SET mar_descricao='${desc}' WHERE mar_codigo='${id}'`, res, con)
});

app.delete('/brand/:id', (req, res) => {

    let filter = '';
    filter = ' WHERE mar_codigo =' + parseInt(req.params.id);

    query.doQuery('DELETE FROM tb_marca' + filter, res, con);
});



// Product

app.get('/product', (req, res) => {
    query.doQuery(`

        SELECT pro_codigo, pro_descricao, pro_valor, pro_quantidade, mar_descricao, cat_descricao FROM tb_produto
            JOIN tb_marcaproduto ON tb_marcaproduto.marpro_codproduto = tb_produto.pro_codigo
            JOIN tb_categoriaproduto ON tb_categoriaproduto.catpro_codproduto = tb_produto.pro_codigo
            JOIN tb_marca ON tb_marca.mar_codigo = tb_marcaproduto.marpro_codmarca
            JOIN tb_categoria ON tb_categoria.cat_codigo = tb_categoriaproduto.catpro_codcategoria

    `, res, con);
});

app.get('/product/:id?', (req, res) => {
    let filter = '';
    if (req.params.id) filter = ' WHERE pro_codigo =' + parseInt(req.params.id);
    query.doQuery(`

        SELECT pro_codigo, pro_descricao, pro_valor, pro_quantidade, mar_descricao, cat_descricao FROM tb_produto
            JOIN tb_marcaproduto ON tb_marcaproduto.marpro_codproduto = tb_produto.pro_codigo
            JOIN tb_categoriaproduto ON tb_categoriaproduto.catpro_codproduto = tb_produto.pro_codigo
            JOIN tb_marca ON tb_marca.mar_codigo = tb_marcaproduto.marpro_codmarca
            JOIN tb_categoria ON tb_categoria.cat_codigo = tb_categoriaproduto.catpro_codcategoria

    ` + filter, res, con);
});



app.post('/product', (req, res) => {

    const pro_descricao = req.body.pro_descricao;
    const mar_codigo = req.body.mar_codigo;
    const cat_codigo = req.body.cat_codigo;
    const pro_quantidade = req.body.pro_quantidade;
    const pro_valor = req.body.pro_valor;

    query.doQuery(`CALL pcd_adicionarProduto('${pro_descricao}','${mar_codigo}','${cat_codigo}','${pro_quantidade}','${pro_valor}',)`, res, con);
});


app.listen(port, () => {
    console.log(`Listening on port ${port}...`);
});