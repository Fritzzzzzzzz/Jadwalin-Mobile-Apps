const express =
    require("express");

const router =
    express.Router();

const matkulController =
    require("../controllers/matkul.controller");

const authMiddleware =
    require("../middleware/auth.middleware");

// GET
router.get(

    "/",

    authMiddleware,

    matkulController
    .getMatkul,

);

// TAMBAH
router.post(

    "/",

    authMiddleware,

    matkulController
    .tambahMatkul,

);

// EDIT
router.patch(

    "/:id",

    authMiddleware,

    matkulController
    .editMatkul,

);

// HAPUS
router.delete(

    "/:id",

    authMiddleware,

    matkulController
    .hapusMatkul,

);

module.exports =
    router;
