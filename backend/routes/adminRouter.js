import express from 'express';

const adminRouter = expess.Router();

adminRouter.get('/logout', (req, res) => {

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




// ✅ Export the router
export default adminRouter;