import express from 'express';
import NewBooking from '../models/newVehicleBookingModel.js';
import NewStaff from '../models/staffModel.js';


const receptionistRouter = express.Router();

receptionistRouter.post('/api/newBooking', async (req, res) => {
    try {
        // Read data from the client (req.body)
        const { customerName, vehicleNumber, customerContactNumber, problem, vehicleBookingStatus, bookedDate, readyDate } = req.body;
        // Validate the data
        if (!customerName || !vehicleNumber || !customerContactNumber || !problem || !vehicleBookingStatus || !bookedDate || !readyDate) {
            return res.status(400).json({ message: 'All fields are requied' });
        }
        // Save it to your database (MongoDB via Mongoose)
        const newBooking = NewBooking({
            customerName,
            vehicleNumber,
            customerContactNumber,
            problem,
            vehicleBookingStatus,
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

        res.status(200).json({ message: "Booking has been deleted successfully" });
    } catch (error) {
        console.error(error);
        res.status(500).json({ message: "Server error", error });
    }

});


/* Routes to Add, fetch, Update and Delete Staff Members */
receptionistRouter.post('/api/addStaff', async (req, res) => {
    try {
        const {
            staffName,
            staffRole,
            staffExperience,
            staffContactNumber,
            staffEmail,
            about,
            skills
        } = req.body;

        // Validate required fields
        if (!staffName || !staffRole || !staffExperience || !staffContactNumber) {
            return res.status(400).json({ message: 'staffName, staffRole, staffExperience and staffContactNumber are required' });
        }

        const newStaff = NewStaff({
            staffName,
            staffRole,
            staffExperience,
            staffContactNumber,
            staffEmail: staffEmail || '',  // optional
            about: about || '',            // optional
            skills: Array.isArray(skills) ? skills : [] // ensure skills is an array
        });

        await newStaff.save();
        return res.status(201).json({ message: "Staff added successfully", staff: newStaff });
    } catch (error) {
        console.error(error);
        return res.status(500).json({ error: "Server error" });
    }
});

receptionistRouter.get('/api/getStaffByRole', async (req, res) => {
    try {
        const staffRole = req.query.staffRole;
        console.log("Requested role:", staffRole);

        let staffList = [];
        if (staffRole === 'otherEmployee') {
            staffList = await NewStaff.find({
                staffRole: { $in: ['Accountant', 'Cleaner', 'Supervisor'] },
            });
        } else {
            staffList = await NewStaff.find({ staffRole });
        }

        if (staffList.length === 0) {
            console.log(`No staff found for role: ${staffRole}`);
            return res.status(200).json([]);
        }

        res.status(200).json(staffList);
        console.log(`Found ${staffList.length} staff for role: ${staffRole}`);
    } catch (error) {
        console.error("Error in getStaffByRole:", error);
        res.status(500).json({ error: "Server Error" });
    }
});

receptionistRouter.delete('/api/deleteEmployee/:id', async (req, res) => {
    try {
        const { id } = req.params;
        const deleteEmployee = await NewStaff.findByIdAndDelete(id);

        if (!deleteEmployee) {
            return res.status(404).json({ message: "Employee not found" });
        }

        res.status(200).json({ message: "Employee has been deleted successfully" });
    } catch (error) {
        console.error(error);
        res.status(500).json({ message: "Server error", error });
    }
});

export default receptionistRouter;