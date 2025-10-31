
import mongoose from 'mongoose';
import bcrypt from 'bcryptjs'; // ✅ import bcryptjs

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
            validator: (value) => /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(value),
            message: 'Please enter a valid email address!',
        },
    },
    password: {
        type: String,
        required: true,
        validate: {
            validator: (value) => value.length > 6,
            message: 'Password must be at least 6 characters long!',
        },
    },
    role: {
        type: String,
        required: true,
        default: "",
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


// ✅ Hash password automatically before saving (only if modified)
userSchema.pre('save', async function (next) {
    if (!this.isModified('password')) return next(); // only hash if changed
    this.password = await bcrypt.hash(this.password, 10);
    next();
});


// ✅ Add comparePassword method for easy login/password-change checks
userSchema.methods.comparePassword = async function (enteredPassword) {
    return await bcrypt.compare(enteredPassword, this.password);
};


// ✅ Create the model
const User = mongoose.model('User', userSchema);
export default User;
