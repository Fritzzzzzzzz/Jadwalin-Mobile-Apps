const cloudinary = require("cloudinary").v2;

cloudinary.config({
    cloud_name: process.env.CLOUDINARY_CLOUD_NAME,
    api_key: process.env.CLOUDINARY_API_KEY,
    api_secret: process.env.CLOUDINARY_API_SECRET,
});

/**
 * Upload buffer gambar ke Cloudinary
 * @param {Buffer} buffer - Buffer file gambar dari multer memoryStorage
 * @param {string} folder - Folder tujuan di Cloudinary
 * @returns {Promise<{url: string, publicId: string}>}
 */
const uploadToCloudinary = (buffer, folder = "jadwalin/profile-photos") => {
    return new Promise((resolve, reject) => {
        const uploadStream = cloudinary.uploader.upload_stream(
            {
                folder,
                resource_type: "image",
                // Auto-format & auto-quality untuk hemat bandwidth
                transformation: [
                    { width: 500, height: 500, crop: "limit" },
                    { quality: "auto", fetch_format: "auto" },
                ],
            },
            (error, result) => {
                if (error) {
                    reject(error);
                } else {
                    resolve({
                        url: result.secure_url,
                        publicId: result.public_id,
                    });
                }
            }
        );

        uploadStream.end(buffer);
    });
};

/**
 * Hapus gambar dari Cloudinary berdasarkan public_id
 * @param {string} publicId - Public ID gambar di Cloudinary
 * @returns {Promise<void>}
 */
const deleteFromCloudinary = async (publicId) => {
    if (!publicId) return;

    try {
        await cloudinary.uploader.destroy(publicId);
    } catch (error) {
        // Log tapi jangan lempar error — hapus foto lama bukan operasi kritis
        console.error("Gagal hapus foto lama dari Cloudinary:", error.message);
    }
};

/**
 * Ekstrak public_id dari URL Cloudinary
 * Contoh URL: https://res.cloudinary.com/cloud_name/image/upload/v123/jadwalin/profile-photos/abc.jpg
 * @param {string} cloudinaryUrl
 * @returns {string|null}
 */
const extractPublicId = (cloudinaryUrl) => {
    if (!cloudinaryUrl || !cloudinaryUrl.includes("cloudinary.com")) {
        return null;
    }

    try {
        // Ambil bagian setelah "/upload/v{version}/" atau "/upload/"
        const match = cloudinaryUrl.match(
            /\/upload\/(?:v\d+\/)?(.+?)(?:\.\w+)?$/
        );
        return match ? match[1] : null;
    } catch {
        return null;
    }
};

module.exports = {
    uploadToCloudinary,
    deleteFromCloudinary,
    extractPublicId,
};
