import jwt from 'jsonwebtoken';
import express from 'express';
import User from '../models/userModel.js';
import auth from '../middlewares/auth.js';
const authRouter = express.Router();
// Signup route 
authRouter.post('/api/signup', async (req, res) => {
    try {
        // Use .trim() to prevent hidden whitespace bugs
        const email = req.body.email.trim();
        const password = req.body.password.trim();
        const name = req.body.name.trim();
        const role = req.body.role;

        const existingUser = await User.findOne({ email });

        if (existingUser) {
            return res.status(400).json({ msg: "User with the same email already exists!!" });
        }

        // ✅ PASS THE PLAIN TEXT PASSWORD! 
        // The Mongoose pre('save') hook will hash it for us automatically.
        var user = new User({ name, email, password, role });
        user = await user.save();

        res.status(201).json(user);

    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});


// Signin route
authRouter.post('/api/signin', async (req, res) => {
    try {
        const email = req.body.email.trim();
        const password = req.body.password.trim();
        const role = req.body.role;

        const user = await User.findOne({ email });
        console.log("Email:", email);
        console.log("Password entered:", `"${password}"`);
        console.log("Password length:", password?.length);
        console.log("User found:", user?.email);
        if (!user) {
            return res.status(400).json({ error: "User with this email address does not exist" });
        }
        if (role && user.role !== role) {
            return res.status(400).json({ error: "Role mismatch" });
        }

        // ✅ USE THE HELPER METHOD YOU CREATED IN userModel.js!
        const isMatch = await user.comparePassword(password);

        if (!isMatch) {
            return res.status(400).json({ msg: "Incorrect Password" });
        }

        const token = jwt.sign({ id: user._id }, process.env.JWT_SECRET, { expiresIn: '1h' });

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
        if (!token) return res.json(false);

        let verified;
        try {
            verified = jwt.verify(token, process.env.JWT_SECRET);
        } catch (err) {
            return res.json(false);
        }

        const user = await User.findById(verified.id);
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

export default authRouter;