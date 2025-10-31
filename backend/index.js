
// import listEndpoints from 'express-list-endpoints';
import express from 'express';
import mongoose from 'mongoose';
import dotenv from 'dotenv';
import cors from 'cors';

//  Initialization
const app = express();

//
app.use(
    cors({
        origin: ["https://tourqueup.netlify.app"], // ✅ your actual frontend domain
        methods: ["GET", "POST", "PUT", "PATCH", "DELETE"],
        credentials: true,
    })
);

// // ✅ Add this right below it to handle preflight OPTIONS requests
// app.options("*", cors());

// After (valid route pattern with named wildcard)
app.options("/*splat", cors());
// import from other files

dotenv.config();
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

