import express from 'express';
import NewBooking from '../models/newBookingModel.js';

const receptionistRouter = express.Router();

receptionistRouter.post('/api/newBooking', async (req, res) => {
    try {
        // Read data from the client (req.body)
        const { customerName, vehicleNumber, problem, status, bookedDate, readyDate } = req.body;
        // Validate the data
        if (!customerName || !vehicleNumber || !problem || !status || !bookedDate || !readyDate) {
            return res.status(400).json({ message: 'All fields are requied' });
        }
        // Save it to your database (MongoDB via Mongoose)
        const newBooking = NewBooking({
            customerName,
            vehicleNumber,
            problem,
            status,
            bookedDate,
            readyDate,
        });
        await newBooking.save();

        // Send a response (res.send() / res.json() / res.status())
        // 201 Created → New resource created successfully (usually after POST).
        res.status(201).json(newBooking);

    } catch (error) {
        console.error(error);
        res.status(500).json({ message: 'Server error' });
    }


});

receptionistRouter.get('/api/getBookings', async (req, res) => {
    try {
        const bookings = await NewBooking.find({}).sort({ createdAt: -1 });
        console.log(bookings);
        res.json(bookings);

    } catch (e) {
        res.status(500).json({ error: e.message });
    }

});


export default receptionistRouter;