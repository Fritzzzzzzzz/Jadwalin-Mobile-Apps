const {
    PrismaClient,
} = require("@prisma/client");

const prisma =
    new PrismaClient();

const bcrypt = require("bcryptjs");

const {
    uploadToCloudinary,
    deleteFromCloudinary,
    extractPublicId,
} = require("../services/cloudinary.service");

class UserController {

    async profile(
        req,
        res,
    ) {

        try {

            const user =
                await prisma.user.findUnique({

                    where: {
                        id: req.user.id,
                    },

                    select: {

                        id: true,
                        nama: true,
                        email: true,
                        fotoProfil: true,
                        role: true,
                        createdAt: true,

                    },

                });

            return res
                .status(200)
                .json({

                    success: true,

                    user,

                });

        } catch (error) {

            return res
                .status(500)
                .json({

                    success: false,

                    message: error.message,

                });

        }

    }

async updateProfile(
    req,
    res,
) {

    try {

        const {

            nama,

            email,

        } = req.body;

        if (email) {

        const emailDipakai =

        await prisma.user.findFirst({

            where: {

                email,

                NOT: {

                    id: req.user.id,

                },

            },

        });

        if (emailDipakai) {

        return res
            .status(400)
            .json({

                success: false,

                message:

                    "Email sudah digunakan",

            });

    }

}


        const updatedUser =
            await prisma.user.update({

                where: {
                    id: req.user.id,
                },

                data: {
                    nama,

                    email,
                },

                select: {

                    id: true,
                    nama: true,
                    email: true,
                    fotoProfil: true,
                    role: true,

                },

            });

        return res
            .status(200)
            .json({

                success: true,

                message: "Profile berhasil diperbarui",

                user: updatedUser,

            });

    } catch (error) {

        return res
            .status(500)
            .json({

                success: false,

                message: error.message,

            });

    }

}

async uploadFotoProfil(
    req,
    res,
) {

    try {

        if (!req.file) {
            return res
                .status(400)
                .json({
                    success: false,
                    message: "File foto wajib dipilih",
                });
        }

        // Ambil foto lama untuk dihapus dari Cloudinary
        const userLama = await prisma.user.findUnique({
            where: { id: req.user.id },
        });

        // Upload foto baru ke Cloudinary (dari buffer memoryStorage)
        const { url, publicId } = await uploadToCloudinary(
            req.file.buffer
        );

        // Simpan URL Cloudinary ke database
        const updatedUser = await prisma.user.update({
            where: { id: req.user.id },
            data: { fotoProfil: url },
            select: {
                id: true,
                nama: true,
                email: true,
                fotoProfil: true,
                role: true,
            },
        });

        // Hapus foto lama dari Cloudinary (non-blocking)
        if (userLama?.fotoProfil) {
            const oldPublicId = extractPublicId(userLama.fotoProfil);
            deleteFromCloudinary(oldPublicId);
        }

        return res
            .status(200)
            .json({
                success: true,
                message: "Foto profil berhasil diperbarui",
                user: updatedUser,
            });

    } catch (error) {

        return res
            .status(500)
            .json({
                success: false,
                message: error.message,
            });

    }

}

async changePassword(
    req,
    res,
) {

    try {

        const {

            oldPassword,

            newPassword,

        } = req.body;

        const user =

            await prisma.user
            .findUnique({

                where: {
                    id: req.user.id,
                },

            });

        const isMatch =

            await bcrypt.compare(

                oldPassword,

                user.password,

            );

        if (!isMatch) {

            return res
                .status(400)
                .json({

                    success: false,

                    message: "Password lama salah",

                });

        }

        const hashedPassword =

            await bcrypt.hash(
                newPassword,
                10,
            );

        await prisma.user
            .update({

                where: {
                    id: req.user.id,
                },

                data: {

                    password: hashedPassword,

                },

            });

        return res
            .status(200)
            .json({

                success: true,

                message: "Password berhasil diubah",

            });

    } catch (error) {

        return res
            .status(500)
            .json({

                success: false,

                message: error.message,

            });

    }

}

// GET ALL USER (ADMIN)
async getAllUser(
    req,
    res,
) {

    try {

        const users =
            await prisma.user.findMany({

                select: {

                    id: true,

                    nama: true,

                    email: true,

                    role: true,

                    createdAt: true,

                },

                orderBy: {

                    createdAt: "desc",

                },

            });

        return res
            .status(200)
            .json({

                success: true,

                totalUser:
                    users.length,

                data: users,

            });

    } catch (error) {

        return res
            .status(500)
            .json({

                success: false,

                message:
                    error.message,

            });

    }

}

}

module.exports =
    new UserController();
