const express =
    require("express");

const router =
    express.Router();

const tugasController =
    require("../controllers/tugas.controller");

const authMiddleware =
    require("../middleware/auth.middleware");

// GET
router.get(

    "/",

    authMiddleware,

    tugasController.getTugas,

);

// TAMBAH
router.post(

    "/",

    authMiddleware,

    tugasController.tambahTugas,

);

// EDIT
router.patch(

    "/:id",

    authMiddleware,

    tugasController.editTugas,

);

// HAPUS
router.delete(

    "/:id",

    authMiddleware,

    tugasController.hapusTugas,

);

module.exports =
    router;