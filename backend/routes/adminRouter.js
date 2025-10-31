
import User from '../models/userModel.js';
import auth from '../middlewares/auth.js';
import express from 'express';
const adminRouter = express.Router();

adminRouter.get('/api/adminLogout', (req, res, next) => {

    if (req.session) {
        req.session.destroy(function (err) {
            if (err) {
                return next(err);
            } else {
                return res.redirect('/');
            }
        });
    } else {
        // No session to destroy, still redirect
        res.redirect('/');
    }
});


adminRouter.patch('/api/changeAdminPassword', auth, async (req, res) => {
    try {
        const { oldPassword, newPassword } = req.body;
        const userId = req.user.userId || req.user.id;

        const user = await User.findById(userId);
        if (!user) {
            return res.status(404).json({ msg: 'User not found' });
        }

        const isPasswordCorrect = await user.comparePassword(oldPassword);
        if (!isPasswordCorrect) {
            return res.status(401).json({ msg: 'Invalid credentials' });
        }

        user.password = newPassword;
        await user.save();

        res.status(200).json({ msg: 'Password changed successfully' });
    } catch (error) {
        console.error('Error changing password:', error);
        res.status(500).json({ msg: 'Internal server error' });
    }
});



// ✅ Export the router
export default adminRouter;