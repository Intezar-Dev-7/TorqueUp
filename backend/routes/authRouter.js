import bcryptjs from 'bcryptjs';
import jwt from 'jsonwebtoken';
import expess from 'express';

import User from '../models/userModel.js';
import auth from '../middlewares/auth.js';


const authRouter = expess.Router();
// Api Routes 

//  Signup routes 
authRouter.post('/api/signup', async (req, res) => {
    try {
        const { name, email, password, role } = req.body;
        const existingUser = await User.findOne({ email });

        if (existingUser) {
            return res.status(400).json({ msg: "User with the same email already exists!!" });
        }
        const hashedPassword = await bcryptjs.hash(password, 8);
        var user = new User({ name, email, password: hashedPassword, role });
        user = await user.save();
        res.json(user);


    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});


authRouter.post('/api/signin', async (req, res) => {
    try {
        const { email, password, role } = req.body;
        const user = await User.findOne({ email });

        if (!user) {
            return res.status(400).json({ error: "User with this email address , does not exists" });

        }
        if (role && user.role !== role) {
            return res.status(400).json({ error: "Role mismatch" });
        }

        const isMatch = await bcryptjs.compare(password, user.password);
        if (!isMatch) {
            return res.status(400).json({ msg: "Incorrect Password" });
        }

        const token = jwt.sign({ id: user._id }, process.env.JWT_SECRET, { expiresIn: '1h' });
        // console.log('Success');
        res.status(200).json({
            success: true,
            token,
            user: { ...user._doc }
        });
    } catch (e) {
        res.status(500).json({ success: false, error: e.message })
    }

});


// Api to check if token is valid or not 
authRouter.post('/tokenIsValid', async (req, res) => {
    try {
        const token = req.header('x-auth-token');
        console.log("Token received:", token);
        if (!token) return res.json(false);

        let verified;
        try {
            verified = jwt.verify(token, process.env.JWT_SECRET);
        } catch (err) {
            return res.json(false);
        }

        console.log("Verified payload:", verified);

        const user = await User.findById(verified.id);
        console.log("User found:", user);
        if (!user) return res.json(false);

        res.json(true);

    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});


// Api to get the user data 
authRouter.get("/", auth, async (req, res) => {
    const user = await User.findById(req.user);
    res.json({ ...user._doc, token: req.token });
});

// ✅ Export the router
export default authRouter;