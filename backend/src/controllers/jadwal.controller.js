const {
    PrismaClient,
} = require("@prisma/client");

const prisma =
    new PrismaClient();

class JadwalController {

    // GET JADWAL
    async getJadwal(
        req,
        res,
    ) {

        try {

            const jadwal =

                await prisma.jadwal
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

                    data: jadwal,

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

    // TAMBAH JADWAL
    async tambahJadwal(
        req,
        res,
    ) {

        try {

            const {

                namaMatkul,
                hari,
                jamMulai,
                jamSelesai,
                ruangan,

            } = req.body;

            const jadwal =

                await prisma.jadwal
                .create({

                    data: {

                        namaMatkul,
                        hari,
                        jamMulai,
                        jamSelesai,
                        ruangan,

                        userId: req.user.id,

                    },

                });

            return res
                .status(201)
                .json({

                    success: true,

                    message: "Jadwal berhasil ditambahkan",

                    data: jadwal,

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

    // EDIT JADWAL
    async editJadwal(
        req,
        res,
    ) {

        try {

            const id =
                Number(req.params.id);

            const {

                namaMatkul,
                hari,
                jamMulai,
                jamSelesai,
                ruangan,

            } = req.body;

            const jadwal =

                await prisma.jadwal
                .update({

                    where: {
                        id,
                    },

                    data: {

                        namaMatkul,
                        hari,
                        jamMulai,
                        jamSelesai,
                        ruangan,

                    },

                });

            return res
                .status(200)
                .json({

                    success: true,

                    message: "Jadwal berhasil diupdate",

                    data: jadwal,

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

    // HAPUS JADWAL
    async hapusJadwal(
        req,
        res,
    ) {

        try {

            const id =
                Number(req.params.id);

            await prisma.jadwal
                .delete({

                    where: {
                        id,
                    },

                });

            return res
                .status(200)
                .json({

                    success: true,

                    message: "Jadwal berhasil dihapus",

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
    new JadwalController();
