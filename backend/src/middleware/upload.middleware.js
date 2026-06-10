const multer = require("multer");
const path = require("path");

// Gunakan memoryStorage agar file disimpan di buffer RAM,
// lalu langsung di-stream ke Cloudinary tanpa menyentuh disk
const storage = multer.memoryStorage();

const fileFilter = (req, file, cb) => {
    const allowed = /jpg|jpeg|png|webp/;

    const isValidExt = allowed.test(
        path.extname(file.originalname).toLowerCase()
    );

    const isValidMime = allowed.test(file.mimetype.split("/")[1]);

    if (isValidExt && isValidMime) {
        cb(null, true);
    } else {
        cb(
            new Error("Format file harus jpg, jpeg, png, atau webp"),
            false
        );
    }
};

module.exports = multer({
    storage,
    fileFilter,
    limits: {
        fileSize: 5 * 1024 * 1024, // Maks 5MB
    },
});
