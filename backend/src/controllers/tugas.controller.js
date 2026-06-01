const {
    PrismaClient,
} = require("@prisma/client");

const prisma =
    new PrismaClient();

// GET
exports.getTugas = async (req, res) => {

    try {

        const tugas =
            await prisma.tugas.findMany({

                where: {
                    userId: req.user.id,
                },

                include: {
                    matkul: true,
                },

                orderBy: {
                    createdAt: "desc",
                },

            });

        const hasil =
            tugas.map((item) => ({

                id: item.id,

                judul: item.judul,

                deskripsi: item.deskripsi,

                deadline: item.deadline,

                status: item.status,

                matkulId: item.matkulId,

                namaMatkul: item.matkul.nama,

            }));

        res.status(200).json({

            success: true,

            data: hasil,

        });

    } catch (error) {

        res.status(500).json({

            success: false,

            message: "Gagal mengambil data tugas",

        });

    }

};

// TAMBAH
exports.tambahTugas = async (req, res) => {

    try {

        const {

            judul,

            deskripsi,

            deadline,

            status,

            matkulId,

        } = req.body;

        const tugas =
            await prisma.tugas.create({

                data: {

                    judul,

                    deskripsi,

                    deadline,

                    status,

                    matkulId,

                    userId: req.user.id,

                },

            });

        res.status(201).json({

            success: true,

            data: tugas,

        });

    } catch (error) {

        res.status(500).json({

            success: false,

            message: "Gagal menambahkan tugas",

        });

    }

};

// EDIT
exports.editTugas = async (req, res) => {

    try {

        const id =
            parseInt(req.params.id);

        const {

            judul,

            deskripsi,

            deadline,

            status,

            matkulId,

        } = req.body;

        const tugas =
            await prisma.tugas.update({

                where: {
                    id,
                },

                data: {

                    judul,

                    deskripsi,

                    deadline,

                    status,

                    matkulId,

                },

            });

        res.status(200).json({

            success: true,

            data: tugas,

        });

    } catch (error) {

        res.status(500).json({

            success: false,

            message: "Gagal memperbarui tugas",

        });

    }

};

// HAPUS
exports.hapusTugas = async (req, res) => {

    try {

        const id =
            parseInt(req.params.id);

        await prisma.tugas.delete({

            where: {
                id,
            },

        });

        res.status(200).json({

            success: true,

            message: "Tugas berhasil dihapus",

        });

    } catch (error) {

        res.status(500).json({

            success: false,

            message: "Gagal menghapus tugas",

        });

    }

};