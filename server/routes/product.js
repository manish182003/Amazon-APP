const express=require('express');
const auth = require('../middlewares/auth');
const productrouter=express.Router();

productrouter.get('/api/products',auth,async (req,res)=>{

    try{
     const products= await Product.find({});
     res.json(products);
    }catch(e){
       res.status(500).json({error: e.message});
    }
 
 
 
 });


module.exports=productrouter;