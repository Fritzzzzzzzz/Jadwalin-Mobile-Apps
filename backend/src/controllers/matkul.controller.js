const {
    PrismaClient,
} = require("@prisma/client");

const prisma =
    new PrismaClient();

class MatkulController {

    // GET MATKUL
    async getMatkul(
        req,
        res,
    ) {

        try {

            const matkul =

                await prisma.matkul
                .findMany({

                    where: {
                        userId: req.user.id,
                    },

                    orderBy: {
                        createdAt: "desc",
                    },

                });

            return res
                .status(200)
                .json({

                    success: true,

                    data: matkul,

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

    // TAMBAH MATKUL
    async tambahMatkul(
        req,
        res,
    ) {

        try {

            const {

                nama,
                dosen,
                semester,

            } = req.body;

            const matkul =

                await prisma.matkul
                .create({

                    data: {

                        nama,
                        dosen,
                        semester,

                        userId: req.user.id,

                    },

                });

            return res
                .status(201)
                .json({

                    success: true,

                    message: "Mata kuliah berhasil ditambahkan",

                    data: matkul,

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

    // EDIT MATKUL
    async editMatkul(
        req,
        res,
    ) {

        try {

            const id =
                Number(req.params.id);

            const {

                nama,
                dosen,
                semester,

            } = req.body;

            const matkul =

                await prisma.matkul
                .update({

                    where: {
                        id,
                    },

                    data: {

                        nama,
                        dosen,
                        semester,

                    },

                });

            return res
                .status(200)
                .json({

                    success: true,

                    message: "Mata kuliah berhasil diperbarui",

                    data: matkul,

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

    // HAPUS MATKUL
async hapusMatkul(
    req,
    res,
) {

    try {

        const id =
            Number(req.params.id);

        // CEK APABILA MASIH DIPAKAI TUGAS
        const tugasTerkait =
            await prisma.tugas.findFirst({

                where: {
                    matkulId: id,
                },

            });

        if (tugasTerkait) {

            return res
                .status(400)
                .json({

                    success: false,

                    message:
                        "Mata kuliah tidak dapat dihapus karena masih digunakan oleh tugas",

                });

        }

        await prisma.matkul
            .delete({

                where: {
                    id,
                },

            });

        return res
            .status(200)
            .json({

                success: true,

                message: "Mata kuliah berhasil dihapus",

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

}

module.exports =
    new MatkulController();
