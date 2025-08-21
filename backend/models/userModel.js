import mongoose from 'mongoose';

const userSchema = new mongoose.Schema({
    name: {
        type: String,
        required: true,
    },
    email: {
        type: String,
        required: true,
        unique: true,
        validate: {
            validator: (value) => {
                const re = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                return re.test(value);
            },
            message: 'Please enter a valid email address!',
        }
    },
    password: {
        type: String,
        required: true,
        validate: {
            validator: (value) => {
                return value.length > 6;
            },
            message: 'Password must be atleast 6 characters long !!',
        }

    },
    role: {
        type: String,
        required: true,
        default: ""
    },
    address: {
        type: String,
        default: "",
    },
    createdAt: {
        type: Date,
        default: Date.now,
    },

});


// Create the User model from the schema
const User = mongoose.model('User', userSchema);
export default User; // ✅ Use ESM export