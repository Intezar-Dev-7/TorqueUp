import mongoose from "mongoose";


const newVehicleBookingSchema = new mongoose.Schema({

    customerName: {
        type: String,
        requried: true,
    },
    vehicleNumber: {
        type: String,
        requried: true,
    },
    problem: {
        type: String,
        requried: true,
    },
    vehicleBookingStatus: {
        type: String,
        required: true,
    },
    bookedDate: {
        type: Date,
        requried: true,
    }
    ,
    readyDate: {
        type: Date,
        requried: true,
    },

});

const NewBooking = mongoose.model('NewBooking', newVehicleBookingSchema);
export default NewBooking;