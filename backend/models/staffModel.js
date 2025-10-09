
import mongoose from "mongoose";

const NewStaffSchema = new mongoose.Schema(
    {
        staffName: {
            type: String,
            required: true,
            trim: true,
        },
        staffRole: {
            type: String,
            required: true,
            trim: true,
        },
        staffExperience: {
            type: String,
            required: true,
            trim: true,
        },
        staffContactNumber: {
            type: String,
            required: true,
            trim: true,
        },
        staffEmail: {
            type: String,
            trim: true,
            default: "",
        },
        about: {
            type: String,
            trim: true,
            default: "",
        },
        skills: {
            type: [String], // array of strings
            default: [],
        },
    },
    {
        timestamps: true, // automatically adds createdAt & updatedAt
    }
);

const NewStaff = mongoose.model("NewStaff", NewStaffSchema);

export default NewStaff;

/*
Explanation:
- staffEmail, about → optional string fields with default empty values
- skills → an array of strings for storing multiple skills
- timestamps → automatically adds createdAt and updatedAt fields
- The schema now fully aligns with the updated Flutter form and Staff model
*/
