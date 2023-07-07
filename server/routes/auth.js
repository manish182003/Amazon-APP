const express=require('express');
const user = require('../models/user');
const bcryptjs=require('bcrypt');

const authrouter=express.Router();

//sign up 
authrouter.post('/api/signup', async (req,res)=>{
    try{
        const {name,email,password}= req.body;

        const existinguser= await user.findOne({ email });
        const smallpassword=await user.findOne({password});
        if(existinguser){
            return res.status(400).json({msg:'User with same email already exists!'});
        }
        if(smallpassword){
            return res.status(400).json({msg:'Password is less then 6 characters'});
        }
     const hashedpassword = await  bcryptjs.hash(password,8);
        
        let User=new user({
          email,
          password:hashedpassword,
          name
        
        })
        User=await User.save();
        res.json({User});
        
        
        
    } catch(e){
        res.status(500).json({error: e.message});
    }
  

});



module.exports=authrouter;