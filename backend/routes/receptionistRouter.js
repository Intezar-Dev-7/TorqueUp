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



receptionistRouter.patch('/api/updateBooking/:id', async (req, res) => {
    try {
        const { id } = req.params; // MongoDB ObjectId
        const updates = req.body;
        const booking = await NewBooking.findByIdAndUpdate(id, updates, { new: true });
        if (!booking) {
            return res.status(404).json({ message: 'Booking not found' });
        }

        // return res.status(400).json({ message: "Invalid booking id" });

        res.json(booking);


    } catch (error) {
        console.error(error);
        res.status(500).json({ message: "Server error", error });
    }
});


/*Route = a single endpoint (like a single door).
API = a structured set of routes working together (like the whole building with many doors).*/
receptionistRouter.delete('/api/deleteBooking/:id', async (req, res) => {
    try {
        const { id } = req.params;

        const deletedBooking = await NewBooking.findByIdAndDelete(id);

        if (!deletedBooking) {
            return res.status(404).json({ message: "Booking not found" });
        }
        console.log("It reached here ");
        res.status(200).json({ message: "Booking has been deleted successfully" });
    } catch (error) {
        console.error(error);
        res.status(500).json({ message: "Server error", error });
    }
});


export default receptionistRouter;