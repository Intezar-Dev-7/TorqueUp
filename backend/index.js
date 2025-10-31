

import dotenv from 'dotenv';
dotenv.config();
import express from 'express';
import mongoose from 'mongoose';
import cors from 'cors';

//  Initialization
const app = express();

//
app.use(
    cors({
        origin: "https://tourqueup.netlify.app", // ✅ your actual frontend domain
        methods: ["GET", "POST", "PUT", "PATCH", "DELETE"],
        allowedHeaders: ['Content-Type', 'Authorization'], // <-- allow Authorization header
        credentials: true,
    })
);


// After (valid route pattern with named wildcard)
app.options("/*splat", cors());

// For JSON payloads
app.use(express.json({ limit: '50mb' }));
// For URL-encoded payloads
app.use(express.urlencoded({ limit: '50mb', extended: true }));

// import from other files

import authRouter from "./routes/authRouter.js";
import receptionistRouter from './routes/receptionistRouter.js';
import productRouter from './routes/productRouter.js';
import adminRouter from './routes/adminRouter.js';


// Middleware
app.use(authRouter);
app.use(receptionistRouter);
app.use(productRouter);
app.use(adminRouter);

// console.log(listEndpoints(app));
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

