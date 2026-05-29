const express =
    require("express");

const router =
    express.Router();

const jadwalController =
    require("../controllers/jadwal.controller");

const authMiddleware =
    require("../middleware/auth.middleware");

// GET
router.get(

    "/",

    authMiddleware,

    jadwalController
    .getJadwal,

);

// TAMBAH
router.post(

    "/",

    authMiddleware,

    jadwalController
    .tambahJadwal,

);

// EDIT
router.patch(

    "/:id",

    authMiddleware,

    jadwalController
    .editJadwal,

);

// HAPUS
router.delete(

    "/:id",

    authMiddleware,

    jadwalController
    .hapusJadwal,

);

module.exports =
    router;
