import mongoose from "mongoose";

const newInventoryBookingSchema = new mongoose.Schema({

    productName: {
        type: String,
        required: true,
    },

    productQuantity: {
        type: Number,
        required: true,
    },

    productPrice: {
        type: Number,
        required: true,
    },

    /// Status of the product (e.g., 'In Stock', 'Low Stock', 'Out of Stock').
    productStatus: {
        type: String,
        required: true,
    },
    productImageBase64: {
        type: String, // stores image as Base64
        required: true,
    },

});

const NewInventoryBooking = mongoose.model(
    "NewInventoryBooking",
    newInventoryBookingSchema
);

export default NewInventoryBooking;

/*
mongoose.model() = creates a link between schema and MongoDB collection.
NewInventoryBooking = the class you use in code to interact with that collection.
export default = allows you to import and use it anywhere else in your app.
*/