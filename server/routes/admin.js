const Product = require('../models/product');

const express=require('express');
const adminrouter=express.Router();
const admin=require('../middlewares/admin')
// add product
adminrouter.post('/admin/add-product',admin, async (req,res)=>{
  
try{
 const { name,description,images,quantity,price,category } = req.body;
 let product= new Product({
    name,
    description,
    
    quantity,
    images,
    
    category,
    price
 });
 product=await product.save();
 res.json(product);
    
}catch(e){
res.status(500).json({error: e.message});

}


})
module.exports=adminrouter;