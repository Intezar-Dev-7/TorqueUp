import express from "express";
import NewInventoryBooking from "../models/inventoryModel.js";

const productRouter = express.Router();


productRouter.post('/api/addNewProduct', async (req, res) => {
    try {
        // read data from the client (req.body) 
        const { productName, productQuantity, productPrice, productStatus, productImageBase64 } = req.body;

        const addProduct = NewInventoryBooking({
            productName, productQuantity, productPrice, productStatus, productImageBase64,
        });

        await addProduct.save();
        // 201 Created → New resource created successfully (usually after POST).
        res.status(201).json(addProduct);
        console.log(addProduct);

    } catch (error) {
        console.error(error);
        res.status(500).json({ message: 'Server error' });
    }
});

productRouter.get('/api/getProducts', async (req, res) => {
    try {
        const products = await NewInventoryBooking.find({}).sort({ createdAt: -1 });
        console.log('All Products:', products);
        res.json(products);
    } catch (error) {
        console.error(error);
        res.status(500).json({ message: 'Server error' });
    }
});


productRouter.delete('/api/deleteProduct/:id', async (req, res) => {
    try {
        const { id } = req.params;

        const deleteProduct = await NewInventoryBooking.findByIdAndDelete(id);
        if (!deleteProduct) {
            return res.status(404).json({ message: "Booking not found" });
        }
        res.status(200).json({ message: "Booking has been deleted successfully" });

    } catch (error) {
        console.error(error);
        res.status(500).json({ message: 'Server error' });
    }
});



export default productRouter;