
import express from 'express';
import mongoose from 'mongoose';
import dotenv from 'dotenv';
import cors from 'cors';

//  Initialization 
const app = express();


dotenv.config();

// Allow requests from anywhere (dev mode)
app.use(cors({
    origin: ["https://tourqueup.netlify.app/"],  // ✅ your frontend domain
    methods: ["GET", "POST", "PUT", "DELETE"],
    credentials: true,
}));
// import from other files 

import authRouter from "./routes/authRouter.js";
import receptionistRouter from './routes/receptionistRouter.js';
import productRouter from './routes/productRouter.js';
import adminRouter from './routes/adminRouter.js';


// Middleware to parse JSON
app.use(express.json());


// For JSON payloads
app.use(express.json({ limit: '50mb' }));
// For URL-encoded payloads
app.use(express.urlencoded({ limit: '50mb', extended: true }));

// Middleware
app.use(authRouter);
app.use(receptionistRouter);
app.use(productRouter);
app.use(adminRouter)

const DBURL = process.env.MONGO_URI;


// Connections 
mongoose.connect(DBURL).then(() => {
    console.log('Connection Successull');
}).catch((e) => {
    console.log(e);
});

app.listen(process.env.PORT, '0.0.0.0', () => {
    console.log('Connected');
}
);