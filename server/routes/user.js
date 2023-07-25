const express=require('express');
const auth = require('../middlewares/auth');
const { Product } = require('../models/product');
const user = require('../models/user');
const userrouter=express.Router();

userrouter.post('/api/add-to-cart',auth, async (req,res)=>{
  
    try{
     const {id}=req.body;
     const product=await Product.findById(id);
     let User=await user.findById(req.user);
     if(User.cart.length==0){
      User.cart.push({product,quantity: 1});


     }else{
        let isproductfound=false;
      for(let i=0;i<User.cart.length;i++){
        if(User.cart[i].product._id.equals(product._id)){
              isproductfound=true;
        }


      }

      if(isproductfound){
        let producttt=User.cart.find((productt)=>
        productt.product._id.equals(product._id)
        );
        
        producttt.quantity+=1;

      }else{
        User.cart.push({product,quantity: 1});
      }

     }
     User=await User.save();
     res.json(User);
      
        
    }catch(e){
    res.status(500).json({error: e.message});
    
    }
    
    
    });

    module.exports=userrouter;