
import User from '../models/userModel.js';
import StatusCodes from 'http-status-codes';
import { NotFoundError, UnauthenticatedError } from '../errors/index.js';
import auth from '../middlewares/auth.js';
const adminRouter = expess.Router();

adminRouter.get('/adminLogout', (req, res) => {

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
    const { oldPassword, newPassword } = req.body;
    const userId = req.user.userId;

    const user = await User.findById(userId);
    if (!user) {
        throw new NotFoundError("User not found");
    }

    const isPasswordCorrect = await user.comparePassword(oldPassword);
    if (!isPasswordCorrect) {
        throw new UnauthenticatedError('Invalid Credentials');
    }
    user.password = newPassword;
    await user.save();

    res.status(StatusCodes.OK).json({ msg: 'Password changed successfully' });
});




// ✅ Export the router
export default adminRouter;